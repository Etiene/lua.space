<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title><%= page.title %></title>
    <?lua 
      if post and post.url then ?>
      <link rel="canonical" href="<%=post.url%>" />
    <?lua end?>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
		<link href="/themes/<%=page.theme%>/css/bootstrap.min.css" rel="stylesheet"/>
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<link href="/themes/<%=page.theme%>/css/styles.css" rel="stylesheet"/>
	</head>
	<body>
<nav class="navbar navbar-static">
    <div class="container">
      <a class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse">
        <span class="glyphicon glyphicon-chevron-down"></span>
      </a>
      <div class="nav-collapse collase">
        <ul class="nav navbar-right navbar-nav">  
          <li><a href="/">Home</a></li>
          <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"  role="button" aria-haspopup="true" aria-expanded="false" href="#">Categories</a>
            <ul class="dropdown-menu">
              <?lua for _,c in ipairs((categories or {})) do ?>
                <li><a href="/<%=c%>"><%=(c:gsub("^%l", string.upper))%></a></li>
              <?lua end ?>
            </ul>
          </li>
          <li><a href="/about">About</a></li>
        </ul>
        <!--
        <ul class="nav navbar-right navbar-nav">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-search"></i></a>
            <ul class="dropdown-menu" style="padding:12px;">
                <form class="form-inline">
                   <div class="input-group">
                     <input type="text" class="form-control" placeholder="Search">
                     <div class="input-group-btn">
     			       <button type="submit" class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
                     </div>
                  </div>
                </form>
              </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> <i class="glyphicon glyphicon-chevron-down"></i></a>
            <ul class="dropdown-menu">
              <li><a href="#">Login</a></li>
              <li><a href="#">Profile</a></li>
              <li class="divider"></li>
              <li><a href="#">About</a></li>
             </ul>
          </li>  
        </ul>-->
      </div>		
    </div>
</nav><!-- /.navbar -->

<header class="masthead">
  <div class="container">
    <div class="row">
      <div class="col col-sm-6">
        
        <h1>
          <a href="/" title="Lua.Space">
            <img style='margin-right:10px' align='left' height='80px'src='/pub/img/lualogo.png'/>
            <%= page.title %>
         </a>
          <p class="lead">The unofficial Lua blog</p>
        </h1>
       
      </div>
      <!--
      <div class="col col-sm-6">
        <div class="well pull-right">
          <img src="//placehold.it/280x100/E7E7E7">        
        </div>
      </div>
      -->
    </div>
  </div>
  <!--
  <div class="container">
	<div class="row">
      <div class="col col-sm-12">
        
        <div class="panel">
        <div class="panel-body">
          You may want to put some news here  <span class="glyphicon glyphicon-heart-empty"></span>
        </div>
        </div>
        
      </div>
  	</div>
  </div>
  -->
</header>

<!-- Begin Body -->
<div class="container">
	<div class="row">
  			<div class="col col-sm-3">
              	<div id="sidebar">
      			<ul class="nav nav-stacked">
                    <li><h3 class="highlight">Channels <i class="glyphicon glyphicon-dashboard pull-right"></i></h3></li>
                  	<li><a href="#">Link</a></li>
          			<li><a href="#">Link</a></li>
				</ul>
                <div class="accordion" id="accordion2">
                    <div class="accordion-group">
                        <div class="accordion-heading">
                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
                                Accordion
                            </a>
                        </div>
                        <div id="collapseOne" class="accordion-body collapse in">
                            <div class="accordion-inner">
                              <p>There is a lot to be said about RWD.</p>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-group">
                            <div class="accordion-heading">
                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
                                    Accordion
                                </a>
                            </div>
                            <div id="collapseTwo" class="accordion-body collapse">
                                <div class="accordion-inner">
                                  <p>Use @media queries or utility classes to customize responsiveness.</p>
                                </div>
                            </div>
                        </div>
               	</div>
               </div>
      		</div>  
      		<div class="col col-sm-9">
              <div class="panel">
                <link rel="stylesheet" href="/pub/highlight/styles/monokai-sublime.css">
                <script src="/pub/highlight/highlight.pack.js"></script>

                <script>
                hljs.configure({
                  languages: ['lua','javascript']
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
              	<hr>
              	<small> © <%= os.date('%Y') %> <a href="/">Lua Space</a> by <a href="http://etiene.net">Etiene Dalcol</a>. Template by <a href="http://bootply.com/">Bootply</a>. Powered by <a href="http://sailorproject.org/">Sailor Framework</a> and <a href="http://lua.org/">Lua</a>.</small>
              	<hr>
             	</div>
      	</div> 
  	</div>
</div>



	<!-- script references -->
		<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		<script src="/themes/flathood/js/bootstrap.min.js"></script>
		<script src="/themes/flathood/js/scripts.js"></script>
    <script id="dsq-count-scr" src="//luaspace.disqus.com/count.js" async></script>
	</body>
</html>