##Writing code as an artistic practice
Live coding is a hard thing to define but essentially it is about writing code to generate improvised music and/or visuals. Frequently, all the code manipulation is projected or streamed. There is a big, diverse, friendly and a well organized [community](http://toplap.org/) around this artistic movement. Also it is inclusive and accesible to all, a lot of live coding environments can be used for free or you can write your own (is not too hard). Popular live coding languages includes: [SuperCollider](http://supercollider.github.io/), [Sonic Pi](http://sonic-pi.net/), [Fluxus](http://www.pawfal.org/fluxus/), [ixi lang](http://www.ixi-audio.net/ixilang/), [Tidal](http://slab.org/tidal/), [Gibber](http://charlie-roberts.com/gibber/), etc.

##Using Lua in a musical context
Why use Lua for live coding if there are cooler and more developed frameworks?
Well, that was the first question that I had to answer when I decided to write a musical live coding environment in Lua, now named [Moonlet](https://github.com/elihugarret/Moonlet). It is not the first Lua live coding framework, may be the best known is [LuaAV](http://lua-av.mat.ucsb.edu/blog/) but the project seems dead, it also exists [Praxis](https://github.com/createuniverses/praxis) and [Worp](http://worp.zevv.nl/) but you have to compile a lot of things and I hate to compile a lot of things, in this case Moonlet is portable (only for Windows users).
Writing your own environment is like making your own musical instrument and Lua lets me to express easily (with a few lines of code) ideas and structures, needed to create the music that I want. I will explain, in future posts entries, how developing some musical concepts in Lua are easier and more readable compared with other languages.

##Experiments
I made a few videos showing how Moonlet behaves with diverse Lua libraries.

###String interpolation experiment
Lua is a minimal programming language, and many "popular" features are not included in the language. But I think that the "less is more" Lua philosophy is great, handling with a restricted environment makes you more creative, also everything in the language is well designed and it is not just a pile of features. When I found the [f-strings](https://github.com/hishamhm/f-strings) module made by [Hisham Muhammad](https://github.com/hishamhm), that implements python-like string interpolation, I decided to make something with it:

<center>
[![](http://i.imgur.com/YCtx7Bu.png?1)](https://youtu.be/VrhpBRaRIXM)
</center>

In the video basically Moonlet sends MIDI messages in real-time to an external synth, the script is updated when saved. Moonlet can read numerical notes (61) and traditional notation (c#4). Note patterns are represented as long strings, then the method "string:n()" converts it to a table. Representing note events as strings lets me use the f-strings library to manipulate the pitch of each note individually.

	-- numbers are notes and underscores represents silence
	local a = ( F[[
		60 _ 72 {67 + 12} _ _ 63 63
		67 _ _ 63 _ 77 65 74
		60 _ _ 67 _ {63 + 7} 79 60
		_ _ 65 _ _ 60 _ 67
		]] ):n()

###S-Lua experiment
I love functional programming languages and, obviously, parentheses. Lua has the coolest functional features and the LuaJIT ffi library lets you write and call C stuff within Lua code. If you think this is really great just hold on and check [this](https://github.com/eugeneia/s-lua). Yes, s-expressions for Lua, also you must read this: [Experimental Meta-Programming for Lua](http://mr.gy/blog/lua-meta-programming.html) by Max Rottenkolber.
In this experiment I represent notes and sound samples as s-expression:

<center>
[![](http://i.imgur.com/BoAdUmC.png)](https://youtu.be/8PgcM0aYDN8)
</center>

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
	
