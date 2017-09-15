
There is a latent desire out there to use something else than JS in the browser. Whether it is warranted or not is another topic in itself. But you don't have to search long to find [all kinds of projects](https://github.com/jashkenas/coffeescript/wiki/List-of-languages-that-compile-to-JS) aiming to bring another language in the browser.

The arrival of Web Assembly reignited that desire for many of us. But wasm is a long way from being usable in production and still does not allow full interaction with all web apis.

## Lua is a good fit for the browser

Lua is a simple language with very few concepts to understand and a clear and readable syntax. You can be proficient with it in a matter of hours. Yet it provides very useful features. To name a few:

- First class functions and closures
- A versatile data structure: [the table](http://www.lua.org/pil/2.5.html)
- Vararg expression
- Lexical scoping
- Iterators
- Coroutines (see below)

It has a sane coercion system (I'm looking at you JS!). Nobody's adding X new concepts to it each version (still looking at you JS), which makes it a stable and reliable language.

Lua is already successfully used server-side with the awesome [OpenResty](https://openresty.org/en/) which powers sites like [itch.io](https://itch.io/). There's even some great web frameworks like [lapis](http://leafo.net/lapis/).

Lua can be found in a number of widely different contexts because of how easy it is to embed it. You can write a whole program with it or simply use it as a *glue* language thanks to the Lua C api.

### Coroutines

One of its main selling point for the browser are coroutines. Coroutines address the issue of writing asynchronous code beautifully. No more promises, generators, etc. You can just write asynchronous code as easily as regular code.

Here's a simple example (fully functional version [here](https://gist.github.com/giann/f231cce5f17bde18aceb8537855cd51c)):

    local bird1 = fetch("http://some.api.com/raven") -- fetch being a random xhr call
    local bird2 = fetch("http://some.api.com/dove")
    
    print(bird1.name, bird2.name)


A similar version of that using async/await could be:

    let asynchronousFn = async function() {
        let bird1 = await fetch("http://some.api.com/raven");
        let bird2 = await fetch("http://some.api.com/dove");
            
        console.log(bird1.name, bird2.name);
    }

These are close, but notice how, in the Lua version, you don't need to be in a `async` function. In JS you would have to constantly make the conscious choice of tagging a function `async` or not. In Lua, **any** function can be interrupted as long as it's running in a coroutine. Bob Nystrom wrote a great post about it [here](http://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/).

When you're writing asynchronous code in JS, you're in fact piling up function calls. Those callbacks all retain their upvalues which can lead to high memory usage. With coroutines your function can actually be suspended and resumed without having to descend from a pyramid of closures because they run in separate lua states.

## Existing ways of using Lua in the browser

There's already a few projects out there to use Lua in the browser in some extent:

- [Moonshine](http://moonshinejs.org/) is a reimplementation of Lua in JS. Sadly, it's not being actively developed anymore.
- [Starlight](http://starlight.paulcuth.me.uk/) by the same author is a Lua to JS transpiler. Unfortunately coroutines can't be implemented effectively with this approach.
- [lua.vm.js](https://daurnimator.github.io/lua.vm.js/lua.vm.js.html) a port of the original Lua implementation to JS using Emscripten. It's fast and works well but its interoperability with JS is compromised by the fact that we end up with two garbage collectors trying to manage the same memory.

## Fengari

[**Fengari**](http://fengari.io/) (moon in greek) is the Lua VM written in Javascript with the browser as its primary target.

Fengari aims to be 100% compliant with the latest Lua semantics. It stays as close as possible to Lua's codebase and if you're familiar with it, you'll understand Fengari rather easily. [99%](https://github.com/fengari-lua/fengari#so-far) of Lua's scope is currently covered so you should be able to run any Lua project with minor adjustments.

With the C API (rather JS API), you can decide to write everything in Lua or to use it as a higher level language that calls your JS codebase to do the heavy lifting. This also means that you can segregate your code in separate insulated Lua states.

You can also interact with the JS side directly from your Lua code effortlessly with the [fengari-interop](https://github.com/fengari-lua/fengari-interop) module. It ensures that manipulating JS objects or functions always behave the way you would expect it to:


    local global = js.global
    local document = global.document
    
    global:alert("Hello from Fengari")
    
    document:getElementById("my-div").textContent = "Hi there !"


The REPL you see on [fengari.io](http://fengari.io/) is itself written [in Lua](https://github.com/fengari-lua/fengari.io/blob/master/static/lua/web-cli.lua) and JS is only used to create the Lua state and run the main script.

Fengari is still in development and any [feedback](https://github.com/fengari-lua/fengari/issues) is welcome !
