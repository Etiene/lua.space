I recently gave a talk in [FOSDEM](https://fosdem.org), which is a great event if, like me, you are into
open source.

<center>
<iframe src="https://kikito.github.io/ci-with-lua/"></iframe>
</center>

[Direct link to slides](https://kikito.github.io/ci-with-lua/)

You can watch the whole talk [in video format](http://video.fosdem.org/2016/k3201/continuous-integration-with-lua.mp4).
If you prefer a text-based approach, read on.

If you want to know what Continuous Integration is, or why it is useful,
you could start by reading [the article I wrote about that](http://kiki.to/blog/2016/02/04/talk-continuous-integration/).

I manage several open source long-lived Lua projects. I have continuous integration in almost all
of them, and it has been of great help. What I am about to explain works for my kind of projects,
but it can be adapted to other options.

### a) The environment

Continous Integration takes place in a server. Since we're talking about Lua here, the server must have a way to install
some version of Lua, and some version of Luarocks. This is what I call "the environment". I want to test my libraries in Lua
5.1, 5.2 & 5.3, as well as LuaJIT 2.1 & 2.2. So I need my CI server to install all that.

I choose [travis-ci](https://travis-ci.org) as my main CI server. It is free for open-source tools, and it integrates very well
with github. It is also very easy to configure: you just need to add a file called `.travis.yml` on the root of your repo, and
travis will use it to run all the checks.

Travis supports a wide variety of languages. Setting up the environment for the supported languages is incredibly easy. For example,
the following `.travis.yml` file will install 4 versions of ruby:

    # .travis.yaml
    language: ruby

    rvm:
      - '1.9.3'
      - '1.8.7'
      - 'rbx-2.1.1'
      - 'ree'

Lua, unfortunately, is not one of the supported languages, which means it requires more work. I have seen lots of people going this route:

    # .travis.yaml
    language: C # does not really matter

    env:
      - LUA=lua5.1
      - LUA=lua5.2
      - LUA=lua5.3
      - LUA=luajit2.0
      - LUA=luajit2.1

    before_install:
      - source install_lua.sh

What the `env` section of that file does is setting up environment variables. It is basically saing: run one time with the `LUA` environment
variable equals to `"lua5.1"`, another time with `"lua5.2"`, etc. In travis, each of these "times" it called a *job*. The `before_install`
step, which is repeated at the beginning of every job, executes a script file called `install_lua.sh`, which in turn will install the
appropiate version of Lua depending on the value of the `LUA` environment variable.

This solution works. But there are several things I don't like. `install_lua.sh` is usually a big file written in shellscript, usually several
hundreds lines of code, which require maintenance. It also must be included on each repo which uses this approach for CI.

Fortunately, a better solution was presented to me. And it came from an unlikely place: Python!

There is this Python project called [hererocks](https://github.com/mpeterv/hererocks). Hererocks is a python script which can install any of the
major versions of Lua and LuaJIT in a folder, with no "global" dependencies. It's maintained by Peter Melnichenko, and since Python is supported
by travis, we can set up the environment like this:

    # .travis.yaml
    language: python
    sudo: false

    env:
      - LUA="lua=5.1"
      - LUA="lua=5.2"
      - LUA="lua=5.3"
      - LUA="luajit=2.0"
      - LUA="luajit=2.1"

    before_install:
      - pip install hererocks
      - hererocks lua_install -r^ --$LUA
      - export PATH=$PATH:$PWD/lua_install/bin


What this does is: since Python is supported by travis, we can set it up in the `language` section. This makes Python's package manager, `pip`,
available. Then we use `pip` to install `hererocks`. And then we use `hererocks` to install the version of Lua which is required for each job
in a folder called `lua_install`.


### b) Specs

As I said before, specs are "extra code which makes sure that your regular code works as you think it should". A usual term to refer to them
is *automated tests*. I prefer *specs* because it is a bit more specific (there are lots of "tests" which can be "automated").

To implement my specs I use the library [busted](http://olivinelabs.com/busted/), by olivinelabs.

A quick taste of how specs look like in busted. Here's an extremely simple Lua library:

    -- mylib.lua

    return {
      add = function(a,b) return a+b end
    }

And here's how we could write the spec for that library in busted:

    -- spec/mylib_spec.lua

    local mylib = require 'mylib'

    describe('mylib', function()
      it('adds numbers', function()
        assert.equal(5, mylib.add(2,3))
      end)
    end)

`busted` declares several global variables: `describe` makes groups of specs. `it` creates one spec. `assert` is monkeypatched so in addition of
its usual role it can be used to specify *assertions*. When these assertions are met, the specs containing them are passed (green). If any
assertion on a spec "fails", the spec becomes "failed" (red).

Here's how you install & execute `busted` in `travis.yml`:

    # .travis.yml

    install:
      - luarocks install busted

    script:
      - busted --verbose

The `--verbose` option gives a little more information when a spec fails.

Just by adding this to your `.travis.yml`, you should be able to "run your specs" through Travis. It integrates with github, and will give you
some niceties if you use it as a platform: it will run the specs automatically every time anyone pushes code to any of the branches, or sends
a pull request. It will also mark all the commits and pull requests with a green flag (when the specs pass) or a red cross (when they don't).

<img alt="Travis Github integration" class="img-responsive" src="http://kikito.github.io/ci-with-lua/img/travis-github-green.png"/>

### c) Coverage

Now that you have code which tests that your code does what you think it should do. What else is there?

One of the things that you can do is getting the *coverage* of your specs.

Coverage is a number - usually a percentage. It tells you *how many of your lines where executed when the specs were run*. So, if
coverage is 100%, that means that all the lines in your code have been executed at least once. If your coverage is 50%, only
half of your where executed. Etc.

A tool which I find really useful is the [coveralls.io website](http://coveralls.io). It is not a coverage calculation tool. But once you
get your coverage data to it, it can present it in a very human-friendly way. And it doesn't limit itself to showing a single number; it
presents multiple reports, per build, job, file and line. That last one is the one which I like the most:

<img alt="coveralls file report" class="img-responsive" src="http://kikito.github.io/ci-with-lua/img/coveralls-file.png"/>

The picture above is coveralls.io showing the source code of one of my libraries, [middleclass](https://github.com/kikito/middleclass).

* The lines in wite(ish) are blank lines, comments, and lines with *syntactic* value but no *semantic* value (such as the `end` finishing
  an `if` or a function). These are not interesting for the coverage, and are ignored.
* The green lines are lines which have been executed at least once when the specs where run. Notice the number to the right of each one:
  that's the number of times each line has been executed.
* The red line is did not get executed at all during the specs. This usually means that I am missing some spec for testing it (it could also
  mean that my code has lines which are never executed).

In addition to all the reports, coveralls.io also has "github hooks" - it will "turn red" the pull requests which lower the coverage, and "green"
the ones which make it bigger (or the same).

So, how do we get the coverage info appearing in coveralls.io? In my case, I generate that info in travis, and then upload it to coveralls.

The standard Lua tool for generating coverage information is [Luacov](https://keplerproject.github.io/luacov/). Luacov can be used to generate
a file with almost all the information coveralls.io needs. A second tool, called [luacov-coveralls](https://github.com/moteus/luacov-coveralls),
translates this local file into a format coveralls understands, and does the upload.

Both `luacov` and `luacov-coveralls` are installable via luarocks, so setting them up in travis is very simple. We do something similar to this:

    # .travis.yml

    install:
      - luarocks install luacov
      - luarocks install luacov-coveralls

Once we have the local file generated by `luacov`, sending it to coveralls is also very easy. Since I want to send the coverage information
only when the specs run correctly, I call `luacov-coveralls` on the `after_success` section of `.travis.yml`:

    # .travis.yml

    after_success:
      - luacov-coveralls -e $TRAVIS_BUILD_DIR/lua_install

Notice that I add a `-e` parameter to `luacov-coveralls`. This makes it ignore anything happening inside the `lua_install` folder. If I didn't do
this, the coverage information would include `busted`'s source code, too. This is only necessary because I am using hererocks to set up the environment.

The only missing part is generating the `luacov` file. It turns out that busted already has a command-line option for it, called `--coverage`.
Add it to busted, push the changes to travis, and it will start sending information:

    # .travis.yml

    script:
      busted --verbose --coverage

If you are not using busted, luacov can also be included when runing Lua or LuaJIT from the command line. Check
[luacov's documentation](https://keplerproject.github.io/luacov/) for more information.

### d) Static analysis

Contrarily to specs or coverage studies, Static Analysis occurs *without executing the code it analyzes. It turns out that lots of useful
information can be extracted from the source code by just reading it.

For static analysis, I use [luacheck](https://github.com/mpeterv/luacheck). This great tool detects common defects in Lua code:

* Declared but unused variables or function parameters
* Local variables obscuring other similarly named variables in their scope
* And the one which probably is more useful, it *detects global variables*.

Luacheck can be installed with luarocks and executed from the command line. Adding it to travis is straightforward (I run it before I run the specs,
on the `script` namespace):

    # .travis.yml

    install:
      - luarocks install luacheck

    script:
      - luacheck --std max+busted *.lua spec

The only interesting bit is the `--std` option. The value `max` means "accept all the global variables which are used in any Lua version". This means
that `pairs`, `ipairs`, etc will not be detected as variables. But so will `pack` (even if it isn't a global variable in Lua 5.3) or `jit` (even if it's
not available in vanilla Lua). If you want to detect global variables with more detail, you might want to change this setting by a value adapted to
your environment. The `+busted` part adds the global variables declared by busted (like `describe` or `it`).

### e) All together

Here's the complete `.travis.yml` I use in my projects now:

    # .travis.yml

    language: python
    sudo: false

    env:
      - LUA="lua=5.1"
      - LUA="lua=5.2"
      - LUA="lua=5.3"
      - LUA="luajit=2.0"
      - LUA="luajit=2.1"

    before_install:
      - pip install hererocks
      - hererocks lua_install -r^ --$LUA
      - export PATH=$PATH:$PWD/lua_install/bin

    install:
      - luarocks install luacheck
      - luarocks install busted
      - luarocks install luacov
      - luarocks install luacov-coveralls

    script:
      - luacheck --std max+busted *.lua spec
      - busted --verbose --coverage

    after_success:
      - luacov-coveralls -e $TRAVIS_BUILD_DIR/lua_install

It's worth noting that I use this file as a *template*; each project might require some customization (deactivating one luacheck rule here, removing an unsupported
Lua version there). I encourage you to adapt it to your needs.

Thanks for reading, and happy hacking!
