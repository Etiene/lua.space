<br/>
<?lua
	for _,post in ipairs(posts) do
?>	
	<div class="panel panel-danger" style='margin-top:5px'>	
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
	</div>
<?lua end
?>
