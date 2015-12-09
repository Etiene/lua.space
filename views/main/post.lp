<br/>
<div class="panel panel-danger" style='margin-top:5px'>	
	<h1><a href="<%=post.url%>"><%=post.page_title%></a></h1>
	<small>Category: <a href=/"<%=post.category%>"><%=(post.category:gsub("^%l", string.upper))%></a></small>
		<hr/>
	<%=post.body%>
	<hr/>
	<small>By <%=post.author.name%> on <%=post.date%></small>
	<br/><br/>
</div>

<?lua if post.author and post.author.name then ?>

<div class="panel panel-danger" style='margin-top:5px'>	
	<h3>About <%= post.author.name %></h3>
	<%= (post.author.picture and '<img height="64px" class="img-circle pull-right" src="'..post.author.picture..'"/>' or '') %>
	<%= (post.author.description or '')%>
	<small>
		<%= (post.author.website and '<br/><a href="'..post.author.website..'">Website</a>' or '')%>
		<%= (post.author.twitter and '<br/><a href="'..post.author.twitter..'">Twitter</a>' or '')%>
		<%= (post.author.github and '<br/><a href="'..post.author.github..'">Github</a>' or '')%>
		<%= (post.author.facebook and '<br/><a href="'..post.author.facebook..'">Facebook</a>' or '')%>
		<%= (post.author.linkedin and '<br/><a href="'..post.author.linkedin..'">Linkedin</a>' or '')%>
	</small>
  <br/><br/>
</div>

<?lua end ?>

<div id="disqus_thread"></div>
<script>
/**
* RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
* LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
*/

var disqus_config = function () {
this.page.url = '<%= post.url %>'; // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = 'luaspace'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};

(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');

s.src = '//luaspace.disqus.com/embed.js';

s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>

