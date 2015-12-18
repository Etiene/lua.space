<h1>Archive</h1>
<br/>
<?lua for _, p in pairs(posts) do ?>
	<%=p.date%>: [<%=p.category%>] <a href="<%=p.url%>"><%=p.page_title%></a></br>
<?lua end?>
<br/>
<br/>
<br/>
<br/>