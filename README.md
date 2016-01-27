# Lua.Space
The Lua Community Blog 

More info:  [Opening Post](http://lua.space/general/blog-opening-and-contribution-guide)

##Yay, awesome, what is this blog for?
Yes, that's an important question! Please notice that we don't have any affilitation with the official Lua team, but we intend to be a central hub for distributing news, technical posts and general discussions on everything related to Lua. Or, as the name says, a Lua space. Subscribe to our [RSS feed](http://feeds.feedburner.com/Luaspace) if you wish to be notified when there's new content.

##Becoming a writer
[![Issue Stats](http://issuestats.com/github/Etiene/lua.space/badge/pr)](http://issuestats.com/github/Etiene/lua.space)

All posts are written in markdown and are contained in our [git repository](https://github.com/Etiene/lua.space). Inside the `posts` directory you'll find one or multiple other directories which are the categories of our posts. [This one](http://lua.space/general/blog-opening-and-contribution-guide), for example, is in [general](https://github.com/Etiene/lua.space/tree/master/posts/general).  

Steps to writing a blog post:

* Fork our [git repository](https://github.com/Etiene/lua.space)
* Write your post using the [markdown syntax](https://help.github.com/articles/markdown-basics/)
* Put it in one of the category directories inside `posts` or create a new one
   *  The md file should be named in the same way you wish the url to be + `.md`
   *  The convention is all lower case separating words by hyphens Ex.: blog-opening-and-contribution-guide.md
* Edit the file `posts_meta.lua` adding an entry for your post and your author details
   *  Just follow the pattern of the other entries already there :)
* Commit and make a pull request
* By making a pull request you certify that you are sharing your post and allowing it to be published here
   *  We will never modify your original post unless for typo fixes or if you require to do so 
   *  You'll still own all the copyrights of your post

This blogs support syntax highlight provided by [highlight.js](http://highlightjs.org). Highlight.js auto-detects the programming language. Code blocks should be written in markdown using 4 spaces or a tab (+ the regular code indentation). Example:

	local function welcome_to_luaspace()
		print("You are awesome!")
	end

##What type of content is welcome?
This blog was created to promote the use of Lua on various levels, both personally and on the industry.

###Topics:
* General Lua use
	* Tutorials on language aspects
	* How to share modules
	* Community aspects
	* Analysis of language aspects, e.g. the ecosystem
	* etc.
* Web development
* Embedded systems
* Scientific computing
* Game development
* Music / Art generation
* Other domains not listed are welcome! We are pretty excited to see Lua being used in different ways!
	* If you are unsure if the topic would be well received, [open an issue at github](https://github.com/Etiene/lua.space/issues) and ask around :) 

###Format
 Follow normal conventions for writing a google article such as having an introduction, adding references whenever possible etc. All posts should be Lua related in some level. Try to raise interesting discussions :) Besides that, the format is pretty flexible. In case you are unsure, you'll find some examples of types of article below. 
 
#### Some example formats: 
##### A success case of Lua use on your team
Examples: [http://lua.space/webdev/oauth2-authentication-with-lua](http://lua.space/webdev/oauth2-authentication-with-lua)

[https://blog.cloudflare.com/pushing-nginx-to-its-limit-with-lua/](https://blog.cloudflare.com/pushing-nginx-to-its-limit-with-lua/)

* Describe the company and the project scope whenever possible
* Explain why you decided to use Lua
	* If you replaced a previous tool with a Lua tool, describe the previous tool and why you decided to change
* Describe the resulting project architecture whenever possible 
	* Add code snippets when deemed relevant
	* images
	* etc.
* Describe the results obtained
	* How satisfied are you
	* Discuss benefits and limitations
	* Add benchmarks whenever possible
* Discuss other things you might find relevant, for example:
	* Did the team knew Lua previously or not? How was the adaptation?

##### A tutorial
Example: [http://lua.space/gamedev/handling-input-in-lua](http://lua.space/gamedev/handling-input-in-lua)

* Give an introduction on what you're going to teach
	* It could be how to use a specific tool, how to understand a speficic concept but in Lua (e.g. neural networks), what exactly is a certain Lua aspect (e.g. metatables) etc. 
* Separate it in logical parts
	* Give code snippets
	* Add images if necessary
* Remember to show up and check comments in case readers have doubts

##### Tools comparison 
Example: [http://lua.space/webdev/the-best-lua-web-frameworks](http://lua.space/webdev/the-best-lua-web-frameworks)

* Give an introduction on what type of tools you're going to compare and what they're for
* Explain the benefits and limitations of using such tools
* Justify the criteria used for comparing or ranking the tools
* Be as impartial as possible, specially if one of the tools is a tool you've made

##### Announcing your tool or library
Example: [http://lua.space/gamedev/using-tiled-maps-in-love](http://lua.space/gamedev/using-tiled-maps-in-love)

* Don't just shout "hey I made this thing, use it"
* Don't just advertise a product 
	* Make the post relevant to the readers in a nice and smooth format, maybe a tutorial, or compare it with other tools (be kind with other tools, remember someone worked hard to make them, even if you think your library is better)
* Explain what it is, what it is for, how it works and why you think it is a good library / tool
* Don't make a new post for the same tool because there was a new release unless that release made a very big relevant change
	* If you want to make a new post about the same tool, try to present it in a different format. Have you already written an introduction post? Try a tutorial now 

##### Dirty fun hacks

* Did you program your nodemcu to feed your cat when you're traveling? Please tell us all about it
* Be as descriptive as possible
* Show pictures
* Share the code

##### Art

* Are you live coding in Lua?
* Did you generate a musical or visual piece with Lua programming?
* Share it with us!
	* Describe how Lua was used
	* Post the youtube video, sound cloud url, and resources you deem relevant to the piece
	* Add code snippets whenever possible

###English & Grammar
For the moment, the only language used for posting is English (although we may add more languages in the future). Pay attention to orthography and grammar. If English is not your first language, don't refrain from writing, English is not my first language either. If you are insecure about your English level, once you've written the article on your fork, show it to us, so we can help it out. :)

###How articles are accepted
Once you've created your article on your fork and made a pull request, we will read it and decide how to proceed. If you've read the sections above, you have an idea on what's the scope of this blog. If we think your article is good to go, your PR will be immediately accepted and merged. We might feel something could be improved before publishing, like a section that could be described in more details or an important URL is missing, for example. We will, then, give feedback by commenting on the PR so you can address it. :)

If you have a subject but you are unsure on how to present it, you can also open an issue before writing the post. We will discuss and help you elaborate your idea. :) 


##Maintainer
 * [Etiene](http://twitter.com/etiene_d) ([Sailor framework](http://sailorproject.org))

##Main Contributors
* [Pierre Chapuis](https://twitter.com/pchapuis) ([Lua Toolbox](https://lua-toolbox.com/))
* [undef](https://twitter.com/undefdev) ([quadrant](http://quadrantgame.com/))
* [Bogdan Marinescu](https://twitter.com/bogdanm78) ([eLua](http://eluaproject.net))
* [Mathäus Mendel](https://twitter.com/mathausmendel) ([OpenTibia](https://github.com/opentibia/ )) 
* [Elihu Garret](https://twitter.com/Mr_Auk) ([Moonlet](https://github.com/elihugarret/Moonlet))
* All the writers!
