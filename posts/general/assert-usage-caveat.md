In C/C++, the preprocessor is a bless. Among many other things, a Lua-like `assert` macro can be made that checks that a condition is true, and if it's not, an error is raised, in such a way that by just changing a definition, all `assert`'s in the code can be instantly gone, resulting in no code generated for them. And if the assertion passes, the second parameter (the error message to display in case of failure) does not need to be evaluated at all.

Unfortunately, Lua doesn't have a preprocessor. In Lua we can't make the asserts to be gone. If they appear in our code, they are going to be executed. Furthermore, since it's a regular function and not a special construct, all arguments will be evaluated prior to calling it.

The latter is more of a problem than we realize. The [PIL book](http://www.lua.org/pil/8.3.html) warns us about it, as does the [LuaJIT wiki](http://wiki.luajit.org/Numerical-Computing-Performance-Guide). I wanted to know how much of a problem it actually was, so I prepared a potential solution that I could benchmark against. Here's the full benchmark program including the function and the results:

```
require 'socket'
gettime = socket.gettime

-- Like assert() but with support for a function argument
function xassert(a, ...)
  if a then return a, ... end
  local f = ...
  if type(f) == "function" then
    local args = {...}
    table.remove(args, 1)
    error(f(unpack(args)), 2)
  else
    error(f or "assertion failed!", 2)
  end
end

-- This is a function that concatenates all of its arguments and returns the result
function string.concat(...)
  return table.concat({...})
end

local start, finish

start = gettime()
for i = 1, 2000000 do
  xassert(true, "blah" .. i)
end
finish = gettime()

print('xassert(true, "blah" .. i): ' .. finish - start)

start = gettime()
for i = 1, 2000000 do
  xassert(true, function() return "blah" .. i end)
end
finish = gettime()

print('xassert(true, function() return "blah" .. i end): ' .. finish - start)

start = gettime()
for i = 1, 2000000 do
  xassert(true, string.concat, "blah", i)
end
finish = gettime()

print('xassert(true, string.concat, "blah", i): ' .. finish - start)
```

Here's one sample result using luajit:

    $ luajit assert-benchmark.lua
    xassert(true, "blah" .. i): 1.4941189289093
    xassert(true, function() return "blah" .. i end): 0.26615500450134
    xassert(true, string.concat, "blah", i): 0.00069808959960938

For comparison, here's a pure Lua version:

    $ lua assert-benchmark.lua
    xassert(true, "blah" .. i): 1.8206660747528
    xassert(true, function() return "blah" .. i end): 0.49262690544128
    xassert(true, string.concat, "blah", i): 0.32892203330994

That test was made with an Intel Core i3-2100 @ 3.10GHz

Note how in LuaJIT, the last one is more than 300 times faster than building a function to return the result on the fly, and about 2,000 times faster than using concatenation directly. In pure Lua, the results are not so outstanding, but the fastest version is still more than 5 times faster than the slowest one.

What do these timings mean in terms of user code? Imagine it's used in a game. If it's just a small bunch of asserts per frame, we're not going to notice the difference for sure. But if we have a function that is called very often and it uses an assert with a concatenation, note that it takes about 20,000 asserts (in the computer used for benchmarks) to take 100% of the time of a frame. On a slower machine it may take 10,000. If we executed say 2,000 asserts, then we'd be spending 20% of the frame time on concatenating a value that is going to be discarded.

So, here's the proposed function in isolation:

```
-- Like assert() but with support for a function argument
function xassert(a, ...)
  if a then return a, ... end
  local f = ...
  if type(f) == "function" then
    local args = {...}
    table.remove(args, 1)
    error(f(unpack(args)), 2)
  else
    error(f or "assertion failed!", 2)
  end
end
```

It should be compatible with the standard Lua `assert`, with the additional feature that if the second parameter is a function instead of a string, that function will be called only if the assertion fails, and the result is the one that will be used as an error message. The idea of `xassert` is to postpone any calculations performed on the second parameter (notably concatenation) to the case when the condition fails, rather than performing them unconditionally.

Since `xassert` is compatible with `assert`, it can be used as a drop-in replacement. I suggest to include the following function in the set as well:

```
-- This is a function that concatenates all of its arguments and returns the result
function string.concat(...)
  return table.concat({...})
end
```

That enables us to call it like this: `xassert(condition, string.concat, value1, value2...)`, so that all values are concatenated together _only_ if the assertion fails. The penalty of that is expected to be much less, and the benchmark agrees.

One price to pay, of course, is readability. However, I certainly prefer to get used to the idiom `xassert(condition, string.concat, ...)` in favour of keeping the meaningful error messages without a significant performance penalty.

There are cases where `string.concat` alone is not enough to postpone all calculations. The LuaJIT wiki mentions this example:

```
assert(type(x) == "number", "x is a "..mytype(x))
```

With `xassert` and `string.concat`, we would write it as:

```
xassert(type(x) == "number", string.concat, "x is a ", mytype(x))
```

But that causes `mytype(x)` to be called every time, and not only when the condition fails as we would prefer. In such a case, we need to stop for a moment and ponder whether that function is costly or not, and how often it will be called. If it's worth to avoid that call when not used, then a solution may be to use a custom function like this:

```
function type_err(var, fn, value)
  return var .. " is a " .. fn(value)
end
-- We'd call it like this:
xassert(type(x) == "number", type_err, "x", mytype, x)
```

Or to use a custom assert function, or some other tailor-made function adequate to the specific needs.

To finish, just one minor caveat. The `xassert` function proposed performs basically the same in most circumstances as the system's one, but if your code includes failing assertions and is executed protected by a `pcall` by design, the performance may drop a bit with respect to the system's. That's not a common usage pattern, fortunately.
