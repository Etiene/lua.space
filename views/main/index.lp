<br/>
<?lua
	for _,post in ipairs(posts) do
?>	
	<div class="panel panel-danger" style='margin-top:5px'>	
		<h1><a href="<%=post.url%>"><%=post.page_title%></a></h1>
		<small>Category: <a href="/<%=post.category%>"><%=(post.category:gsub("^%l", string.upper))%></a></small>
			<hr/>
		<%=post.body%>
		<hr/>
		<small>By <%=post.author.name%> on <%=post.date%></small>

		<a href="<%=post.url%>#disqus_thread">Comments</a>

		<br/><br/>
	</div>
<?lua end
?>

<script id="dsq-count-scr" src="//luaspace.disqus.com/count.js" async></script>