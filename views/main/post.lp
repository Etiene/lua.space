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

<?lua if post.author and post.author.name then ?>
<hr/>
<h3>About <%= post.author.name %></h3>
<%= (post.author.picture and '<img height="82px" class="img-circle pull-right" src="'..post.author.picture..'"/>' or '') %>
<%= (post.author.description or '')%>
<small>
	<%= (post.author.website and '<br/><a href="'..post.author.website..'">Website</a>' or '')%>
	<%= (post.author.twitter and '<br/><a href="'..post.author.twitter..'">Twitter</a>' or '')%>
	<%= (post.author.github and '<br/><a href="'..post.author.github..'">Github</a>' or '')%>
	<%= (post.author.facebook and '<br/><a href="'..post.author.facebook..'">Facebook</a>' or '')%>
	<%= (post.author.linkedin and '<br/><a href="'..post.author.linkedin..'">Linkedin</a>' or '')%>
</small>
<br/>

<?lua end ?>

<div id="disqus_thread"></div>
<script>
/**
* RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
* LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
*/

var disqus_config = function () {
this.page.url = '<%= post.url %>'; // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = '<%= post.category %>/<%= post.short_url %>'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};

(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');

s.src = '//luaspace.disqus.com/embed.js';

s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>

