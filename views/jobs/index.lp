<style>
	.table td {
	    cursor: pointer;
	}
</style>
<h2>View all</h2>
<table class="table">
	<tr>
		<th>int</th>
		<th>title</th>
		<th>description</th>
		<th>type</th>
		<th>length</th>
		<th>salary_range_min</th>
		<th>salary_range_max</th>
		<th>location</th>
		<th>employer</th>
		<th>employers_website</th>
		<th>skills_required</th>
		<th>skills_desired</th>
		<th>about_company</th>
		<th>benefits</th>
		<th>how_to_apply</th>
		<th>email</th>
		<th>posted_date</th>
		<th>allow_remote</th>
		<th>visa_sponsoring</th>
		<th>relocation_aid</th>
		<th>approved</th>
	</tr>
	<?lua for k,v in pairs(jobs) do ?>
		<tr onclick="location.href='<%= page:make_url('job/view',{id = v.id}) %>'" >
			<td> <%= v.int %> </td>
			<td> <%= v.title %> </td>
			<td> <%= v.description %> </td>
			<td> <%= v.type %> </td>
			<td> <%= v.length %> </td>
			<td> <%= v.salary_range_min %> </td>
			<td> <%= v.salary_range_max %> </td>
			<td> <%= v.location %> </td>
			<td> <%= v.employer %> </td>
			<td> <%= v.employers_website %> </td>
			<td> <%= v.skills_required %> </td>
			<td> <%= v.skills_desired %> </td>
			<td> <%= v.about_company %> </td>
			<td> <%= v.benefits %> </td>
			<td> <%= v.how_to_apply %> </td>
			<td> <%= v.email %> </td>
			<td> <%= v.posted_date %> </td>
			<td> <%= v.allow_remote %> </td>
			<td> <%= v.visa_sponsoring %> </td>
			<td> <%= v.relocation_aid %> </td>
			<td> <%= v.approved %> </td>
		</tr>
	<?lua end ?>
</table>
<br/>
<a href="<%= page:make_url('job/create') %>" class="btn btn-primary">Create new job</a>
