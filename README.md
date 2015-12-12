# Lua.Space
The Lua Community Blog 

More info:  [Opening Post](http://lua.space/general/blog-opening-and-contribution-guide)

##Yay, awesome, what is this blog for?
Yes, that's an important question! Please notice that we don't have any affilitation with the official Lua team, but we intend to be a central hub for distributing news, technical posts and general discussions on everything related to Lua. Or, as the name says, a Lua space. Subscribe to our [RSS feed](http://feeds.feedburner.com/Luaspace) if you wish to be notified when there's new content.

##Everyone can be a writer
[![Issue Stats](http://issuestats.com/github/Etiene/lua.space/badge/pr)](http://issuestats.com/github/Etiene/lua.space)

All posts are written in markdown and are contained in our [git repository](https://github.com/Etiene/lua.space). Inside the `posts` directory you'll find one or multiple other directories which are the categories of our posts. This one, for example, is in [general](https://github.com/Etiene/lua.space/tree/master/posts/general).  

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

##Maintainer
 * [Etiene](http://twitter.com/etiene_d) ([Sailor framework](http://sailorproject.org))

##Main Contributors
* [Pierre Chapuis](https://twitter.com/pchapuis) ([Lua Toolbox](https://lua-toolbox.com/))
* [undef](https://twitter.com/undefdev) ([quadrant](http://quadrantgame.com/))
* [Bogdan Marinescu](https://twitter.com/bogdanm78) ([eLua](http://eluaproject.net))
* [Mathäus Mendel](https://twitter.com/mathausmendel) ([OpenTibia](https://github.com/opentibia/ )) 
* [Elihu Garret](https://twitter.com/Mr_Auk) ([Moonlet](https://github.com/elihugarret/Moonlet))
* All the writers!
