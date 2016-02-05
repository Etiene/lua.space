In C/C++, the preprocessor is a bless. Among many other things, a Lua-like `assert` macro can be made that checks that a condition is true, and if it's not, an error is raised, in such a way that by just changing a definition, all `assert`'s in the code can be instantly gone, resulting in no code generated for them. And if the assertion passes, the second parameter (the error message to display in case of failure) does not need to be evaluated at all.

Unfortunately, Lua doesn't have a preprocessor. In Lua we can't make the asserts to be gone. If they appear in our code, they are going to be executed. Furthermore, since it's a regular function and not a special construct, all arguments will be evaluated prior to calling it.

The latter is more of a problem than we realize. The [PIL book](http://www.lua.org/pil/8.3.html) warns us about it, as does the [LuaJIT wiki](http://wiki.luajit.org/Numerical-Computing-Performance-Guide). I wanted to know how much of a problem it actually was, so I prepared a potential solution that I could benchmark against. Here's the full benchmark program including the function and the results:

```
require 'socket'
gettime = socket.gettime

-- Redefine the standard assert() to add basic function support
function assert(a, f, ...)
  if a then return ... end
  if type(f) == "function" then
    error(f(...))
  elseif f == nil then
    error("assertion failed!")
  else
    error(f, ...)
  end
end

-- This is a function that concatenates all of its arguments and returns the result
function string.concat(...)
  return table.concat({...})
end

local start, finish

start = gettime()
for i = 1, 2000000 do
  assert(true, "blah" .. i)
end
finish = gettime()

print('assert(true, "blah" .. i): ' .. finish - start)

start = gettime()
for i = 1, 2000000 do
  assert(true, function() return "blah" .. i end)
end
finish = gettime()

print('assert(true, function() return "blah" .. i end): ' .. finish - start)

start = gettime()
for i = 1, 2000000 do
  assert(true, string.concat, "blah", i)
end
finish = gettime()

print('assert(true, string.concat, "blah", i): ' .. finish - start)
```

Here's one sample result using luajit:

    $ luajit assert-benchmark.lua
    assert(true, "blah" .. i): 1.4835920333862
    assert(true, function() return "blah" .. i end): 0.2511191368103
    assert(true, string.concat, "blah", i): 0.00069618225097656

For comparison, here's a pure Lua version:

    $ lua assert-benchmark.lua
    assert(true, "blah" .. i): 1.7685780525208
    assert(true, function() return "blah" .. i end): 0.47876191139221
    assert(true, string.concat, "blah", i): 0.2859890460968

That test was made with an Intel Core i3-2100 @ 3.10GHz

Note how in LuaJIT, the last one is more than 300 times faster than building a function to return the result on the fly, and about 2,000 times faster than using concatenation directly. In pure Lua, the results are not so outstanding, but the fastest version is still about 6 times faster than the slowest one.

What do these timings mean in terms of user code? Imagine it's used in a game. If it's just a small bunch of asserts per frame, we're not going to notice the difference for sure. But if we have a function that is called very often and it uses an assert with a concatenation, note that it takes about 20,000 asserts (in the computer used for benchmarks) to take 100% of the time of a frame. On a slower machine it may take 10,000. If we executed say 2,000 asserts, then we'd be spending 20% of the frame time on concatenating a value that is going to be discarded.

So, here's the proposed function in isolation:

```
-- Redefine the standard assert() to add basic function support
function assert(a, f, ...)
  if a then return ... end
  if type(f) == "function" then
    error(f(...))
  elseif f == nil then
    error("assertion failed!")
  else
    error(f, ...)
  end
end
```

It should be compatible with the standard Lua `assert`, with the additional feature that if the second parameter is a function instead of a string, that function will be called only if the assertion fails, and the result is the one that will be used as an error message. The idea of this new `assert` is to postpone any calculations performed on the second parameter (notably concatenation) to the case when the condition fails, rather than performing them unconditionally.

Since our new `assert` is backwards compatible, it can be used as a drop-in replacement in our existing projects and we don't need to replace each of the existing calls immediately in order to start using it. I suggest to include the following function in the set as well:

```
-- This is a function that concatenates all of its arguments and returns the result
function string.concat(...)
  return table.concat({...})
end
```

That enables us to call it like this: `assert(condition, string.concat, value1, value2...)`, so that all values are concatenated together _only_ if the assertion fails. The penalty of that is expected to be much less, and the benchmark agrees.

One price to pay, of course, is readability. However, I certainly prefer to get used to the idiom `assert(condition, string.concat, ...)` in favour of keeping the meaningful error messages without a significant performance penalty.

There are cases where `string.concat` alone is not enough to postpone all calculations. The LuaJIT wiki mentions this example:

```
assert(type(x) == "number", "x is a "..mytype(x))
```

With the new `assert` and `string.concat`, we would write it as:

```
assert(type(x) == "number", string.concat, "x is a ", mytype(x))
```

But that makes `mytype(x)` to be called every time, and not only when the condition fails as we would prefer. In such a case, we need to stop for a moment and ponder whether that function is costly or not, and how often it will be called. If it's worth to avoid that call when not used, then one solution may be to use a custom function like this:

```
function type_err(var, value)
  return var .. " is a " .. mytype(value)
end
-- We'd call it like this:
assert(type(x) == "number", type_err, "x", x)
```

Or some other tailor-made function adequate to the specific needs.

To finish, just one minor caveat. The `assert` function proposed performs basically the same in most circumstances as the system's one, but if your code includes failing assertions and is executed protected by a `pcall` by design, the performance may drop with respect to the system's. That's not a common usage pattern, fortunately.
