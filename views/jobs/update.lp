<?lua local form = require "sailor.form" ?>
<h2>Update job</h2>
<?lua if saved == false then ?>
	There was an error while saving.
<?lua end ?>
<form method="post">
	<div class="form-group">
		<label>int:</label>
		<%= form.text(job,'int', 'class="form-control" placeholder="int"') %>
	</div>
	<div class="form-group">
		<label>title:</label>
		<%= form.text(job,'title', 'class="form-control" placeholder="title"') %>
	</div>
	<div class="form-group">
		<label>description:</label>
		<%= form.text(job,'description', 'class="form-control" placeholder="description"') %>
	</div>
	<div class="form-group">
		<label>type:</label>
		<%= form.text(job,'type', 'class="form-control" placeholder="type"') %>
	</div>
	<div class="form-group">
		<label>length:</label>
		<%= form.text(job,'length', 'class="form-control" placeholder="length"') %>
	</div>
	<div class="form-group">
		<label>salary_range_min:</label>
		<%= form.text(job,'salary_range_min', 'class="form-control" placeholder="salary_range_min"') %>
	</div>
	<div class="form-group">
		<label>salary_range_max:</label>
		<%= form.text(job,'salary_range_max', 'class="form-control" placeholder="salary_range_max"') %>
	</div>
	<div class="form-group">
		<label>location:</label>
		<%= form.text(job,'location', 'class="form-control" placeholder="location"') %>
	</div>
	<div class="form-group">
		<label>employer:</label>
		<%= form.text(job,'employer', 'class="form-control" placeholder="employer"') %>
	</div>
	<div class="form-group">
		<label>employers_website:</label>
		<%= form.text(job,'employers_website', 'class="form-control" placeholder="employers_website"') %>
	</div>
	<div class="form-group">
		<label>skills_required:</label>
		<%= form.text(job,'skills_required', 'class="form-control" placeholder="skills_required"') %>
	</div>
	<div class="form-group">
		<label>skills_desired:</label>
		<%= form.text(job,'skills_desired', 'class="form-control" placeholder="skills_desired"') %>
	</div>
	<div class="form-group">
		<label>about_company:</label>
		<%= form.text(job,'about_company', 'class="form-control" placeholder="about_company"') %>
	</div>
	<div class="form-group">
		<label>benefits:</label>
		<%= form.text(job,'benefits', 'class="form-control" placeholder="benefits"') %>
	</div>
	<div class="form-group">
		<label>how_to_apply:</label>
		<%= form.text(job,'how_to_apply', 'class="form-control" placeholder="how_to_apply"') %>
	</div>
	<div class="form-group">
		<label>email:</label>
		<%= form.text(job,'email', 'class="form-control" placeholder="email"') %>
	</div>
	<div class="form-group">
		<label>posted_date:</label>
		<%= form.text(job,'posted_date', 'class="form-control" placeholder="posted_date"') %>
	</div>
	<div class="form-group">
		<label>allow_remote:</label>
		<%= form.text(job,'allow_remote', 'class="form-control" placeholder="allow_remote"') %>
	</div>
	<div class="form-group">
		<label>visa_sponsoring:</label>
		<%= form.text(job,'visa_sponsoring', 'class="form-control" placeholder="visa_sponsoring"') %>
	</div>
	<div class="form-group">
		<label>relocation_aid:</label>
		<%= form.text(job,'relocation_aid', 'class="form-control" placeholder="relocation_aid"') %>
	</div>
	<div class="form-group">
		<label>approved:</label>
		<%= form.text(job,'approved', 'class="form-control" placeholder="approved"') %>
	</div>
	<input type="submit" class="btn btn-primary"/>
</form>
<br/>
<a href="<%= page:make_url('job/index') %>"><- Back to View All</a>
