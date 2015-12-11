
##Handling Input In Lua

In every interactive programm you make you will have to process user input.

In bigger programs or games this can get quite confusing when you have many different states that require input to be handled differently.
Even in a small game you will already have to handle input differently when the player is in a menu or on the title screen.
If you scale up your game without using a reasonable code structure things will get _really_ messy and work will get **a lot** harder.

To avoid your code from getting to messy your input handler will have to be:
* simple
* easy to read
* extensible
* able to easily handle multiple input devices

What I usually see in LÖVE projects is something like this:

	function love.keypressed( k )
		if k=="escape" then
			love.event.quit()
		elseif k=="other key" then
		-- other keys
		end
	end

This might be the way to go in some other programming languages, but in Lua we have the luxury of tables.
One great thing about tables is that anything except nil can be index and anything can be value.
That means that we can represent _key presses_ with a corresponding _list of statements_ as a table containing the _key pressed_ (represented as string) as its index, and a _function containing the statements_ as its value.
That has the advantage that you don't need to compare the key pressed to a long list of potential key presses in a huge if-block to perform an aciton, indexing a table is sufficient.

This is the input handler I use in very small LÖVE projects:

	local keys = {
		escape = love.event.quit,
		-- other keys
	}

	function love.keypressed( k )
		local action = keys[k]
		if action then  return action()  end
	end

This is already much more neat, you can easily read the list of possible key presses and their effects.
Notice that this pattern can be used on many different occasions. When ever you have a very long if-block and always compare the same variable to something, you can easily replace it with a table.

The key handler above is very small, simple and readable but doesn't satisfy everything we want from one.
For small projects this is fine, because I usually only use the keyboard (even only `love.keypressed`), but it can also be easily extended to something more powerful:

	local bindings = {
		backToGame = function() --[[<...>]]  end,
		scrollUp   = function() --[[<...>]] end,
		scrollDown = function() --[[<...>]] end,
		select     = function() --[[<...>]] end,
	}

	local keys = {
		escape     = "backToGame",
		up         = "scrollUp",
		down       = "scrollDown",
		["return"] = "select", -- return is a keyword that's why it has to be written like this
	}
	local keysReleased = {}

	local buttons = {
		back = "backToGame",
		up   = "scrollUp",
		down = "scrollDown",
		a    = "select",
	}
	local buttonsReleased = {}

	function inputHandler( input )
		local action = bindings[input]
		if action then  return action()  end
	end

	function love.keypressed( k )
		local binding = keys[k]
		return inputHandler( binding )
	end
	function love.keyreleased( k )
		local binding = keysReleased[k]
		return inputHandler( binding )
	end
	function love.gamepadpressed( gamepad, button )
		local binding = buttons[button]
		return inputHandler( binding )
	end
	function love.gamepadreleased( gamepad, button )
		local binding = buttonsReleased[button]
		return inputHandler( binding )
	end

So this is already a lot better, we can easily support multiple input devices like this.
However usually games have different states with different input schemes, so it makes sense to integrate it into a state handler:

	local state

	local gameStates = {}

	gameStates.menu = {
		bindings = {
			backToGame = function()  state = gameStates.gameLoop  end,
			scrollUp   = function() --[[<...>]] end,
			scrollDown = function() --[[<...>]] end,
			select     = function() --[[<...>]] end,
		},
		keys = {
			escape     = "backToGame",
			up         = "scrollUp",
			down       = "scrollDown",
			["return"] = "select",
		},
		keysReleased = {},
		buttons = {
			back = "backToGame",
			up   = "scrollUp",
			down = "scrollDown",
			a    = "select",
		}
		buttonsReleased = {},
		-- <...>
	}
	gameStates.gameLoop = {
		bindings = {
			openMenu   = function()  state = gameStates.menu  end,
			jump       = function() --[[<...>]] end,
			left       = function() --[[<...>]] end,
			right      = function() --[[<...>]] end,
		},
		keys = {
			escape = "openMenu",
			lshift = "jump",
			left   = "left",
			right  = "right",
		},
		keysReleased = {},
		buttons = {
			back    = "openMenu",
			a       = "jump",
			dpleft  = "left",
			dpright = "right",
		}
		buttonsReleased = {},
		-- <...>
	}

	function inputHandler( input )
		local action = state.bindings[input]
		if action then  return action()  end
	end

	function love.keypressed( k )
		-- you might want to keep track of this to change display prompts
		INPUTMETHOD = "keyboard"
		local binding = state.keys[k]
		return inputHandler( binding )
	end
	function love.keyreleased( k )
		local binding = state.keysReleased[k]
		return inputHandler( binding )
	end
	function love.gamepadpressed( gamepad, button )
		-- you might want to keep track of this to change display prompts
		INPUTMETHOD = "gamepad"
		local binding = state.buttons[button]
		return inputHandler( binding )
	end
	function love.gamepadreleased( gamepad, button )
		local binding = state.buttonsReleased[button]
		return inputHandler( binding )
	end

As you can see, both the `escape` key and the `back` button map to the binding `backToGame`, while the player is in the menu.
When the binding `backToGame` is being sent to the input handler, the function `state.bindings.backToGame` is being called, resulting in the following assignment: `state = gameStates.gameLoop`.
Now the input callbacks and the input handler will use `gameStates.gameLoop` to look for bindings and for functions to execute.

