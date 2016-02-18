##Writing code as an artistic practice
Live coding is a hard thing to define but essentially it is about writing code to generate improvised music and/or visuals. Frequently, all the code manipulation is projected or streamed. There is a big, diverse, friendly and a well organized [community](http://toplap.org/) around this artistic movement. Also, it is inclusive and accessible to all, a lot of live coding environments can be used for free or you can write your own. Popular live coding languages includes: [SuperCollider](http://supercollider.github.io/), [Sonic Pi](http://sonic-pi.net/), [Fluxus](http://www.pawfal.org/fluxus/), [ixi lang](http://www.ixi-audio.net/ixilang/), [Tidal](http://slab.org/tidal/), [Gibber](http://charlie-roberts.com/gibber/), etc.

##Using Lua in a musical context
Why use Lua for live coding if there are cooler and more developed frameworks?
Well, that was the first question that I had to answer when I decided to write a musical live coding environment in Lua, now named [Moonlet](https://github.com/elihugarret/Moonlet). It is not the first Lua live coding framework, maybe the best known is [LuaAV](http://lua-av.mat.ucsb.edu/blog/) but the project seems dead. There is also [Praxis](https://github.com/createuniverses/praxis) and [Worp](http://worp.zevv.nl/), but you have to compile a lot of things and I hate to compile a lot of things, in this case Moonlet is portable (only for Windows users).
Writing your own environment is like making your own musical instrument and Lua lets me to express easily (with a few lines of code) ideas and structures needed to create the music that I want. I will explain that in future posts entries and how developing some musical concepts in Lua is easier and more readable compared with other languages.

##Experiments
I made a few videos showing how Moonlet behaves with diverse Lua libraries.

###String interpolation experiment
Lua is a minimal programming language, and many "popular" features are not included in it. But I think that the "less is more" Lua philosophy is great, handling with a restricted environment makes you more creative as everything in the language is well designed and not just a pile of features. When I found the [f-strings](https://github.com/hishamhm/f-strings) module made by [Hisham Muhammad](https://github.com/hishamhm) that implements python-like string interpolation in Lua, I decided to make something with it:   

<br/>
<div class="embed-responsive embed-responsive-16by9">
  <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/VrhpBRaRIXM" frameborder="0" allowfullscreen></iframe>
</div>
<br/>

In the video basically Moonlet sends MIDI messages in real-time to an external synth, the script is updated when saved. Moonlet can read numerical notes (61) and traditional notation (c#4). Note patterns are represented as long strings, then the method "string:n()" converts it to a table. Representing note events as strings let me use the f-strings library to manipulate the pitch of each note individually.

	-- numbers are notes and underscores represents silence
	local a = ( F[[
		60 _ 72 {67 + 12} _ _ 63 63
		67 _ _ 63 _ 77 65 74
		60 _ _ 67 _ {63 + 7} 79 60
		_ _ 65 _ _ 60 _ 67
		]] ):n()

###S-Lua experiment
I love functional programming languages and, obviously, parentheses. Lua has the coolest functional features and the LuaJIT ffi library lets you write and call C stuff within Lua code. If you think this is really great just hold on and check [this](https://github.com/eugeneia/s-lua). Yes, s-expressions for Lua, you must also read this: [Experimental Meta-Programming for Lua](http://mr.gy/blog/lua-meta-programming.html) by Max Rottenkolber.
In this experiment notes and sound samples are represented as s-expressions:   
   
<br/>
<div class="embed-responsive embed-responsive-16by9">
  <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/8PgcM0aYDN8" frameborder="0" allowfullscreen></iframe>
</div>
<br/>

This snippet of code is a lispy step sequencer:

	-- the semantic of the language does not change.
	-- is like writing in Lua a,b,c,d,e = " ", " ", " ", " ", " "
	
	-- letters are sound samples 
	-- "x" -> kick drum
	
	sLua[[
		($ (a b c d e) 
			!(c3 d#4 g4) 
			!(c4 d4 g4) 
			!(x _ _ _ x _ _ _) 
			!(_ h _ h p _ _ G) 
			!(_ d#5 _ c5 f4 g4 g4 c3 ))
	]]
	

##Conclusions
There are a lot of things that I left out about Moonlet, like how it works or how to install it. I will write about that in the near future. The purpose of this post is to show that Lua is fully capable for music handling in a live coding context.
Here is an example of a complete track written entirely in Lua and recorded live:

<br/>
<div class="embed-responsive embed-responsive-16by9">
	<iframe class="embed-responsive-item" height="450" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/229975020&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>
</div>
<br/>

For this piece I live-coded hardware synths with Moonlet using MIDI protocols. You can listen more of my tracks in [soundcloud](https://soundcloud.com/luehi). Feel free to make whatever you want with them, they are open source. But... where is the source? Well, I am making/developing a pretty little album and it will be released with the source code.

