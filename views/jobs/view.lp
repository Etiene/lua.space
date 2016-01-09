<h2>
	View job #<%= job.id %>
	<small>(<a href="<%= page:make_url('job/update', {id = job.id} ) %>" >update</a>)</small>
	<small>(<a href="<%= page:make_url('job/delete', {id = job.id} ) %>" >delete</a>)</small>
</h2>
<table class="table">
	<tr><td>int</td><td><%= job.int %> </td></tr>
	<tr><td>title</td><td><%= job.title %> </td></tr>
	<tr><td>description</td><td><%= job.description %> </td></tr>
	<tr><td>type</td><td><%= job.type %> </td></tr>
	<tr><td>length</td><td><%= job.length %> </td></tr>
	<tr><td>salary_range_min</td><td><%= job.salary_range_min %> </td></tr>
	<tr><td>salary_range_max</td><td><%= job.salary_range_max %> </td></tr>
	<tr><td>location</td><td><%= job.location %> </td></tr>
	<tr><td>employer</td><td><%= job.employer %> </td></tr>
	<tr><td>employers_website</td><td><%= job.employers_website %> </td></tr>
	<tr><td>skills_required</td><td><%= job.skills_required %> </td></tr>
	<tr><td>skills_desired</td><td><%= job.skills_desired %> </td></tr>
	<tr><td>about_company</td><td><%= job.about_company %> </td></tr>
	<tr><td>benefits</td><td><%= job.benefits %> </td></tr>
	<tr><td>how_to_apply</td><td><%= job.how_to_apply %> </td></tr>
	<tr><td>email</td><td><%= job.email %> </td></tr>
	<tr><td>posted_date</td><td><%= job.posted_date %> </td></tr>
	<tr><td>allow_remote</td><td><%= job.allow_remote %> </td></tr>
	<tr><td>visa_sponsoring</td><td><%= job.visa_sponsoring %> </td></tr>
	<tr><td>relocation_aid</td><td><%= job.relocation_aid %> </td></tr>
	<tr><td>approved</td><td><%= job.approved %> </td></tr>
</table>
<br/>
<a href="<%= page:make_url('job/index') %>"><- Back to View All</a>
