<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->  
<?lua local conf = require "conf.conf" ?>
<head>
    <title><%=page.title%></title>
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="The Lua Community Blog">
    <meta name="author" content="">    
    <link rel="shortcut icon" href="favicon.ico">  
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,300italic,400italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'> 
    <!-- Global CSS -->
    <link rel="stylesheet" href="/themes/devAid/assets/plugins/bootstrap/css/bootstrap.min.css">
    <!-- Plugins CSS -->    
    <link rel="stylesheet" href="/themes/devAid/assets/plugins/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="/themes/devAid/assets/plugins/prism/prism.css">
    <!-- Theme CSS -->  
    <link id="theme-style" rel="stylesheet" href="/themes/devAid/assets/css/styles.css">
    <!-- RSS -->
    <link rel="alternate" type="application/rss+xml" href="http://lua.space/rss.xml">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head> 

<body data-spy="scroll">
    
    <!---//Facebook button code-->
    <div id="fb-root"></div>
    <script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
    
    <!-- ******HEADER****** --> 
    <header id="header" class="header">  
        <div class="container"> 

            <h1 class="logo pull-left">
                <img height='42px'style="margin-right: 7px" src='/pub/img/lualogo.png'/> 
                <a href="/">
                    <span class="logo-title"><%= conf.sailor.app_name %></span>
                </a>   
            </h1><!--//logo--> 
                 
        
            <div class="pull-right">
                <nav id="main-nav" class="main-nav navbar-right" role="navigation">
                    <div class="navbar-header">
                        <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button><!--//nav-toggle-->
                    </div><!--//navbar-header-->            
                    <div class="navbar-collapse collapse" id="navbar-collapse">
                        <ul class="nav navbar-nav">
                            <li class="nav-item"><a href="/">Home</a></li>
                            <li class="nav-item"><a href="/about">About</a></li>
                            <li class="nav-item dropdown"><a class="dropdown-toggle" data-toggle="dropdown"  role="button" aria-haspopup="true" aria-expanded="false" href="#">Categories</a>
                                <ul class="dropdown-menu">
                                  <?lua for _,c in ipairs((categories or {})) do ?>
                                    <li><a href="/<%=c%>"><%=(c:gsub("^%l", string.upper))%></a></li>
                                  <?lua end ?>
                                </ul>
                              </li>
                            <li class="nav-item"><a href="/archive">Archive</a></li>
                            <li class="nav-item"><a href="/jobs">Jobs</a></li>
                        </ul><!--//nav-->
                    </div><!--//navabr-collapse-->
                </nav><!--//main-nav-->
            </div>
            <div id="blog-subtitle" class="logo-subtitle center-block">
                <a href="/">
                    The Lua Community Blog
                </a>
            </div>  
        </div>
    </header><!--//header-->

    <section id="news" class="news section">
        <div class="container">
            <div class="news-inner">
                <strong>Important News:</strong> 04/05/2016 - <a href="http://lua.space/general/community-news-2">Community news #2</a>
                <br/>
                <strong>Important News:</strong> 29/12/2015 - <a href="http://lua.space/general/community-news-1-and-meetup-at-fosdem">Community news #1 and meetup at FOSDEM</a>
	           <br/>            
               <strong>Important News:</strong> 11/12/2015 - <a href="http://lua.space/general/blog-opening-and-contribution-guide">Blog opening and contribution guide</a>
            </div>
        </div>
    </section>
    

    <!-- ******DOCS****** --> 
    <section id="docs" class="docs section">
        <div class="container">
            <div class="docs-inner">
            <link rel="stylesheet" href="/pub/highlight/styles/monokai-sublime.css">
            <script src="/pub/highlight/highlight.pack.js"></script>

            <script>
            hljs.configure({
              languages: ['lua','javascript','html','bash','yaml']
            });
            hljs.initHighlightingOnLoad();
            </script>
            <noscript>
              <div>
                <center>
                  <small>Warning: Enabling JavaScript is required to see the syntax highlight of the code on this page</small>
                </center>
              </div>
            </noscript>
            {{content}}
            </div><!--//docs-inner-->         
        </div><!--//container-->
    </section><!--//features-->
    
    <!-- ******LICENSE****** 
    <section id="license" class="license section">
        <div class="container">
            <div class="license-inner">
            <h2 class="title text-center">License</h2>
                <div class="info">
                    <p>This Bootstrap theme is made by UX designer <a href="https://www.linkedin.com/in/xiaoying" target="_blank">Xiaoying Riley</a> at 3rd Wave Media for developers and is <strong>100% FREE</strong> under the <a href="https://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Attribution 3.0 License (CC BY 3.0)</a></p>
                    <p><strong>[Tip for developers]:</strong> If your project is open source, you might want to put a <a href="https://www.paypal.com/us/cgi-bin/?cmd=_donate-intro-outside" target="_blank">PayPal "Donate" button</a> below so your users can express their gratitude. If your project is commercial, you can put a <a href="https://www.paypal.com/us/cgi-bin/webscr?cmd=_singleitem-intro-outside" target="_blank">PayPal "Buy Now" button</a> instead.</p>
                </div>
                <div class="cta-container">
                    <div class="speech-bubble">                    
                        <p class="intro">If you are feeling generous and want to show your support to Xiaoying, you can buy her a beer or coffee via the PayPal donate button below. :)</p>
                        <div class="icon-holder  text-center"><i class="fa fa-smile-o"></i></div>
                    </div>
                    <div class="btn-container  text-center">
                      
                        <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                        <input type="hidden" name="cmd" value="_s-xclick">
                        <input type="hidden" name="hosted_button_id" value="Y46LJNXGAVVWW">
                        <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
                        <img alt="" border="0" src="https://www.paypalobjects.com/en_GB/i/scr/pixel.gif" width="1" height="1">
                        </form>
                                            
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    --> 
    
    <!-- ******CONTACT****** --> 
    <section id="contact" class="contact section has-pattern">
        <div class="center-block" style="text-align:center">
            <p><a href="http://lua.space/rss.xml">RSS</a></p>
            <p><a href="https://feedburner.google.com/fb/a/mailverify?uri=Luaspace&amp;loc=en_US">Subscribe to Lua.Space by Email</a></p>
            <p><a href="http://feeds.feedburner.com/Luaspace" target="_blank"><img src="http://feeds.feedburner.com/~fc/Luaspace?bg=99CCFF&amp;fg=444444&amp;anim=0" height="26" width="88" style="border:0" alt="" /></a></p>
        </div>
        <!--
        <div class="container">
            <div class="contact-inner">
                <div class="info text-center">
                    <h4 class="sub-title">Get Connected</h4>
                    <ul class="social-icons list-inline">
                        <li><a href="https://twitter.com/3rdwave_themes" target="_blank"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="https://www.facebook.com/3rdwavethemes" target="_blank"><i class="fa fa-facebook"></i></a></li>
                        <li><a href="https://www.linkedin.com/in/xiaoying"><i class="fa fa-linkedin"></i></a></li>
                        <li><a href="http://instagram.com/xyriley"><i class="fa fa-instagram"></i></a></li>  
                        <li><a href="https://dribbble.com/Xiaoying"><i class="fa fa-dribbble"></i></a></li>   
                        <li class="last"><a href="mailto: hello@3rdwavemedia.com"><i class="fa fa-envelope"></i></a></li>              
                    </ul>
                </div>
            </div>
        </div>-->
    </section><!--//contact-->  
      
    <!-- ******FOOTER****** --> 
    <footer class="footer">
        <div class="container text-center">
            <small class="copyright">© <%= os.date('%Y') %> <a href="/">Lua Space</a> by <a href="http://etiene.net">Etiene Dalcol</a>. Designed with <i class="fa fa-heart"></i> by <a href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers. <i class="fa fa-bolt"></i>  Powered by <i class="fa fa-moon-o"></i><a href="http://sailorproject.org/">Sailor Framework</a> and <a href="http://lua.org/">Lua</a>.</small>
            <div class="pull-right">
            <small><a href="https://github.com/Etiene/lua.space">Source</a></small>
        </div>
        </div><!--//container-->

    </footer><!--//footer-->
     
    <!-- Google analytics -->
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-39528524-3', 'auto');
      ga('send', 'pageview');
    </script>

    <!-- Javascript -->          
    <script type="text/javascript" src="/themes/devAid/assets/plugins/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/themes/devAid/assets/plugins/jquery-migrate-1.2.1.min.js"></script>    
    <script type="text/javascript" src="/themes/devAid/assets/plugins/jquery.easing.1.3.js"></script>   
    <script type="text/javascript" src="/themes/devAid/assets/plugins/bootstrap/js/bootstrap.min.js"></script>     
    <script type="text/javascript" src="/themes/devAid/assets/plugins/jquery-scrollTo/jquery.scrollTo.min.js"></script> 
    <script type="text/javascript" src="/themes/devAid/assets/plugins/prism/prism.js"></script>    
    <script type="text/javascript" src="/themes/devAid/assets/js/main.js"></script>
    <script id="dsq-count-scr" src="//luaspace.disqus.com/count.js" async></script>       
</body>
</html> 

