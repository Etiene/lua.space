## Introducing Lua in Enterprise

I've recently had the experience of introducing Lua into an established Node.js-based development team. The whole experience was largely a success. This could be interesting background reading for those considering doing the same.

### Why did we go down the Lua path?

We were searching for an API gateway solution - OpenResty is really a no-brainer for something like this, especially when a team has existing Nginx setup and knowledge. Writing our own custom API gateway using OpenResty resulted in a solid codebase that handled a high number of requests per second without much fanfare while applying custom authorisation on each request.

While spiking OpenResty as the basis for an API gateway, we experienced a lot of difficulty in migrating an older custom Node.js DB replication tool onto a fragile network path. The application needed to maintain a keepalive while making POST requests - this proved difficult in Node.js 0.10. In addition, Node.js was struggling to manage CPU usage when performing a heavy workload. This would show itself in the occasional lockup of Node, which could be stuck for up to 30 minutes. A simple rewrite of the Node.js replication tool using Lua gave strong and immediate results - keepalive could be easily kept due to synchronous and lower level HTTP libraries in Lua, and the CPU usage was miniscule compared to the Node.js solution. This quick rewrite soon replaced the Node.js solution in production.

### Team impact

Team reaction was mixed to positive. Some of the team hit frustations with some error-reporting and poorly designed 'require' semantics, however overall people were quite excited to be using a novel stack. The codebase has been picked up and improved by team members with no Lua background, and the use of LuaJIT did help us in convincing a possible hire that we were doing interesting work.

The most frustrating aspect has probably been the difficulty in ensuring that local development is easy. Luarocks and OpenResty do not play enormously well together, and the use of OS X on development has made for a challenging local setup.

### Overall thoughts

Lua is a language that is ready to be used in an enterprise environment. It has significant performance advantages that shouldn't be ignored, and is similar enough to Javascript that developers can pick it up very easily. Tooling still has some rough edges - the overall approach of batteries-not-included means that programmers will often have to reinvent the wheel, but also can allow for greater control and forces the programmer to have a more detailed understanding of what is actually going on.
