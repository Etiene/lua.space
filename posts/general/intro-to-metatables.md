Hi folks, this post aims to offer a clear introduction to the topic of metatables in Lua for those who are not yet familiar with them. I originally wrote this for the forums of [PICO-8](http://www.lexaloffle.com/pico-8.php), a 'fantasy console' with limitations inspired by classic 8-bit computers, which uses a modified flavour of Lua 5.2.

Without further ado, let's go!

A **table** is a mapping of keys to values. They're explained quite well in the PICO-8 manual and the Lua reference manual so I won't go into more detail. In particular you should know that `t.foo` is just a nicer way of writing `t["foo"]` and also that `t:foo()` is a nicer way of calling the function `t.foo(t)`

A **metatable** is a table with some specially named properties defined inside. You apply a metatable to any other table to change the way that table behaves. This can be used to:

1. define custom operations for your table (+, -, etc.)
2. define what should happen when somebody tries to look up a key that doesn't exist
3. specify how your table should be converted to a string (e.g. for printing)
4. change the way the garbage collector treats your table (e.g. [tables with weak keys](https://www.lua.org/pil/17.html))

Point #2 is especially powerful because it allows you to set default values for missing properties, or specify a [prototype](https://en.wikipedia.org/wiki/Prototype-based_programming) object which contains methods shared by many tables.

You can attach a metatable to any other table using the [setmetatable](http://www.lua.org/manual/5.2/manual.html#pdf-setmetatable) function.

All possible metatable events are explained on the lua-users wiki:  
 >>> [list of metatable events](http://lua-users.org/wiki/MetatableEvents) <<<

which is, as far as I'm aware, the best reference for everything that metatables can be used for.

And that's really all you need to know!


### Vectors Example

I'll now demonstrate how metatables could be used to make a "2D point/vector" type, with custom operators.


	-- define a new metatable to be shared by all vectors
	local mt = {}

	-- function to create a new vector
	function makevec2d(x, y)
		local t = {
			x = x,
			y = y
		}
		setmetatable(t, mt)
		return t
	end

	-- define some vector operations such as addition, subtraction:
	function mt.__add(a, b)
		return makevec2d(
			a.x + b.x,
			a.y + b.y
		)
	end

	function mt.__sub(a, b)
		return makevec2d(
			a.x - b.x,
			a.y - b.y
		)
	end

	-- more fancy example, implement two different kinds of multiplication:
	-- number*vector -> scalar product
	-- vector*vector -> cross product
	-- don't worry if you're not a maths person, this isn't important :)

	function mt.__mul(a, b)
		if type(a) == "number" then
			return makevec2d(b.x * a, b.y * a)
		elseif type(b) == "number" then
			return makevec2d(a.x * b, a.y * b)
		end
		return a.x * b.x + a.y * b.y
	end

	-- check if two vectors with different addresses are equal to each other
	function mt.__eq(a, b)
		return a.x == b.x and a.y == b.y
	end

	-- custom format when converting to a string:
	function mt.__tostring(a)
		return "(" .. a.x .. ", " .. a.y .. ")"
	end


Now we can use our newly defined 'vector' type like this:


	local a = makevec2d(3, 4)
	local b = 2 * a

	print(a)      -- calls __tostring internally, so this prints "(3, 4)"
	print(b)      -- (6, 8)
	print(a + b)  -- (9, 12)


Pretty neat right?


### Object Orientation

I mentioned that metatables can be used to define what should happen when a key lookup fails, and that this can be used to create custom methods shared by many tables. For example we might want to be able to do this:


	a = makevec2d(3, 4)
	a:magnitude()  -- calculate the length of the vector, returning 5


In Lua this is not always necessary, for example, we could define an ordinary function to do the job for us:


	function magnitude(vec)
		return sqrt(vec.x^2 + vec.y^2)
	end
	magnitude(a)  -- returns 5


In fact, for PICO-8 I would recommend that approach, because it's as efficient as you can get, and it uses the least number of tokens (PICO-8 cartridges are limited in code size).

But I think it's educational to see how metatables can make it possible to use Lua in a more OOP style.

First off, we define all our methods in a table somewhere. Note, you can define them in the metatable itself (this is a common convention), but I'll put them in a different table to prevent confusion.


	local methods = {}
	function methods.magnitude(self)
		return sqrt(self.x^2 + self.y^2)
	end


The `__index` property of a metatable is referred to when you try to look up a key 'k' which is not present in the original table 't'.

If \_\_index is a function, it is called like `mt.__index(t, k)`  
If \_\_index is a table, a lookup is performed like `mt.__index[k]`  

So we can add the magnitude function, along any other methods we may have defined, to all our existing vector objects by simply setting the \_\_index property to our table of methods:


	mt.__index = methods


And now, as we wanted, we can call `a:magnitude()`  
Which is a shortcut for `a.magnitude(a)`  
Which is a shortcut for `a["magnitude"](a)`

Hopefully given all this information, it's clear what's happening: We never defined a magnitude property in 'a', so when we try to lookup the string "magnitude", the lookup fails and Lua refers to the metatable's \_\_index property instead.

Since \_\_index is a table, it looks in there for any property called "magnitude" and finds the magnitude function that we defined. This function is then called with the parameter 'a' which we implicitly passed when we used the : operator.

Well, that's it from me! I hope somebody finds this post useful, and please let me know if there is something you don't understand, or something that I left out or could have explained better. If you'd like to see more examples of metatable usage and OOP, I recommend chapters 13, 16 and 17 of [Programming in Lua](https://www.lua.org/pil/contents.html).
