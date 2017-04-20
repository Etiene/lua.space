2015 is coming to an end and we have plenty of news for you to enjoy on the following days and a new series on the blog! 
This is the debut of a series called "Community news". 
The intent is to make a short summary of the latest news and releases within the Lua community.
This first one is very special because many great stuff have been released recently and I'd also like to announce our first community meet-up after the creation of this blog! 
I'll be present, giving a talk, but I'll also make sure to cover the highlights on an article here on the blog for those who will not be able to be there.

Happy new year!

## Lastest News & Releases

### Dec 25th - OpenResty 1.9.7.1 released
[Source [BSD]](https://github.com/openresty/ngx_openresty) | [Website](https://openresty.org/)

OpenResty (aka. ngx_openresty) is a full-fledged web platform
by bundling the standard Nginx core, Lua/LuaJIT, lots of
3rd-party Nginx modules and Lua libraries, as well as most of their external
dependencies.

### Dec 23rd - Luamongo 0.5.0 released

[Source [MIT]](https://github.com/moai/luamongo)

Lua mongo alloww to work directly with Mongo databases from Lua code and implements a translation between Lua tables and BSON/JSON descriptions used by MongoDB.

### Dec 22nd - LÖVE 0.10.0 released

[Source [zlib/libpng]](https://bitbucket.org/rude/love) | [Website](https://love2d.org/)

LÖVE is an *awesome* framework you can use to make 2D games in Lua. It's free, open-source, and works on Windows, Mac OS X, Linux, Android and iOS.

### Dec 21st - Fire★ (Fire Star) 0.11 released

[Sorce [GPLv3]](https://github.com/mempko/firestr) | [Website](http://www.firestr.com)

Fire★ is a platform for building peer-to-peer GUI applications in Lua. Distributing your applications is as simple as using them in a conversation with others.

### Dec 17th - International Lua community Facebook group open
[Link](https://www.facebook.com/groups/lua.br/) / [Link to group in portuguese](https://www.facebook.com/groups/1555904314647733/)

Just recently I noticed we had two groups on facebook for the Lua programming language, both were in Portuguese and none was International. 
So we decided to open one of them to international members and switch the default language to English.  


## Conference & Meet-up!
Write down on your calendars: on January 30th 2016 we will be meeting at FOSDEM, where a Lua Dev room will be hosted with great talks, great people and great discussions about what's coming next!


<a href="http://fosdem.org"><center><img class="img-responsive" src="http://fosdem.org/2016/support/promote/wide.png" alt="FOSDEM"/></center></a>

FOSDEM is a free event for software developers to meet, share ideas and collaborate. It is the biggest FOSS event in Europe with over 400 lectures and over 5000 participants! 
It will be held at Brussels, Belgium, on January 30th-31st 2016. 

Last yeat we had a quick Bird of Feathers room for our community to meet and this year we will have a full devroom only for Lua-related talks, thanks to the organizers [Hisham Muhammad](http://twitter.com/hisham_hm) (htop / GoboLinux / LuaRocks) and [Pierre Chapuis](https://twitter.com/pchapuis) (Lua Toolbox).
Our devroom will be on the afternoon of the 30th and this is the current talk schedule with the abstracts (some were summarized):

### 14:00 - How awesome ended up with Lua and not Guile - Retrospective of the awesome window manager
#### Julien Danjou
During the year 2008, the awesome window manager jumped in and picked a programming language to allow its users to extend their configuration beyond the limit of the possible. History shows that Lua was picked and Guile completely ignored. Fast forward 7 years later: awesome is still used by tens of thousands of geeks around the globe who write Lua every day. This talk is going to relate how awesome ended up with Lua, how wonderful and terrible it was, and how and why Guile was discarded.


### 15:00 - elasticsearch-lua - Building Lua Applications on Top of Elasticsearch	
#### Pablo Musa
[Read full abstract](https://fosdem.org/2016/schedule/event/building_lua_applications_on_top_of_elasticsearch/)

Elasticsearch is a distributed and scalable data platform written in Java that, besides the transport protocol (Java to Java), offers a very complete REST API accessed through JSON. This talk will cover the details of the Elasticsearch client we built for Lua as a part of the GSoC program in the LabLua organization.

### 15:20 - Continuous Integration with Lua	
#### Enrique García	
Continuous Integration with Lua? Is it worth it? Is there at least a modern way to do it?

I have implemented some reasonably popular open-source Lua libraries, like middleclass.lua & inspect.lua. I would like to share how I make my life easier with automatic testing & automation.

On this talk I will:

* Briefly talk about why & how to do automated tests in Lua
* Exemplify my current method of configuring travis+github in an opensource project
* Talk about other options & alternatives

### 15:50 - Web development in Lua - Introducing Sailor, an MVC framework	
#### Etiene	Dalcol 
Lua is a very fast and powerful scripting language that can be easily embeddable. It has been shining in industries like game development, for example. Lua is also an excellent tool as a general purpose language and can be used to develop robust applications. Its use in web developments, however, despite its great potential and incredible benchmarks, needs to be more widespread. This talk will mention the current state of Lua in web development, show some benchmarks, compare existing tools and teach developers how to get started with Sailor, an MVC web framework written in Lua.

### 16:10 - Lua: the Language of the Web?	
#### Paul Cuthbertson	
An introduction to the Starlight project.

* A comparison of Lua and JavaScript
* An introduction to the project and its value
* Walkthrough of using the browser library
* Examples of interacting with the DOM from Lua
* Walkthrough of using Starlight in your build pipeline

### 16:40 - Hammerspoon - OS X automation with Lua	
#### Peter van Dijk	
[Read full abstract](https://fosdem.org/2016/schedule/event/hammerspoon_os_x_automation_with_lua/)

Hammerspoon is a tool for powerful automation of OS X. At its core, Hammerspoon is just a bridge between the operating system and a Lua scripting engine. What gives Hammerspoon its power is a set of extensions that expose specific pieces of system functionality, to the user.

### 17:00 - Lmod: Building a Community around an Environment Modules Tool
#### Robert McLay	
[Read full abstract](https://fosdem.org/2016/schedule/event/lmod_building_a_community_around_an_environment_modules_tool/)

On today's supercomputers, chemists, biologists, physicists and engineers are sharing the same system and they all need different software. Environment Modules have been the way since the '90 that users select the software they need. They allow users to load and unload the packages they want. They get to control which version of the software they use, rather than the system administrators. Lmod, implemented in Lua, is a modern replacement for the venerable TCL/C based tool. Lmod offers many features to handle the vastly more dynamic software environment than the original tool was designed to handle.

### 17:30 - LGSL: Numerical algorithms for Lua - A Lua-ish interface to the GNU Scientific Library
#### Lesley De Cruz	
[Read full abstract](https://fosdem.org/2016/schedule/event/lgsl_numerical_algorithms_for_lua_based_on_the_gnu_scientific_library/)

LGSL is a collection of numerical algorithms and functions for Lua, based on the GNU Scientific Library (GSL). It allows matrix and vector manipulation, linear algebra operations, special functions, and much more. LGSL is based on the numerical modules of GSL Shell, and requires LuaJIT.

In this talk, I will demonstrate the features of LGSL and discuss how it was tuned to be blazingly fast thanks to LuaJIT.

### 17:50 - What we learned: Developing the Prosody XMPP server in Lua - Lessons learned, regrets, and hopes for the future	
#### Matthew Wild	
After nearly 8 years of development, what have we learned from developing an ambitious software project in Lua?

When Prosody began, in 2008, Lua was not an obvious choice for developing a real-time network service. Compared to alternative languages, Lua had a poor ecosystem (and some say, still has). Node.js was not yet born, and the world was not used to the idea of serious high-performance services being written in high-level "scripting" languages.

Many things have changed since that time, both in the Lua world and beyond. "Why Lua?" is no longer our top FAQ, and the Lua ecosystem has improved considerably.

We faced challenges along the way, and learned a lot. This talk examines some events in our project's history as they relate to the Lua language.

### 18:20 - Design and Implementation of the MoonGen Packet Generator - Using Lua for high-speed network testing and benchmarking	
#### Paul Emmerich	
MoonGen is a scriptable high-speed packet generator suitable to test network devices with millions of packets per second at rates of above 10 Gbit/s. Each packet is crafted in real time by a user-defined Lua script to ensure the maximum possible flexibility. MoonGen is available as free and open source software on GitHub, a scientific paper describing it was published at the Internet Measurement Conference in October 2015.

### 18:40 - Tarantool: an in-memory NoSQL database and execution grid	
#### Konstantin Osipov	
[Read full abstract](https://fosdem.org/2016/schedule/event/tarantool_an_in_memory_nosql_database_and_execution_grid/)

In my talk I will focus on a practical use case: task queue application, using Tarantool as an application server and a database.

The second part of the talk will be about implementation details, performance numbers, a performance comparison with other queue products (beanstalkd, rabbitmq) in particular, and an overview of the implementation from language bindings point of view: how we make database API available in Lua, what are the challenges and performance hurdles of such binding.
