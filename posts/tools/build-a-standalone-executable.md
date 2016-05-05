`luastatic` is a command line tool that builds a standalone executable from a Lua program. The executable runs on systems that do not have Lua installed because Lua is embedded alongside the program. Lua 5.1, 5.2, 5.3 and LuaJIT are supported. `luastatic` can be [downloaded from GitHub](https://github.com/ers35/luastatic) or [LuaRocks](http://luarocks.org/modules/ers35/luastatic).

Lua is commonly used as an embeddable scripting language as part of a larger program written in another language. However, Lua can also be the primary language used to implement a program. Programmers using C are accustomed to building an application to a single executable that is distributed to the end user. `luastatic` does the same for Lua programs.

Below is a description of the arguments `luastatic` supports:

	luastatic main.lua[1] require.lua[2] liblua.a[3] module.a[4] -Iinclude/lua[5] [6]
	[1]: The entry point to the Lua program
	[2]: One or more required Lua source files
	[3]: The Lua interpreter static library
	[4]: One or more static libraries for a required Lua binary module
	[5]: The path to the directory containing lua.h
	[6]: Additional arguments are passed to the C compiler

The shell script below shows how to use `luastatic` to build [this program](http://lua.sqlite.org/index.cgi/artifact/0c08de88e066ef2d) for GNU/Linux and Windows. The program uses [Lua](https://www.lua.org/), [LuaSQLite3](http://lua.sqlite.org/index.cgi/home), and [SQLite3](http://sqlite.org/). I tested the script on Ubuntu 15.04.

	#/bin/sh
	
	# download build tools (if necessary)
	sudo apt-get install build-essential make mingw-w64 unzip libreadline-dev
	
	# download program dependencies
	wget https://www.lua.org/ftp/lua-5.2.4.tar.gz
	wget https://raw.githubusercontent.com/ers35/luastatic/master/luastatic.lua
	wget http://sqlite.org/2016/sqlite-amalgamation-3110100.zip
	wget http://lua.sqlite.org/index.cgi/zip/lsqlite3_fsl09w.zip
	wget http://lua.sqlite.org/index.cgi/raw/examples/simple.lua?name=0c08de88e066ef2d6cf59c4be3d7ce2aa7df32c9 -O simple.lua
	
	# extract dependencies
	tar -xf lua-5.2.4.tar.gz
	unzip sqlite-amalgamation-3110100.zip
	unzip lsqlite3_fsl09w.zip
	
	# create build directories
	mkdir linux windows
	cp simple.lua linux
	cp simple.lua windows
	
	# build Lua for GNU/Linux
	cd lua-5.2.4
	make linux
	mv src/lua ../
	mv src/liblua.a ../linux
	make clean
	# build Lua for Windows
	make mingw CC=x86_64-w64-mingw32-gcc
	mv src/liblua.a ../windows
	cd ../
	
	# build luastatic using itself
	./lua luastatic.lua luastatic.lua linux/liblua.a -Ilua-5.2.4/src
	cp ./luastatic linux
	cp ./luastatic windows
	
	# build SQLite3 for GNU/Linux
	cd sqlite-amalgamation-3110100
	cc -c -O2 sqlite3.c -o sqlite3.o
	ar rcs ../linux/sqlite3.a sqlite3.o
	# build SQLite3 for Windows
	x86_64-w64-mingw32-gcc -c -O2 sqlite3.c -o sqlite3.o
	x86_64-w64-mingw32-ar rcs ../windows/sqlite3.a sqlite3.o
	cd ../
	
	# build LuaSQLite3 for GNU/Linux
	cd lsqlite3_fsl09w
	cc -c -O2 lsqlite3.c -I../sqlite-amalgamation-3110100 -I../lua-5.2.4/src -o lsqlite3.o
	ar rcs ../linux/lsqlite3.a lsqlite3.o
	# build LuaSQLite3 for Windows
	x86_64-w64-mingw32-gcc -c -O2 lsqlite3.c -I../sqlite-amalgamation-3110100 -I../lua-5.2.4/src -o lsqlite3.o
	x86_64-w64-mingw32-ar rcs ../windows/lsqlite3.a lsqlite3.o
	cd ../
	
	# build simple.lua for GNU/Linux
	cd linux
	./luastatic simple.lua liblua.a sqlite3.a lsqlite3.a -I../lua-5.2.4/src -lpthread
	strip simple
	cd ../
	
	# build simple.lua for Windows
	cd windows
	CC=x86_64-w64-mingw32-gcc ./luastatic simple.lua liblua.a sqlite3.a lsqlite3.a -I../lua-5.2.4/src -lpthread
	strip simple.exe

`luastatic` generates the C source file simple.lua.c containing the Lua program and runs the following command to build the executable:

	cc -Os -std=c99 simple.lua.c liblua.a -rdynamic -ldl -lm lsqlite3.a sqlite3.a -I../lua-5.2.4/src -lpthread -o simple

If you are familiar with C you can read the file simple.lua.c to see the generated calls to the Lua C API.

If you find a program that `luastatic` does not build or where the resulting executable does not behave the same as when run with Lua, please [report the issue](https://github.com/ers35/luastatic/issues) or email eric@ers35.com with enough detail to reproduce the build.
