local markdown = require "markdown"
local lfs = require "lfs"
local AMOUNT = 10
local date = require "date"

local function read_md(path)
	local f = io.open (path..".md", "rb")
	if f then 
	    local src = f:read("*all")
	    f:close()
	    return markdown(src)
	end
	return false
end

local function get_posts()
	local posts = require "posts.posts_meta"
	if #posts < AMOUNT then AMOUNT = #posts end

	local rss_posts = {}
	for i=1,AMOUNT do
		posts[i].date = tostring(date(posts[i].date)).." GMT"
		local category = posts[i].category or 'general'
		posts[i].body = read_md('posts/'..category..'/'..posts[i].short_url)
		posts[i].url = "http://lua.space/"..category..'/'..posts[i].short_url
		rss_posts[#rss_posts+1] = posts[i]
	end
	return rss_posts
end

local function build_rss()
	local rss = {
		[[<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
<channel>
<title>Lua.Space</title>
<link>http://http://lua.space/</link>
<description>The unofficial Lua blog</description>]]
	}

	local item_template = {
		[[

	<item>
		<title>]],
		"title",
		[[</title>
		<link>]],
		"url",
		[[</link>
		<guid>]],
		"url again",
		[[</guid>
		<pubDate>]],
		"date",
		[[</pubDate>
		<description><![CDATA[]],
		"content",
		[=[
		]]></description>
	</item>]=]
	}

	for _,p in ipairs(get_posts()) do
		item_template[2] = p.page_title
		item_template[4] = p.url
		item_template[6] = p.url
		item_template[8] = p.date
		item_template[10] = p.body
		rss[#rss+1] = table.concat(item_template)
	end

	rss[#rss+1] = [[

</channel>
</rss>]]

--	print(table.concat(rss))
	local file = io.output ("rss.xml")
	file:write(table.concat(rss))
	file:close()

end

build_rss()