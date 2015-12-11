local main = {}
local sailor = require "sailor"
local markdown = require "markdown"

local function read_md(path)
	local f = io.open (sailor.path.."/"..path..".md", "rb")
	if f then 
	    local src = f:read("*all")
	    f:close()
	    return markdown(src)
	end
	return false
end

local function get_categories()
	local lfs = require "lfs"
	local categories = {}
	for file in lfs.dir(sailor.path..'/posts') do
		if lfs.chdir(sailor.path..'/posts/'..file) and file ~= '.' and file ~= '..' then
	    	categories[#categories+1] = file
	    end
	end
	return categories
end

local function get_category_total(name)
	local lfs = require "lfs"
	local total = 0
	for file in lfs.dir(sailor.path..'/posts/'..name) do
		total = total + 1
	end
	return total - 2
end


function main.index(page)
	local posts = assert(require "posts.posts_meta")
	local total = #posts
	local posts_per_page = sailor.conf.custom and sailor.conf.custom.posts_per_page or 3
	local page_counter = tonumber(page.GET.p) or 1
	local max_page = page_counter + 1
	local categories = get_categories()
	local filter
	if page.GET.c then
		filter = function(p) 
			if not p or not p.category then return false end
			return p.category == page.GET.c
		end
		total = get_category_total(page.GET.c) 
	end

	local min = page_counter * posts_per_page - posts_per_page + 1
	if posts_per_page > total then posts_per_page = total end

	local page_posts = {}
	while #page_posts < posts_per_page do
		if not posts[min] then
			break 
		end
		if not filter or filter(posts[min]) then
			local category = posts[min].category or 'general'
			posts[min].body = read_md('posts/'..category..'/'..posts[min].short_url)
			if posts[min].body then
				posts[min].url = sailor.conf.app_url..posts[min].category.."/"..posts[min].short_url
				page_posts[#page_posts+1] = posts[min]
			end
		end
		min = min + 1
	end

	-- Disable see older pagination
	if not posts[min] then
		max_page = page_counter
	elseif filter then
		max_page = page_counter 
		while min < #posts do
			if filter(posts[min]) then
				max_page = page_counter + 1
				break
			end
			min = min + 1
		end
	end


    page:render('index',{posts = page_posts, categories = categories, page_counter=page_counter, max_page = max_page})
end

function main.post(page)
	if not page.GET.t or not page.GET.c then return 404 end
	local posts = require "posts.posts_meta"
	local categories = get_categories()

	local post
	for _,p in ipairs(posts) do
		if p.short_url == page.GET.t and p.category == page.GET.c then
			post = p
			post.body = read_md('posts/'..post.category..'/'..post.short_url)
			if not post.body then error('Error opening post markdown') end 
		end
	end
	if not post then return 404 end
	post.url = sailor.conf.app_url..post.category.."/"..post.short_url

	page:render('post',{post = post, categories = categories})
end

function main.about(page)
	local categories = get_categories()
	page:render('about',{categories = categories})
end


return main
