## Why using Lua in web development

Lua is an easy and elegant programming language that is recorded as the fastest interpreted language on many benchmarks and proven success in other domains of development such as games and embedded systems. 
It has good language semantics, awesome documentation, it is very readable and has very powerful mechanisms such as metatables, proper tail calls and many other features that are worth taking a look.
It's a great technical candidate for being a PHP replacement. Lua is being used in production for web development for a long time with success by websites such as [TaoBao](https://en.wikipedia.org/wiki/Taobao), 
a chinese online shopping website that [ranks 11 globally on Alexa](http://www.alexa.com/siteinfo/taobao.com) with over 760 million product listings, [Cloudfare](https://www.cloudflare.com/), 
[Rackspace](http://www.rackspace.com/), [itch.io](http://itch.io/), [mail.ru](http://mail.ru), 
[Mashape/Kong](http://blog.mashape.com/kong-architectural-choices-the-api-layer-for-microservices/), 
[Shopify](https://www.shopify.com/technology/17605604-announcing-go-lua) and others. 
[Wikipedia](http://blog.wikimedia.org/2013/03/11/lua-templates-faster-more-flexible-pages/) uses Lua for its template system.
This blog itself is also running on Lua.
  

<center>
<img src="/pub/img/taobao.png" height="100px"/>
<img src="/pub/img/shopify.png" height="100px"/>
<img src="/pub/img/mashape.png" height="100px"/>
<img src="/pub/img/wikipedia.jpg" height="100px"/>
</center>
  

A common complaint of using Lua, though, is the ecosystem, which is exactly why PHP is so popular. 
PHP is pervasive and there are many tools and tutorials written for it, so the development becomes easy also for reasons that are not technical, specially due to a large & friendly community.

However, the landscape for Lua is changing and now the ecosystem is growing rapidly (a feat I partially attritube to the merge of [LuaRocks](http://luarocks.org) and MoonRocks).
We have been able to write in Lua for the web for years and now we can find a large number of tools available. 
You can write in Lua for major webservers such as [Apache](http://modlua.org/) and [Nginx/OpenResty](https://openresty.org/) ([top 2 web servers used](http://w3techs.com/technologies/overview/web_server/all)), and also others such as [Lighttpd](https://www.lighttpd.net/) and pure Lua stand-alone servers like [Xavante](http://keplerproject.github.io/xavante/) or [Pegasus](https://github.com/EvandroLG/pegasus.lua).
Highlights go to Nginx server, which allows to develop blazing fast non-blocking asynchronousapps written in a sequential fashion keeping the event-driven logic hidden inside Nginx. 

There are also many frameworks available, which this post aims to compare. I am myself the lead developer of one them (Sailor) and I haven't developed using all the options I'm listing, but I hope this is a fairly decent comparison. 
You can make a [pull request to this article](https://github.com/Etiene/lua.space/blob/master/posts/webdev/the-best-lua-web-frameworks.md) to make it better.

Something important to note, there is one advantage that is not listed because it applies to all of them, which is the good performance and small footprint. This is even more enhanced on tools that support LuaJIT.

##Web Frameworks Comparison
##Micro frameworks
Cousins in other languages: Flask (Python), Sinatra (Ruby)

###Lapis
**Website**: [leafo.net/lapis](http://leafo.net/lapis/)

**Source**: [github.com/leafo/lapis](https://github.com/leafo/lapis)

**License**: MIT

Lapis is a framework for OpenResty developed by the same creator of the MoonScript language and [itch.io](http://itch.io)

**Pros:**

 - LuaRocks install
 - Excellent documentation
 - Supports OpenResty
 - Nice templating system
 - Stable and well-tested, being used in production by a number of projects
 - Active development
 - Supports MoonScript and LuaJIT
 - Popular with a growing community

**Cons:**

 - Does not support a big variety of webservers and databases (OpenResty with Postgres and MySQL only, but that should be enough for most projects)
 - Does not support Lua >= 5.2 (As it supports LuaJIT it might support Lua5.1, though)

##MVC frameworks
Cousins in other languages: Zend (PHP), Yii (PHP), Rails (Ruby), Django (Python)
###Sailor
**Website**: [sailorproject.org](http://sailorproject.org)

**Source**: [github.com/Etiene/sailor](https://github.com/Etiene/sailor)

**License**: MIT

Sailor is a fairly new framework that began as an independent project by the same maintainer of this blog and has been mentored under Google Summer of Code

**Pros:**

 - LuaRocks install
 - Works with a variety of databases through the LuaSQL library and native OpenResty MySQL api (for non-blocking operations)
 - Works on a big variety of webservers, including Nginx/OpenResty
 - Integrated with Lua->JS VMs allowing to use Lua for the front-end as well
 - Extensive and well-put documentation
 - Well tested and in active development
 - Compatible with Lua 5.1, 5.2 and LuaJIT
 - The maintainer constantly tries to reach communities outside of the Lua bubble
 
**Cons:**

 - Small community
 - It's still in alpha version, things change fast, it's being used in production only by a small number of projects
 - Single person project with not many active contributors

###Orbit

**Website**: [keplerproject.github.io/orbit](http://keplerproject.github.io/orbit/)

**Source**: [github.com/keplerproject/orbit](https://github.com/keplerproject/orbit)

**License**: GPL

Orbit is maybe the oldest and most stable framework written for Lua developed by a group of researchers during the Kepler project

**Pros:**

 - LuaRocks install
 - Stable
 - Works with a variety of databases through the LuaSQL library
 - It's being used in production by a number of projects
 - Clear documentation
 - Well supported by the Lua community, questions about it on the Lua list will most likely be answered
**Cons:**

 - Does not run on a big variety of web servers
 - The development seems fairly abandoned with no recent updates
 - Not known outside the Lua community
 - Compatible with Lua 5.1 only

##Event-driven frameworks
Cousins in other languages: Node.js (Javascript)
###Luvit
**Website**: [luvit.io](https://luvit.io/)

**Source**:[github.com/luvit/luvit](https://github.com/luvit/luvit)

**License**: Apache2.0

Luvit is a port of node.js to Lua that claims to be 2-4 times faster and save up to 20 times memory

**Pros:**

 - Popular
 - Stable and very well tested
 - Very active development with a fair number of contributors
 - Active community with chats, mail list and a blog
 - Asynchronous I/O
 - Has a number of packages to extend it

**Cons:**

 - No LuaRocks install
 - Awful documentation, a quick look can't tell how it really works, or which versions of Lua and which databases it supports
 - Not friendly to developers who aren't already familiarized with Node.js

###TurboLua
**Website**: [turbolua.org](http://turbolua.org)

**Source**: [github.com/kernelsauce/turbo](https://github.com/kernelsauce/turbo)

**License**: Apache 2.0

Turbo is a framework for building event-driven, non-blocking RESTful web applications built on the top of Tornado web server

**Pros:**

 - LuaRocks install
 - Stable and well-tested 
 - Active development
 - Excellent and extensive documentation
 - Nice templating system
 
**Cons:**

 - Does not support a variety of webservers
 - Supports only LuaJIT
 - I couldn't find information on community
 - I couldn't find information on databases supported

##CMS, Wikis & others
###Ophal
**Website**: [ophal.org](http://ophal.org)

**Source**: [github.com/ophal](https://github.com/ophal)

**License**: AGPL 3.0

Ophal is a is a highly scalable web platform and content management system

**Pros:**

 - Active development
 - Big number of packages to extend it
 - Runs on major webservers
 - Supports a big variety of databases through LuaSQL
 - Maintainer puts a lot of effort into it
 
**Cons:**

 - No LuaRocks install
 - Supports only Lua5.1 and LuaJIT
 - Badly documented
 - Does not seem to be stable, it's currently on alpha v0.1 and I couldn't find tests
 - No/small community
 - Single-person project with no other contributors
 
###LuaPress
**Website**:[luapress.org](http://luapress.org/)

**Source**: [github.com/Fizzadar/Luapress](https://github.com/Fizzadar/Luapress)

**License**: MIT

LuaPress is a static blog generator

**Pros:**

 - LuaRocks install
 - Modern, fresh and in active development
 - Stable and version
 - Nice template system, supports mustache and markdown
 - Reasonable documentation
 - Seems to be compatible with all Lua verions >= 5.1
 
**Cons:**

 - Not being used in production on many websites
 - Single person project with no other contributors and little to no community
 - Could be better documented

###Sputnik
**Website**: [spu.tnik.org](http://spu.tnik.org/)

**Source**: [github.com/yuri/sputnik/](https://github.com/yuri/sputnik/)

**License**: GPL

Sputnik is an extensible Wiki

**Pros**:

 - LuaRocks install
 - Stable and used on production on a number of projects
 - Good documentation
 
**Cons**:

 - Compatible only with Lua5.1
 - Very old abandoned project, it's no longer maintained

###Others

 - [**Tir**](https://github.com/mongrel2/Tir)
 - [**Lusty**](https://github.com/Olivine-Labs/lusty)
 - [**Moonstalk**](http://moonstalk.org/)
 - [**Webmcp**](http://www.public-software-group.org/webmcp)
 - [**Mercury**](https://github.com/nrk/mercury)
 - [**Vanilla**](http://idevz.github.io/vanilla/)
 - [**Gimlet Cocktail**](http://losinggeneration.github.io/gimlet/)
 
## A very simple rank of some tools based on github stars and LuaRocks downloads as of Dec 16, 2015


<center>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg .tg-s6z2{text-align:center}
</style>
<table class="tg">
  <tr>
    <th class="tg-s6z2">Stars</th>
    <th class="tg-s6z2">LR Downloads</th>
  </tr>
  <tr>
    <td class="tg-031e">Luvit 2068★</td>
    <td class="tg-031e">Lapis 55060↓</td>
  </tr>
  <tr>
    <td class="tg-031e">Lapis 1043★</td>
    <td class="tg-031e">Lusty 1406↓</td>
  </tr>
  <tr>
    <td class="tg-031e">Sailor 491★</td>
    <td class="tg-031e">Turbolua 582↓</td>
  </tr>
  <tr>
    <td class="tg-s6z2">Turbolua 270★</td>
    <td class="tg-031e">Sailor 485↓</td>
  </tr>
  <tr>
    <td class="tg-031e">Tir 250★</td>
    <td class="tg-031e">Orbit 481↓</td>
  </tr>
  <tr>
    <td class="tg-031e">Vanilla 122★</td>
    <td class="tg-031e">LuaPress 108↓</td>
  </tr>
  <tr>
    <td class="tg-031e">Orbit 83★</td>
    <td class="tg-031e">Vanilla 38↓</td>
  </tr>
  <tr>
    <td class="tg-031e">Lusty 56★</td>
    <td class="tg-031e">Sputnik 34↓</td>
  </tr>
</table>
</center>
