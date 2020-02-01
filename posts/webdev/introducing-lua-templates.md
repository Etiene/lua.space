# Introducing Lua Templates

Lua Templates is a multi-purpose templating engine used to create output in
various formats, e.g. HTML pages, plain text, or, LaTeX source files.
Lua Templates can contain Lua code or Lua expressions (whence the name), but
there is also a powerful mechanism to extend existing templates by re-defining
named blocks found in the base template (one could call this an "inheritance"
mechanism.)

(*Lua Templates have been used by my company [micro systems](http://www.msys.ch/)
as part of the [arcapos](http://www.arcapos.ch) solution for applications like
online ticket sales, backoffice, accounting, CRM etc, serving thousands of
users.*)

The source code for the Lua template rendering module can be found at
on [github.com/arcapos/luatemplate](https://github.com/arcapos/luatemplate).

## How Lua Templates work

Lua Templates are first converted to Lua code when they are parsed for the
first time and then executed, which generates the output, optionally escaping
the output it for the target format. On subsequent calls of the same template,
the already compiled Lua code is executed directly to render the template.
This way, templates are rendered very fast an we achieve
high transaction rates e.g. for web applications.

For security reasons, the Lua code generated from a template is executed
in a separate container, either a separate Lua state or a sandbox.  The
normal operation mode is to provide the values that the template expects to
the separate container and then call the Lua function that corresponds
to the template being rendered.

The conversion from Lua Templates to Lua code is done in a Lua Templates
specific [reader function](http://www.lua.org/manual/5.3/manual.html#lua_Reader)
that is passed to a `lua_load()` call.  This function is written in the C
language.

## Template syntax

Lua Templates are textfiles in any encoding, containing markup in
**<%** ... **%>** brackets.  When rendering a template, the following
principles apply:

- Regular text, i.e. text not containing any markup, is output as is.
- Text in **<%** ... **%>** brackets is interpreted as Lua code and
  executed when the template is rendered. There is normally no output.
- Text in **<%=** ...**%>** brackets is interpreted as a Lua expression
  and the result of the expression is inserted in the output.  After the
  equal sign, an optional format specifier conforming to **string.format()**
  format specifiers can be added, e.g. to create output with fixed
  width.
- Text in **<%=***escaping* ... **%>** brackets is interpreted as a Lua
  expression and the result of the expression is escaped according to
  *escaping* and then inserted in the output. For possible values of
  *escaping*, see the list below.
- Text in **<%!** ... **%>** brackets is interpreted as a Lua Template command
  The following commands are currently defined:

  - **block** *name*. Define a named block.
  - **endblock**. End a block definition.
  - **escape**. Define the standard escaping for **<%=** ... **%>**
    expressions.
    The following escapings are defined:
     - **html**. Escape the output as HTML code.
     - **xml**. Escape the output as XML code .
     - **latex**. Escape the output as LaTeX code.
     - **none**. Don't escape the output.
     - **url**. Escape the output as a URL.

- **extends** *name*. Indicate that this template extends the template *name*.
  The contents of blocks defined in this template with
  **<%! block** *name* **%>** ... **<%! endblock %>** will replace
  the corresponding blocks in the template that is being extended.
  **Important**: The **extends** command must be the first command in a
  template. There is no need to re-define all blocks in the base template,
  only those that are to be modified (e.g. a page title and the contents, but
  not the page header and footer). Multi-level extension of templates is
  possible (and usually makes sense).

- **include** *name*. Insert a template in the output.

The *name* argument of the **block**, **extends**, and, **include** command
can be put in single or double quotes or no quotes at all.

In Lua code, the function **lt.out()** can be used to output arbitrary data.
**lt.out()** expects a single string as argument.

## Example

	<html><body>
	<% for n = 1, 5 do %>
	This is line <%= n %> : <%=%20d n %><br>
	<% end %>
	</body></html>

### Example output

	<html><body>
	This is line 1 :                     1<br>
	This is line 2 :                     2<br>
	This is line 3 :                     3<br>
	This is line 4 :                     4<br>
	This is line 5 :                     5<br>
	</body></html>

## Extending a Template with "extends"

### Template base.html as base template

	<!DOCTYPE html>
	<html lang="en">

	<head>
	    <link rel="stylesheet" href="style.css">
	    <title><%! block title %>My amazing site<%! endblock %></title>
	</head>

	<body>
	    <div id="sidebar">
	    <%! block sidebar %>
		<ul>
		     <li><a href="/">Home</a></li>
		     <li><ahref="/blog/">Blog</a></li>
		</ul>
	    <%! endblock %>
	    </div>

	    <div id="content">
	    <%! block content %><%! endblock %>
	    </div>
	</body>
	</html>

### Template child.html extends base.html

	<%! extends base.html %>

	<%! block title %>My amazing blog<%! endblock %>

	<%! block content %>

	<% for k, entry in pairs(blog_entries) do %>
	<h2><%= entry.title %></h2>
	<p><%= entry.body %></p>
	<% end %>

	<%! endblock %>
