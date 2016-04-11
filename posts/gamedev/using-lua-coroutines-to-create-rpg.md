Recently I've been working on an RPG with a friend, for whom coding is not their strong point. We're using the excellent [LÖVE](https://love2d.org/) framework, so the whole game is written in Lua.

Scripting of dialogues, animations and in-game events is a hugely important aspect for any RPG, and I wanted to build a scripting system that's easy to use and doesn't require any knowledge about the rest of the game's engine, but is also powerful enough for me to extend with new functionality as needed. This post aims to show how a few simple Lua features can be combined to create a scripting environment that's pleasant to use.

First, let's take a look at the XSE language used in Pokémon modding, as this was probably my main point of inspiration. It has a very straightforward, imperative style, even though each instruction doesn't correspond to a single function in-game.

By this I mean, the whole game engine doesn't freeze just because you are talking to an NPC, however there are points at which the dialogue script cannot progress until the text animations have finished and the player has pressed the [A] button.

<img alt="XSE Example" class="img-responsive" src="/pub/img/using-lua-coroutines-to-create-rpg/xse.png" />

Another interesting tool is [Yarn](https://github.com/infiniteammoinc/Yarn), a dialogue editor in which you connect nodes of text together to form complete conversations. It has variables, conditionals and custom commands which you can hook up to different parts of your engine to trigger animations and such. I'd say it's definitely worth checking out especially if you're using Unity or similar.

So how would we go about creating such a system in LÖVE without creating our own language or writing an interpreter for an existing language such as Yarn?

### Part 1: Chaining Callbacks Together
The first thing we need is the ability to 'say' some text from inside a script, which boils down to setting a string and then waiting for the user to press a button before we resume execution of the script. The game should still be updating on every frame, even when text is being displayed.

In true JavaScript fashion, we could create an asynchronous API that looks a bit like this:

    text = nil
    callback = nil
    
    function say(str, cb)
        text = str
        callback = cb
    end

Our game logic & rendering code could look something like this:

    function love.update(dt)
        if not text then
            -- player movement code
        end
    end
    
    function love.draw()
        -- code to draw the world goes here
        
        if text then
            love.graphics.print(text, 10, 10)
        end
    end
    
    function love.keypressed(key, isRepeat)
        if text and key == "space" then
            text = nil
            if callback then
                -- execute the next part of the script
                callback()
            end
        end
    end

Then we could write a dialogue script that looks like this, potentially fetching it at runtime with a call to `dofile()` or something:

    say("Hello there!", function ()
        say("How's it going?", function ()
            say("Well, nice talking to you!")
        end)
    end)

This kind of code grows unwieldy very quickly. It's confusing for non-coders and also error prone (many places to miss out a comma or a closing bracket). You could try some variations such as giving a name to each function, but it still turns out quite unpleasant to work with because managing all those functions gets in the way of what matters: writing good dialogue and scenes. At this point we'd surely be better off writing a Yarn interpreter or using some other existing solution.

But this is not JavaScript, and we can do better!

### Part 2: Using Coroutines
For the uninitiated, coroutines are chunks of code that can be jumped to much like functions. A coroutine can suspend itself (`yield`) at will, returning to the point at which it was called. At a later stage, the program can jump back into the coroutine and `resume` where it left off.

I suppose this puts them in a sort of middle ground between functions and threads. They are more powerful than functions, but you still have to manage them explicitly - you can't just leave them running in the background to do their own thing. Typically they are used to break up an intensive task into small bursts, so that the program can still function as normal (receive user input, print to console, etc.)

Hang on a minute, doesn't this sound a lot like what we want from the dialogue scripting system? Executing a single line and then suspending the script while we give control back to the game loop?

Let's see how we could achieve the same result as Part 1, only using a coroutine instead of a chain of callbacks.

    text = nil
    routine = nil
    
    function say(str)
        text = str
        coroutine.yield()
        text = nil
    end
    
    function run(script)
        -- load the script and wrap it in a coroutine
        local f = loadfile(script)
        routine = coroutine.create(f)
        
        -- begin execution of the script
        coroutine.resume(routine)
    end

The important difference here is the implementation of the `say` function. Instead of setting a callback for later use, we tell the current coroutine to yield. This means we can't call say directly from the main program, only from inside a coroutine. Also there is now a loader function which creates a new coroutine and tells it to run the script.

Next we need to rewrite `love.keypressed` to make it resume the coroutine on the press of the space bar.

    function love.keypressed(key, isRepeat)
        if text and key == "space" then
            if routine and coroutine.status(routine) ~= "dead" then
                -- execute the next part of the script
                coroutine.resume(routine)
            end
        end
    end

And finally, we can write a script that looks like this:

    say("Hello there!")                -- the script suspends once here
    say("How's it going?")             -- it suspends again here
    say("Well, nice talking to you!")  -- it suspends for the 3rd time here
  

### Part 3: Sandboxing and Advanced Usage
If we declare a global variable, 'n', we can create an NPC that remembers how many times the player has spoken to it.

    say("Hey kid, I'm Mr. Red!")
    
    if n == 0 then
        say("I don't believe we've met before!")
    else
        say("You have spoken to me "..n.." times!")
    end
    
    n = n + 1

It's great that this works, because it does exactly what you would expect and it's super easy to use. However, there are some problems.

If all the variables are stored in the global environment, we risk running into naming collisions which at best will cause scripts to behave incorrectly and at worst could replace key functionality and crash the game.

Additionally, having our game's state scattered across a ton of globals makes things very difficult when we want to think about serialising the gamestate to produce a save file.

Fortunately Lua makes it easy to swap out the environment of a function for any table, using `setfenv` in Lua 5.1 or `_ENV` in Lua 5.2 or greater. We don't need to change our scripts at all, we just need to make sure that they still have access to the `say` function, by placing it in their environment (the `game` table below).

    game = {}
    
    function game.say(str)
        text = str
        coroutine.yield()
        text = nil
    end
    
    function run(script)
        local f = loadfile(script)
        setfenv(f, game)
        routine = coroutine.create(f)
        
        -- begin execution of the script
        coroutine.resume(routine)
    end

It also might be helpful to have a script that is called once at startup, to initialise all the game variables to default values, or load them from a save file.

As far as animation goes, we can drop in a tweening solution like flux, along with a few helper functions which will allow us to pause the script until the animation completes.

    game.flux = require "flux"
    
    game.pause = coroutine.yield
    
    function game.resume()
        coroutine.resume(routine)
    end

and then we could tween a character to x = 800 with a script like this:

    flux.to(myNpc, 2.0, { x = 800 }):ease("linear"):oncomplete(resume)
    pause()

which yes, is a mouthful for non-coders, and it introduces an asynchronous aspect back into the scripting API. We would probably benefit from a custom animation system that's more more tailored to our game, but this hopefully goes to show how easy it is to make scripts that can interact with any other part of the engine.

### What Next?
I hope I was able to teach some interesting ideas here! I wanted to share this because coroutines are something I've known about for a while, but until now I've never had a good reason to use them. I would be interested to know which other languages can be used to create a system like this.

Here are some things you might want to do next, to create a more full-featured RPG engine:

* Add `lock()` and `release()`, so it's possible to display text while the player is moving, or stop the player from moving even when there is no text.
* Add an `ask(str, ...)` function whereby the player can choose from a list of options (e.g. yes/no)
* Download a level editor such as Tiled, or create your own. ([Create a map](/gamedev/using-tiled-maps-in-love)) and try attaching some scripts to game objects such as buttons and NPCs.
* Create an easy-to-use animation system with commands such as 'face X direction' or 'move N steps'
* Add character portraits so that the player knows who's speaking (this might require you to add an extra parameter to `say()` or some new functions)
* Consider how you would go about handling save data. How to distinguish it from data which is part of the gamestate but does not need to be saved permanently?
