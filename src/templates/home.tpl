<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="en" dir="ltr" xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Nuxeo Community Center</title>
  <link rel="icon" type="image/png"
        href="http://www.nuxeo.com/var/storage/community/favicon.png">
  <link rel="stylesheet"
        href="http://www.nuxeo.com/var/storage/community/community_common.css"
        type="text/css" media="screen"/>
  <link rel="stylesheet" href="/media/css/dev_center.css" type="text/css"
        media="screen">

  <!-- tweet -->
  <script language="javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"
          type="text/javascript"></script>
  <script language="javascript" src="/media/tweet/jquery.tweet.js" type="text/javascript"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      $(".tweet").tweet({
        username: ["sfermigier", "ebarroca", "nuxeo", "cherylmckinnon", "ogrisel", "efge"],
        join_text: "auto",
        avatar_size: 32,
        count: 6,
        loading_text: "loading tweets..."
      });
    });
  </script>
  <link href="/media/tweet/jquery.tweet.css" media="all" rel="stylesheet" type="text/css"/>

  <script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(["_setAccount", "UA-81135-9"]);
    _gaq.push(["_setAllowLinker", true]);
    _gaq.push(["_setDomainName", ".nuxeo.org"]);
    _gaq.push(["_setAllowHash", false]);
    _gaq.push(["_trackPageview"]);

    (function() {
      var ga = document.createElement("script");
      ga.type = "text/javascript";
      ga.async = true;
      ga.src = ("https:" == document.location.protocol ? "https://ssl" : "http://www") + ".google-analytics.com/ga.js";
      var s = document.getElementsByTagName("script")[0];
      s.parentNode.insertBefore(ga, s);
    })();
  </script>


</head>

<body>
<div class="header">
  <div class="logoHome">
    <a href="/" title="Home">
      <img src="http://www.nuxeo.com/var/storage/community/nuxeo_logo.png"
           alt="Nuxeo Community" align="left" height="36">
    </a>
  </div>
  <div class="externalLinks">
    <ul>
      <li class="active"><a href="/">Home</a></li>
      <li><a href="http://forum.nuxeo.org/">Forums</a></li>
      <li><a href="http://doc.nuxeo.com/">Documentation</a></li>
      <li><a href="http://blogs.nuxeo.com/">Blogs</a></li>
    </ul>
  </div>
</div>

<div class="content">
  <h1>Welcome to the Nuxeo Community</h1>

  <div class="main">
    <div class="intro">
      <!--<h2>Who are we ?</h2>-->
      <p>Nuxeo is an <b>Open Source Platform</b> for <b>Enterprise Content
        Management</b> enabling architects and developers to build, deploy
        and run the best <b>content-driven applications</b> in an <b>easy way</b>.</p>

      <p>Nuxeo applications can be configured with no programming experience, and extended using
        <b>standard</b> Java EE technologies.
        <!-- If you are interested in our products and services, take a look at
    <a href="http://www.nuxeo.com/">Nuxeo's corporate website</a>. -->
      </p>
    </div>

    <div class="feedsBlock">
      <h2>Community Activity</h2>

      <div class="events">
        <!--
        <div class="newEvents">
          <p>3 new events available</p>
        </div>
        -->

        {% for event in events %}
        <div class="event">
          <div class="type jira"><img src="/media/icons/{{ event.type }}.png"
                                      alt="{{ event.alt_type }}"/></div>
          <div class="description">
            <span>{{ event.header() }}</span>
            <span class="when">{{ g.age(event.created) }}</span>

            <p><a href="{{ event.url }}">{{ event.title }}</a></p>
          </div>
          <!--div class="share">
            <a class="link" href="home.tpl#"><img src="/media/icons/email.png" alt="Email it"/></a>
            <a class="link" href="home.tpl#"><img src="/media/icons/link.png" alt="Link it"/></a>
            <a class="link" href="home.tpl#"><img src="/media/icons/twitter.png" alt="Twitt it"/></a>
            <a class="link" href="home.tpl#"><img src="/media/icons/facebook.png" alt="Facebook it"/></a>
          </div-->
        </div>
        {% endfor %}
      </div>
    </div>
  </div>

  <div class="right">

    {% if is_newbie %}
    <div class="kick start">
      <h3>New to Nuxeo ?</h3>

      <div class="list">
        <p>Take a look at the <a
                href="http://doc.nuxeo.com/">Documentation
          Center</a>, to read before you install Nuxeo products.</p>
      </div>
    </div>
    {% endif %}

    <div class="subscribe">
      <h3>Stay Updated</h3>

      <div class="list">
        <p>
          <img src="http://nuxeo.typepad.com/img/feed.png" alt=""/><a href="/rss">Subscribe to Feed</a>
        </p>

        <!--p>
          <img src="http://nuxeo.typepad.com/img/twitter.png" alt=""/><a href="http://twitter.com/nuxeoorg/">Follow us
          on Twitter</a>
        </p-->
      </div>
    </div>

    <div class="downloads">
      <h3>Download Nuxeo Software</h3>
      <div class="list">
        <ul>
          <li>
            <a href="http://www.nuxeo.com/en/downloads/download-dm-form">nuxeo
              <span class="dm"> • </span> DM</a> - Document
            Management
          </li>
          <li>
            <a href="http://www.nuxeo.com/en/downloads/download-dam-form">nuxeo
              <span class="dam"> • </span>DAM</a> - Digital Asset
            Management
          </li>
          <li>
            <a href="http://www.nuxeo.com/en/downloads/download-cmf-form">nuxeo
              <span class="cmf"> • </span>CMF</a> - Case
            Management Framework
          </li>
          <li>
            Explore the <a href="https://connect.nuxeo.com/nuxeo/site/marketplace/">nuxeo<span
                  class="marketplace"> • </span><span>Market</span>place</a>
            to discover additional packages (add-ons, extentions, business templates)
            to extend your Nuxeo platform or application!
          </li>
          <li>
            Or learn how to <a href="https://doc.nuxeo.com/display/KB/Configuring+Nuxeo+Debian+or+Ubuntu+repositories">install Nuxeo DM on Debian/Ubuntu</a>,
            <!--or how to build the platform <a href="">from the sources</a> -->
          </li>
        </ul>
      </div>
    </div>

    <div class="documentation">
      <h3>Discover and Learn</h3>

      <div class="list">
        <ul>
          <li>
            <a href="http://doc.nuxeo.com/display/NXDOC/Nuxeo+Enterprise+Platform+overview">
              Discover the Nuxeo EP architecture</a>
          </li>
          <li>
            <a href="http://doc.nuxeo.com/display/NXDOC/Installation+and+Administration+Guide">
              Learn how to install and administer Nuxeo EP</a>
          </li>
          <li>
            <a href="http://doc.nuxeo.com/display/NXDOC/Customizing+Nuxeo">
              Learn how to customize Nuxeo EP</a>
          </li>
          <li>
            <a href="http://doc.nuxeo.com/">
              Or browse the full documentation site</a>
          </li>
        </ul>
      </div>
    </div>

    <div class="community">
      <h3>Get Involved</h3>

      <div class="list">
        <ul>
          <li>
            Join the <a href="http://lists.nuxeo.com/mailman/listinfo/ecm">Nuxeo users</a> mailing list or the <a
                  href="http://forum.nuxeo.org/">Forum</a>
          </li>
          <li>
            Look at the outstanding issues and tasks in the <a href="http://jira.nuxeo.org/">Jira issue tracker</a> and
            contribute to the <a href="https://jira.nuxeo.org/browse/NXP?report=com.atlassian.jira.plugin.system.project:roadmap-panel">roadmap</a>.
          </li>
          <li>
            Check out the <a href="https://doc.nuxeo.com/display/CORG/Getting+the+Nuxeo+source+code">Source
            Code</a>
          </li>
          <li>
            Learn <a href="https://doc.nuxeo.com/display/NXDOC/Nuxeo+contributors+welcome+page">how to become a
            Nuxeo contributor</a>
          </li>
        </ul>
      </div>
    </div>

    <!--div class="marketplace">
      <h3>Add-ons, extensions and business templates</h3>

      <div class="list">
        <p>Explore the <a
                href="https://connect.nuxeo.com/nuxeo/site/marketplace/">nuxeo<span
                class="marketplace"> • </span><span>Market</span>place</a>
          to discover additional packages to extend your Nuxeo platform or application!</p>
      </div>
    </div-->

    <div class="tweets">
      <h3>Latest Tweets from the Team</h3>

      <div class="tweet"></div>
    </div>

  </div>

