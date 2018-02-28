# Extending pandoc with Lua

My first exposure to Lua has been as a pandoc user, and adding new Lua
features to pandoc turned Lua into one of my favorite languages. In this
post I will take a look at [pandoc](https://pandoc.org/), the universal
document converter, and explore how one can script and extend it with
Lua. Pandoc includes a Lua interpreter since 2012, but the integration
of Lua has been expanded significantly with the latest 2.0 release. My
hope for this article is to highlight the beauty of these systems.

## The universal document converter

[Pandoc](https://pandoc.org/) – written and maintained by [John
MacFarlane](https://johnmacfarlane.net) – is an relatively old project.
It has grown considerably since the first version was published in 2006:
at the time of writing, pandoc can read 27 different document formats
and dialects, and can write 49 formats. Besides serving as a one-off
document conversions tool, pandoc also frequently features as the
central part of publishing pipelines. For example, Pandoc is used in
[static](https://github.com/mfenner/jekyll-pandoc) [site
generators](https://jaspervdj.be/hakyll/) and is frequently used [by
academic
writers](https://programminghistorian.org/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown),
due also to its excellent support for citations.

As a brief example, consider the following commands which transform
Markdown input into docx, HTML, or PDF:

     -- command to convert a markdown file to docx
    pandoc input-file.md --output=output-file.docx

    -- convert to HTML
    pandoc input-file.md --standalone --output=output-file.html

     -- convert to PDF (via LaTeX)
    pandoc input-file.md --output=output-file.pdf

Many conversion tasks need to alter the default behavior or require
special conversion features. This highlights the importance of good
customization support for a conversion tool, one of the areas in which
Lua shines.

Pandoc is unusual for a Lua-extendable program, in that it is written in
Haskell. Using Haskell is very productive, but is less suitable as an
extension language: its concepts are often alien to users of other
languages, and shipping a full Haskell interpreter with pandoc would
result in considerable bloat. Lua is an excellent choice here, as it is
lightweight, simple, and beautiful. It should be noted, however, that
[bridging Haskell and Lua](https://github.com/hslua) is its own can of
worms and worth a separate blog post.

## Pandoc's document AST

An important factor in pandoc's immense transformation powers is its use
of a unifying document representation: Every input is parsed into this
document AST, which is then rendered in the desired output format. While
a direct conversion between any of *n* input and *m* output formats
would require *n * m* converters, using an intermediate representation
reduces complexity to *n + m*.

There are additional advantages to this: as we'll see, it becomes much
simpler to work with a unified document representation than it would be
to work with any of the input or output formats directly.

There are four main types in pandoc's document model: inlines, blocks,
document metadata, and the full document.

- Inline elements represent text and text markup. Examples are *Space*
  for inter-word spaces, *Str* for (usually non-whitespace) text, and
  *Emph* for emphasized text.
    
- Blocks are elements like paragraphs, lists, code listings, and
  headers. They are usually rendered in lines or blocks of their own;
  many block elements contain lists of inline elements.

- Meta information is a simple mapping from string keys to meta values.
  Meta values can be thought of as a special JSON or YAML object.

- Last but not least, the *Pandoc* type represents a full document. A
  *Pandoc* element consists of a lists of block elements, plus
  additional document metadata.

Pandoc's Lua features revolve around modifying or converting these
elements. The oldest use of Lua in pandoc enables the conversion of AST
elements into strings as to output any document format.

## Custom writers

Users can define custom writers in Lua to render any document format.
Each of the aforementioned AST elements is transformed to a string by
calling a Lua function of the same name as the element. E.g., this
example demonstrates how emphasized text can be rendered as HTML:

    function Emph(content_string)
      return '<em>' .. content_string .. '</em>'
    end

A full custom writer is defined by specifying functions for all document
AST elements. Example writers using this method include
[2bbcode](https://github.com/lilydjwg/2bbcode) by [\@lilydjwg (依
云)](https://github.com/lilydjwg), as well as pandoc's `sample.lua`. The
latter is a well documented starting point for authors of new custom
writers. The file can be produced by calling `pandoc
--print-default-data-file=sample.lua`.

The [pandoc-scholar](https://pandoc-scholar.github.io/) project serves
as an example for the power offered by custom writers. It is a
publishing tool intended to [help authors of scholarly
articles](https://doi.org/10.7717/peerj-cs.112) and was created with
custom Lua writers. The tool leans on the custom writers feature in ways
that writers were not intended to be used, which resulted in the
development of lua filters.

## Filters

An additional benefit of a unified document type is that the document
can be modified programmatically, regardless of which input and output
format is chosen. Pandoc provides two interfaces for this.

### JSON Filters

The first – very flexible – method is based on JSON. Pandoc can
serialize the document to JSON; other programs [can read and
modify](https://pandoc.org/filters.html) the document. The resulting
document JSON is passed back to pandoc, thus allowing users to use any
programming language capable of parsing JSON to alter the document. Many
libraries for various languages have been implemented, including
[Haskell](https://hackage.haskell.org/package/pandoc-types),
[Python](http://scorreia.com/software/panflute/),
[Ruby](https://heerdebeer.org/Software/markdown/paru/), and
[JavaScript](https://www.npmjs.com/package/pandoc-filter).

The flexibility of JSON filters can also be a disadvantage, as it
requires additional software and usually the full installation of a
scripting language's ecosystem. Pandoc is designed to work on all major
platforms and without any dependencies on other libraries and binaries.
Depending on additional software can be problematic, especially for
non-technical users.

### Lua filters

The [Lua filter](https://pandoc.org/lua-filters.html) system added in
pandoc 2.0 not only solves the portability issue of JSON filters, but
also offers better performance and more functionality. Document elements
can be selectively serialized to Lua tables, modified using the full
power of Lua, and will then be transferred back, thus replacing the
previous values.

Lua filters operate by calling filter functions on each element of the
specified name. I.e., if a Lua filter contains a function with the same
name as an AST element, then this function is called for all elements of
the respective type. The serialized element is passed as input to the
filter function, and the function's return value is deserialized and
used to replace the input element. This method is as simple as it is
flexible, and fits well with the concept of immutability which is
prevalent in Haskell programs: pandoc ignores modifications to the
serialized object itself, it will just use the filter function's return
value.

The following example filter transforms all text set in small caps into
emphasized text:

    function SmallCaps (element)
      return pandoc.Emph(element.content)
    end
    
The element constructor functions in module pandoc, like `pandoc.Emph`
in the above example, are also the central step when transforming
elements from their pandoc-internal representation to Lua values. This
ensures consistency in the way element values are produced, whether
during serialization or through a constructor call in the filter script.
The current implementation uses only strings, tables, and some
metatables when constructing element values, with the goal of marking
these values easy and flexible to use.

## Lua filter example: macro expander

Below is the code for a simple macro expander using pandoc's Lua filter
functionality. The expander replaces all macro occurrences in the given
document. Macro definitions are hard-coded into the filter, but could as
well be read from an external file.

    -- file: macro-expander.lua

    -- Macro substitutions: contains macro identifier as
    -- keys and the expanded inlines as values.
    local macro_substs = {
      ['{{hello}}'] = pandoc.Emph{pandoc.Str "Hello, World!"}
    }

    -- Replace string with macro expansion, if any.
    function Str (s)
      return macro_substs[s.text] or s
    end
    
The heart of the macro expander is the function `Str`. It is called on
all simple strings in the document. The return value of this function is
then read back into pandoc, replacing the original `Str` value.

Assume a Markdown file `greeting.md`:

    Greeting: {{hello}}

We can apply the macro expander by calling

    pandoc --lua-filter macro-expander.lua greeting.md

resulting in the expected expansion:

> <p>Greeting:  <em>Hello, World!</em></p>

The function `Str` could be shortened further by dropping the trailing
`or s`:

    function Str (s) return macro_substs[s.text] end

This is a convenience feature of pandoc filters: if the function returns
no value (or `nil`), the original value is kept unchanged. This makes
filter functions easier to write and speeds up filtering, as unchanged
elements don't need to be deserialized again.

## What's good, and what's next

Using pandoc with Lua is a fast, flexible, and platform independent way
of augmenting pandoc with additional functionality. For me personally,
having the full power of Lua at ones finger tips proved to be a lot of
fun, while opening unexpected document processing possibilities.

Pandoc and its Lua subsystem are under constant development. E.g., the
next versions will feature more utility functions exposed via Lua
modules. There is constant work to make more and more internal functions
available. The next big goal is to grant scripting access to all
format-output functions. However, this requires some changes to pandoc's
internals. It remains a long way for pandoc to become a fully
Lua-scriptable publishing platform.

If you want to learn more about Lua filters, the [Lua filter
docs](https://pandoc.org/lua-filters.html) is a good place to start. It
includes up-to-date examples of Lua scripts, as well as a reference of
all modules and functions accessible via Lua. Pandoc's [user
manual](https://pandoc.org/MANUAL.html) is a good resource to learn
about all of pandoc features and its command line options.

[Feedback](https://groups.google.com/forum/#!forum/pandoc-discuss) is
always welcome!

## Acknowledgements

A big thank you to Jennifer König, Birgit Pohl, and John MacFarlane for
their feedback on an earlier version of this post, and to all pandoc
contributors and users, who make working on this project incredibly fun.
