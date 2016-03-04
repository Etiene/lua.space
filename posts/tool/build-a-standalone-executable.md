`luastatic` is a command line tool which builds a standalone executable from a Lua program. The executable runs on systems which do not have Lua installed because Lua is embedded alongside the program. Lua 5.1, 5.2, 5.3 and LuaJIT are supported. `luastatic` can be [downloaded from GitHub](https://github.com/ers35/luastatic).

Run `make` to build. A hello world program is included:
	
	make
	./luastatic test/hello.lua liblua.a -Ilua-5.2.4/src
	./hello
	# Hello, world!

`luastatic` generates the C source file hello.lua.c containing the Lua program and runs the following command to build the executable:

	cc -Os -std=c99 test/hello.lua.c liblua.a -rdynamic -ldl -lm  -Ilua-5.2.4/src -o hello

If you are familiar with C you can read hello.lua.c to see the generated calls to the Lua C API.

Below is a description of the arguments `luastatic` supports:

	luastatic main.lua[1] require.lua[2] liblua.a[3] module.a[4] -Iinclude/lua[5] [6]
	[1]: The entry point to the Lua program
	[2]: One or more required Lua source files
	[3]: The Lua intepreter static library
	[4]: One or more static libraries for a required Lua binary module
	[5]: The path to the directory containing lua.h
	[6]: Additional arguments are passed to the C compiler

Here is an example of building a more complex project with multiple dependencies:

	# https://github.com/ignacio/luagleck
	luastatic main.lua display.lua logger.lua machine.lua port.lua z80.lua \
	file_format/*.lua machine/spectrum_48.lua opcodes/*.lua liblua.a SDL.a -Ilua-5.3.1/src \
	-lSDL2
	./main
	
See the [Makefile](https://github.com/ers35/luastatic/blob/master/Makefile#L21) for more examples.

If you find a program that `luastatic` does not build or where the resulting executable does not behave the same as when run with Lua, please [report the issue](https://github.com/ers35/luastatic/issues) or email eric@ers35.com.