</div>

<div style="clear:both;"></div>

<div class="foot">
  <div class="FooterContainer">
    <div class="FootLinks">
      <ul>
        <li><h6>More</h6>
          <ul>
            <li><a href="http://doc.nuxeo.com/">documentation</a>
            </li>
            <li><a href="http://blogs.nuxeo.com/">blogs</a>
            </li>
            <li>
              <a href="http://www.nuxeo.com/en/resources/videos-on-demand/">videos</a></li>
          </ul>
        </li>
      </ul>
      <ul>
        <li><h6>About Nuxeo</h6>
          <ul>
            <li><a href="http://www.nuxeo.com/">nuxeo.com</a>
            </li>
            <li><a href="http://www.nuxeo.org/">community</a>
            </li>
            <li><a href="http://www.nuxeo.com/en/about/careers/offers/">jobs</a></li>
          </ul>
        </li>
      </ul>
      <ul>
        <li><h6>Our products</h6>
          <ul>
            <li><a href="http://www.nuxeo.com/en/products/document-management/"
                    >Document Management (DM)</a></li>
            <li><a href="http://www.nuxeo.com/en/products/dam/"
                    >Digital Asset Management (DAM)</a></li>
            <li><a href="http://www.nuxeo.com/en/products/case-management/"
                    >Case Management Framework (CMF)</a></li>
          </ul>
        </li>
      </ul>
      <ul>
        <li><h6>Our services</h6>
          <ul>
            <li><a href="http://www.nuxeo.com/en/subscription/connect/">support</a></li>
               <!-- was: nuxeo <span class="connect">•</span> Connect -->
            <li><a href="http://www.nuxeo.com/en/services/training/">training</a></li>
            <li><a href="http://www.nuxeo.com/en/services/consulting/">consulting</a></li>
          </ul>
        </li>
      </ul>
      <ul>
        <li><h6>Follow us</h6>
          <ul>
            <li><a href="http://twitter.com/nuxeo/"><span
                    class="twitter">twitter</span> /nuxeo</a></li>
            <li>
              <a href="http://www.linkedin.com/groupsDirectory?itemaction=mclk&amp;anetid=43314&amp;impid=&amp;pgkey=anet_search_results&amp;actpref=anetsrch_name&amp;trk=anetsrch_name&amp;goback=%2Egdr_1288215250735_1"
                      ><span class="linkedIn">linkedIn</span> /Nuxeo
                Community</a></li>
            <li>
              <a href="http://www.facebook.com/group.php?gid=5568495138">
                <span class="facebook">facebook</span> /Nuxeo
                Users</a></li>
          </ul>
        </li>
      </ul>
    </div>
    <div class="Contact">
      ©2010-2011 <span class="nuxeoLogo">nuxeo</span>
    </div>
  </div>
</div>

</body>
</html>