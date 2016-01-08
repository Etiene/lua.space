<style>
.post-container{
	height: 300px;
	position: relative;
}
.post-body-index{
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
	width: 100%;
	height: 300px;
	padding: 5px;
}
.post-body-index-shadow{
	position: absolute;
	width: 100%;
	height: 100%;
	pointer-events: none;
	top: 0px;
	left: 0px;
	background: linear-gradient(rgba(255,255,255,0.3) 50%, #dfdfdf 95%, #ddd 95%);
	border-radius: 10px;
	z-index: 10;
	opacity: 0.5;
}
.read-more-div{
	position: relative;
	width: 125px;
	margin: 0 auto;
	top: 10px;
}

</style>

<?lua
	for _,post in ipairs(posts) do
?>	
		<h1><a href="<%=post.url%>"><div class="post-title"><%=post.page_title%></div></a></h1>
		<small>
			By <%=post.author.name%> 
			<i class="glyphicon glyphicon-dashboard" style="margin-left: 8px" ></i> <%=post.date%> 
			<i class="glyphicon glyphicon-tag" style="margin-left: 8px" ></i> 
			<a href="/<%=post.category%>"><%=(post.category:gsub("^%l", string.upper))%></a>
			<i class="glyphicon glyphicon-comment" style="margin-left: 8px" ></i> 
			<a href="<%=post.url%>#disqus_thread" data-disqus-identifier="<%=post.category%>/<%=post.short_url%>">Comments</a>
		</small>
		<hr/>
		<div class="post-container">
			<div class="post-body-index-shadow"></div>
			<div class="post-body-index">
				<%=post.body%>
			</div>
		</div>
		<div class="read-more-div">
			<a href="<%=post.url%>" class="btn btn-info">Read more...</a>
		</div>
		<br/>
<?lua end
?>

<nav>
  <ul class="pager">
  	 <?lua if max_page > page_counter then ?>
    	<li class="previous"><a href="/<%=(page.GET.c and page.GET.c..'/'..(page_counter+1) or (page_counter+1))%>"><span aria-hidden="true">&larr;</span> Older</a></li>
    <?lua end?>
    <?lua if page_counter > 1 then ?>
    	<li class="next"><a href="/<%=(page.GET.c and page.GET.c..'/'..(page_counter-1) or (page_counter-1))%>">Newer <span aria-hidden="true">&rarr;</span></a></li>
    <?lua end?>
  </ul>
</nav>

<?lua@client
local last_scroll_pos
local subtitle = window.document:getElementById("blog-subtitle")

window.onscroll = function (oEvent) 
  local title_divs = window.document:getElementsByClassName("post-title")
  local scroll_pos = window.document:getElementsByTagName("body")[0].scrollTop
  if scroll_pos>last_scroll_pos then -- Going down
  	
  	for i=0,title_divs.length-1 do
	    local post_position = title_divs[i].offsetTop
	    if scroll_pos >= post_position then
	    	subtitle.innerHTML = title_divs[i].innerHTML
	    end
	    	
    end
  else -- Going up
  	subtitle.innerHTML = '<a href="/">The Lua Community Blog</a>';
  end
  last_scroll_pos = scroll_pos
end
?>
