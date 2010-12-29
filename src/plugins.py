import time, re
import feedparser
import persistence

PM = persistence.get_pm()


# Abstract base classes

class Source(object):
    type = ""

    def crawl(self):
        pass


class Event(object):
    table_name = "event"

    type = ""
    uid = title = url = author = ""
    source = None
    created = 0

    def get_title(self):
        pass

    def post_init(self):
        pass


#
# RSS / Atom abstract classes
#
class FeedEvent(Event):
    pass


class Feed(Source):
    """Abstract base class: do not instantiate."""

    feed_url = None

    def crawl(self):
        d = feedparser.parse(self.feed_url)
        self.source_url = d.href
        self.home_url = d.feed.link
        self.title = d.feed.title
        entries = d.entries

        events = [ self.make_event(entry) for entry in entries ]
        for event in events:
            PM.save(event)

    def make_event(self, entry):
        event_class = globals()[self.__class__.__name__ + "Event"]
        event = apply(event_class)
        event.title = entry.title
        event.uid = entry.id
        event.url = entry.link
        event.created = time.mktime(entry.updated_parsed)
        event.author = entry.get("author", "unknown")
        event.post_init()
        return event


#
# Instantiable sources
#

BLOG_AUTHORS = {
    "Stefane Fermigier": "Stefane Fermigier",
    "CherylMcKinnon": "Cheryl McKinnon",
    "Nuxeo": "Nuxeo Team",
    "eric's blog": "Eric Barroca",
    "My job things": "Roland Benedetti",
    "Sun Seng David TAN": "Sun Tan",
}

class BlogsEvent(Event):
    type = "blogpost"

    def header(self):
        return "New blog post by %s" % self.author

class Blogs(Feed):
    feed_url = "http://blogs.nuxeo.com/atom.xml"

#

class CorpNewsEvent(Event):
    type = "news"

    def post_init(self):
        self.author = "Nuxeo Corp"

    def header(self):
        return "New Corporate announcement, on <a href='http://www.nuxeo.com/'>nuxeo.com</a>"

class CorpNews(Feed):
    feed_url = "http://www.nuxeo.com/nxc/rssfeed/news"

#

class BuzzEvent(Event):
    type = "buzz"

    def post_init(self):
        self.author = "Nuxeo Corp"

    def header(self):
        return "Buzz about us, displayed on <a href='http://www.nuxeo.com/'>nuxeo.com</a>"

class Buzz(Feed):
    feed_url = "http://www.nuxeo.com/en/rss/feed/buzz"

#

class ForumEvent(Event):
    type = "forum"

    def post_init(self):
        m = re.match(r"http://forum.nuxeo.org/\./mv/msg/([0-9]+)/([0-9]+)", self.url)
        tid = int(m.group(1))
        mid = int(m.group(2))
        self.url = "http://forum.nuxeo.org/?t=msg&th=%d&goto=%d&#msg_%d" % (tid, mid, mid)

    def header(self):
        return "New message on the forum, by %s" % (self.author,)

class Forum(Feed):
    feed_url = "http://forum.nuxeo.org/feed.php?mode=m&l=1&basic=1"

#

class DocumentationEvent(Event):
    type = "documentation"

    def header(self):
        return "Documentation change, by %s" % self.author

class Documentation(Feed):
    feed_url = "https://doc.nuxeo.com/spaces/createrssfeed.action?spaces=conf_all" + \
        "&types=page&types=comment&types=blogpost&types=mail&types=attachment" + \
        "&maxResults=15&publicFeed=true"

#

class JiraEvent(Event):
    type = "jira"

    def header(self):
        return "Jira issue change, by %s" % self.author

class Jira(Feed):
    feed_url = "http://jira.nuxeo.org/sr/jira.issueviews:searchrequest-rss/10915/SearchRequest-10915.xml?tempMax=10"


#############################################################################

SOURCES = ["Blogs", "Forum", "CorpNews", "Buzz", "Jira", "Documentation"]
sources = [ apply(globals()[source]) for source in SOURCES ]

def init():
    pm = persistence.get_pm()
    for source in SOURCES:
        c = globals()[source + "Event"]
        pm.register(c)

