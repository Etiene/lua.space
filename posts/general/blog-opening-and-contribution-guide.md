##How it all started
It's always very difficult to write the opening post of a blog, but I guess I should start by how the idea of creating this blog came up. It all started after I read a blog post on [Model View Culture](https://modelviewculture.com) called [C is Manly, Python is for “n00bs”: How False Stereotypes Turn Into Technical “Truths”](https://modelviewculture.com/pieces/c-is-manly-python-is-for-n00bs-how-false-stereotypes-turn-into-technical-truths). It tells us how myths and stereotypes about programming languages damage our area as developers. Beliefs of what are "toy languages" as opposed to "real languages" are often nothing more than social constructs. This stops significant technology of getting widespread, demotivates excellent developers and proliferates cargo-cult programming. 

<center>
<img class="img-responsive"  alt="you only have to pick one, not really" src="http://lua.space/pub/post_img/pick_one.png"/>
</center>

<center>
([image credit](http://www.devbattles.com/en/sand/post-1315-5+Myths+to+Know+Before+You+Learn+How+to+Become+a+Software+Developer))
</center>

As a Lua developer and advocate, this article resonated with me on a deep level. Lua is a very successful programming language on some specific domains, such as embedded systems and game scripting, but still fairly unknown by people outside those niches. I'm often asked why don't I use a "real language" with features such as classes by uneducated programmers who have never touched Lua's powerful metamechanisms. Even some professors think that's "hilarious", which just makes me sigh. Reading that article, my frustration just built up until I started [ranting on twitter](https://twitter.com/etiene_d/status/673850335191003136), of course, because that's my thing when I'm frustrated with something. So I'd like to elucidate some points...

* Lua is not a domain specific language. It was created with some purposes in mind, of course, just like everything else in computer science. It is still just a regular dynamic script language which means it is in the same family as other popular languages such as Python, Ruby, Javascript, Perl and PHP, for example. I have worked with many of these languages and Lua is still the best language in this category I know. It is elegant, powerful, ridiculously fast, portable, readable, fun to work with and I have yet to see something better than Lua come up. I wouldn't dare to compare it in absolute terms with languages that do not belong to this family since it doesn't make sense at all, but Lua would still score many points overall. 

* The fact that Lua is the top #1 language for game scripting does not mean it is a "toy language". On the contrary, World of Warcraft uses Lua exactly because this kind of quality and performance is what it needs. Gaming is one of the main domains for performance freaks. If Lua is popular there, this is a GOOD sign, not the opposite.

* It still baffles me every time experienced developers tell me they just have never heard about it and keep shrugging it off in a conservative attitude. And this reminds me that, unfortunately, like almost everything else in the world, programming languages can also benefit from good marketing tactics. In the developer world, those marketing tactics may include regular tactics but also community & ecosystem growing.  

During my rant, a group of other Lua developers that had similar feelings started engaging on what we could do to contribute to Lua in terms of community and how we could show our appreciation for the language. That's when the idea for the blog came up. After a long list of tweets, a secret chat and some exchange of ideas, I started building this blog (in Lua, of course! ^_^). You may check the source [here](https://github.com/Etiene/lua.space). 

##Yay, awesome, but what is this blog for?
Yes, that's an important question! Please notice that we don't have any affilitation with the official Lua team, but we intend to be a central hub for distributing news, technical posts and general discussions on everything related to Lua. Or, as the name says, a Lua space. Subscribe to our [RSS feed](http://feeds.feedburner.com/Luaspace) if you wish to be notified when there's new content.

##Share your knowledge
I am super excited! Are you super excited? Share your knowledge by contributing with Lua related posts! 

All posts are written in markdown and are contained in our [git repository](https://github.com/Etiene/lua.space). Inside the `posts` directory you'll find one or multiple other directories which are the categories of our posts. This one, for example, is in [general](https://github.com/Etiene/lua.space/tree/master/posts/general).  

Steps to writing a blog post:

- Fork our [git repository](https://github.com/Etiene/lua.space)
- Write your post using the [markdown syntax](https://help.github.com/articles/markdown-basics/)
- Put it in one of the category directories inside `posts` or create a new one
     -  The md file should be named in the same way you wish the url to be + `.md`
     -  The convention is all lower case separating words by hyphens Ex.: blog-opening-and-contribution-guide.md
- Edit the file `posts_meta.lua` adding an entry for your post and your author details
     -  Just follow the pattern of the other entries already there :)
- Commit and make a pull request
- By making a pull request you certify that you are sharing your post and allowing it to be published here
     -  We will never modify your original post unless for typo fixes or if you require to do so 
     -  You'll still own all the copyrights of your post


This blogs support syntax highlight provided by [highlight.js](http://highlightjs.org). Highlight.js auto-detects the programming language. Code blocks should be written in markdown using 4 spaces or a tab (+ the regular code indentation). Example:

	local function welcome_to_luaspace()
		print("You are awesome!")
	end

##Awesome people
Special thanks go to [Pierre Chapuis](https://twitter.com/pchapuis) ([Lua Toolbox](https://lua-toolbox.com/)), for the domain name, [undef](https://twitter.com/undefdev) ([quadrant](http://quadrantgame.com/)) for the initial engagement and next contributions as a writer, [Bogdan Marinescu](https://twitter.com/bogdanm78) ([eLua](http://eluaproject.net)), [Mathäus Mendel](https://twitter.com/mathausmendel) ([OpenTibia](https://github.com/opentibia/ )) and [Elihu Garret](https://twitter.com/Mr_Auk) ([Moonlet](https://github.com/elihugarret/Moonlet)) for exchanging ideas and helping this come to reality, and every future writer of this blog!

Cheers!
