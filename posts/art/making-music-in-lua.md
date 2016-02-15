##Writing code as an artistic practice
Live coding is a hard thing to define but essentially it is about writing code to generate improvised music and/or visuals. Frequently, all the code manipulation is projected or streamed. There is a big, diverse, friendly and a well organized [community](http://toplap.org/) around this artistic movement. Also it is inclusive and accesible to all, a lot of live coding environments can be used for free or you can write your own (is not too hard). Popular live coding languages includes: [SuperCollider](http://supercollider.github.io/), [Sonic Pi](http://sonic-pi.net/), [Fluxus](http://www.pawfal.org/fluxus/), [ixi lang](http://www.ixi-audio.net/ixilang/), [Tidal](http://slab.org/tidal/), [Gibber](http://charlie-roberts.com/gibber/), etc.

##Using Lua in a musical context
Why use Lua for live coding if there are cooler and more developed frameworks?
Well, that was the first question that I had to answer when I decided to write a musical live coding environment in Lua, now named [Moonlet](https://github.com/elihugarret/Moonlet). It is not the first Lua live coding framework, may be the best known is [LuaAV](http://lua-av.mat.ucsb.edu/blog/) but the project seems dead, it also exists [Praxis](https://github.com/createuniverses/praxis) and [Worp](http://worp.zevv.nl/) but you have to compile a lot of things and I hate to compile a lot of things, in this case Moonlet is portable (only for Windows users).
Writing your own environment is like making your own musical instrument and Lua lets me to express easily (with a few lines of code) ideas and structures, needed to create the music that I want. I will explain, in future posts entries, how developing some musical concepts in Lua are easier and more readable compared with other languages.

##A few experiments
I made a few videos showing how Moonlet behaves with diverse Lua libraries.

###String interpolation experiment
Lua is a minimal programming language, and many "popular" features are not included in the language. But I think that the "less is more" Lua philosophy is great, handling with a restricted environment makes you more creative, also everything in the language is well designed and it is not just a pile of features. When I found the [f-strings](https://github.com/hishamhm/f-strings) module that implements python-like string interpolation, I decided to make something with it:

<center>
[![](http://imgur.com/YCtx7Bu)](https://youtu.be/VrhpBRaRIXM)
</center>
