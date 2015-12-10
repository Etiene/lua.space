<?lua
	for _,post in ipairs(posts) do
?>	
		<h1><a href="<%=post.url%>"><%=post.page_title%></a></h1>
		<small>
			By <%=post.author.name%> 
			<i class="glyphicon glyphicon-dashboard" style="margin-left: 8px" ></i> <%=post.date%> 
			<i class="glyphicon glyphicon-tag" style="margin-left: 8px" ></i> 
			<a href="/<%=post.category%>"><%=(post.category:gsub("^%l", string.upper))%></a>
			<i class="glyphicon glyphicon-comment" style="margin-left: 8px" ></i> 
			<a href="<%=post.url%>#disqus_thread" data-disqus-identifier="<%=post.category%>/<%=post.short_url%>">Comments</a>
		</small>
		<hr/>
		<%=post.body%>

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
