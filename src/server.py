#!env/bin/python

from flask import *
from persistence import *
import plugins
import time

plugins.init()

# Constants (might go into a config file)
MAX_EVENTS = 20


# Use /media instead of default /static because /static is already used.
app = Flask(__name__, static_path='/media')


@app.before_request
def connect_db():
    g.db = get_db_connection()
    g.pm = get_pm()
    g.age = age


@app.route('/')
def home():
    try:
        visits = int(request.cookies.get('visits', 0)) + 1
    except ValueError:
        visits = 0
    is_newbie = visits < 3

    c = g.db.cursor()
    c.execute("""select * from event
                 order by created desc limit %s""" % MAX_EVENTS)
    events = [ g.pm.revive(c, row) for row in c.fetchall() ]
    response = make_response(render_template("home.tpl", events=events, is_newbie=is_newbie))

    response.set_cookie('visits', visits, 60*60*24*365*10)
    return response


def age(t):
    now = int(time.time())
    dt = now - t
    if dt < 60:
        return "%d seconds ago" % dt
    if dt < 60*2:
        return "about 1 minute ago"
    if dt < 60*60:
        return "%d minutes ago" % (dt/60)
    if dt < 60*60*2:
        return "about 1 hour ago"
    if dt < 60*60*24:
        return "about %d hours ago" % (dt/60/60)
    if dt < 60*60*24*2:
        return "yesterday"
    if dt < 60*60*24*30:
        return "about %d days ago" % (dt/60/60/24)
    if dt < 60*60*24*30*2:
        return "last month"
    if dt < 60*60*24*365:
        return "about %d months ago" % (dt/60/60/24/30)
    return "%d years ago" % (dt/60/60/24/365)


if __name__ == '__main__':
    app.run(debug=True)

