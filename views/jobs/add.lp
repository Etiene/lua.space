<?lua local form = require "sailor.form" ?>
<h2>Add a job listing</h2>
<h4>Important notices:</h4> 
<ul>
	<li>Your job post needs to be approved before appearing on the list</li>
	<li>It may take a few days until approval</li>
	<li>All job posts automatically expire after 3 months</li>
	<li>You can manually remove it before 3 months if you wish</li>
	<li>You may repost it</li>
</ul>

<?lua if saved == false then ?>
	There was an error while saving.
<?lua end ?>
<form method="post">
	<div class="form-group">
		<label>Job title *:</label>
		<%= form.text(job,'title', 'class="form-control" placeholder="title"') %>
		<span class="help-block"> <%= job.errors.title or '' %> </span>
	</div>
	<div class="form-group">
		<label>Job description *: (markdown accepted)</label>
		<%= form.textarea(job,'description', 'class="form-control" style="height: 120px" placeholder="Job description"') %>
		<span class="help-block"> <%= job.errors.description or '' %> </span>
	</div>
	<div class="form-group">
		<label>Job type *:</label>
		<%= form.dropdown(job,'type', job.formTypes, 'Select job type...', 'class="form-control" placeholder="type"') %>
		<span class="help-block"> <%= job.errors.type or '' %> </span>
	</div>
	<div class="form-group">
		<label>Duration: (leave blank if it does not apply)</label>
		<%= form.text(job,'length', 'class="form-control" placeholder="length"') %>
		<span class="help-block"> <%= job.errors.length or '' %> </span>
	</div>
	<div class="form-group">
		<label>salary_range_min:</label>
		<%= form.text(job,'salary_range_min', 'class="form-control" placeholder="salary_range_min"') %>
		<span class="help-block"> <%= job.errors.salary_range_min or '' %> </span>
	</div>
	<div class="form-group">
		<label>salary_range_max:</label>
		<%= form.text(job,'salary_range_max', 'class="form-control" placeholder="salary_range_max"') %>
		<span class="help-block"> <%= job.errors.salary_range_max or '' %> </span>
	</div>
	<div class="form-group">
		<label>location:</label>
		<%= form.text(job,'location', 'class="form-control" placeholder="location"') %>
		<span class="help-block"> <%= job.errors.location or '' %> </span>
	</div>
	<div class="form-group">
		<label>employer:</label>
		<%= form.text(job,'employer', 'class="form-control" placeholder="employer"') %>
		<span class="help-block"> <%= job.errors.employer or '' %> </span>
	</div>
	<div class="form-group">
		<label>employers_website:</label>
		<%= form.text(job,'employers_website', 'class="form-control" placeholder="employers_website"') %>
		<span class="help-block"> <%= job.errors.employers_website or '' %> </span>
	</div>
	<div class="form-group">
		<label>skills_required:</label>
		<%= form.text(job,'skills_required', 'class="form-control" placeholder="skills_required"') %>
		<span class="help-block"> <%= job.errors.skills_required or '' %> </span>
	</div>
	<div class="form-group">
		<label>skills_desired:</label>
		<%= form.text(job,'skills_desired', 'class="form-control" placeholder="skills_desired"') %>
		<span class="help-block"> <%= job.errors.skills_desired or '' %> </span>
	</div>
	<div class="form-group">
		<label>about_company:</label>
		<%= form.text(job,'about_company', 'class="form-control" placeholder="about_company"') %>
		<span class="help-block"> <%= job.errors.about_company or '' %> </span>
	</div>
	<div class="form-group">
		<label>benefits:</label>
		<%= form.text(job,'benefits', 'class="form-control" placeholder="benefits"') %>
		<span class="help-block"> <%= job.errors.benefits or '' %> </span>
	</div>
	<div class="form-group">
		<label>how_to_apply:</label>
		<%= form.text(job,'how_to_apply', 'class="form-control" placeholder="how_to_apply"') %>
		<span class="help-block"> <%= job.errors.how_to_apply or '' %> </span>
	</div>
	<div class="form-group">
		<label>email:</label>
		<%= form.text(job,'email', 'class="form-control" placeholder="email"') %>
		<span class="help-block"> <%= job.errors.email or '' %> </span>
	</div>
	<div class="form-group">
		<label>posted_date:</label>
		<%= form.text(job,'posted_date', 'class="form-control" placeholder="posted_date"') %>
		<span class="help-block"> <%= job.errors.posted_date or '' %> </span>
	</div>
	<div class="form-group">
		<label>allow_remote:</label>
		<%= form.text(job,'allow_remote', 'class="form-control" placeholder="allow_remote"') %>
		<span class="help-block"> <%= job.errors.allow_remote or '' %> </span>
	</div>
	<div class="form-group">
		<label>visa_sponsoring:</label>
		<%= form.text(job,'visa_sponsoring', 'class="form-control" placeholder="visa_sponsoring"') %>
		<span class="help-block"> <%= job.errors.visa_sponsoring or '' %> </span>
	</div>
	<div class="form-group">
		<label>relocation_aid:</label>
		<%= form.text(job,'relocation_aid', 'class="form-control" placeholder="relocation_aid"') %>
		<span class="help-block"> <%= job.errors.relocation_aid or '' %> </span>
	</div>
	<div class="form-group">
		<label>approved:</label>
		<%= form.text(job,'approved', 'class="form-control" placeholder="approved"') %>
		<span class="help-block"> <%= job.errors.approved or '' %> </span>
	</div>
	<input type="submit" class="btn btn-primary"/>
</form>
<br/>
<a href="<%= page:make_url('jobs/index') %>"><- Back to View All</a>
