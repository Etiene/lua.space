<style>
	.red{
		color: #ff0000;
	}
	.big-input{
		height: 120px !important;
	}
</style>

<?lua local form = require "sailor.form" ?>
<h2>Add a job listing</h2>
<h4>Important notices:</h4> 
<ul>
	<li>Your job post needs to be approved before appearing on the list</li>
	<li>It may take a few days until approval</li>
	<li>All job posts automatically expire after 2 months</li>
	<li>You can manually remove it before 2 months if you wish</li>
	<li>You may repost it</li>
	<li>For the moment, new submissions are <strong>free</strong> of charge</li>
</ul>

<?lua if saved == false then ?>
	There was an error while saving.
<?lua end ?>

<br/>
<span class="red">*</span> Required
<br/>
<br/>
<form method="post">
	<div class="form-group">
		
		<div class="form-group">
		<label>Email: <span class="red">*</span></label>
		<%= form.text(job,'email', 'class="form-control" placeholder="a@a.com"') %>
		<span class="help-block"> <%= job.errors.email or '' %> </span>
	</div>
		<label>Job title: <span class="red">*</span></label>
		<%= form.text(job,'title', 'class="form-control" placeholder="Title"') %>
		<span class="help-block"> <%= job.errors.title or '' %> </span>
	</div>
	<div class="form-group">
		<label>Location: <span class="red">*</span></label>
		<%= form.text(job,'location', 'class="form-control" placeholder="Location"') %>
		<span class="help-block"> <%= job.errors.location or '' %> </span>
	</div>
	<div class="form-group">
		<label>Employer name: <span class="red">*</span></label>
		<%= form.text(job,'employer', 'class="form-control" placeholder="Employer"') %>
		<span class="help-block"> <%= job.errors.employer or '' %> </span>
	</div>
	<div class="form-group">
		<label>Employer's website: <span class="red">*</span></label>
		<%= form.text(job,'employers_website', 'class="form-control" placeholder="http://"') %>
		<span class="help-block"> <%= job.errors.employers_website or '' %> </span>
	</div>
	<div class="form-group form-inline">
		<label class="col-sm-3">Job type: <span class="red">*</span></label>
		<%= form.dropdown(job,'type', job.formTypes, 'Select job type...', 'class="form-control" placeholder="type"') %>
		<span class="help-block"> <%= job.errors.type or '' %> </span>
		<label class="col-sm-3" >Duration:</label>
		<div class="input-group">
			<%= form.text(job,'length', 'class="form-control"') %>
			<div class="input-group-addon">months</div>
		</div>
		<span class="help-block"> <%= job.errors.length or '' %> </span>
	</div>
	<div class="form-group form-inline">
		<label class="col-sm-3">Salary Range:</label>
		<div class="input-group">
			<div class="input-group-addon">Between</div>
			<%= form.text(job,'salary_range_min', 'class="form-control" style="width: 100px" placeholder="min"') %>
			<div class="input-group-addon">and</div>
			<%= form.text(job,'salary_range_max', 'class="form-control"  style="width: 100px" placeholder="max"') %>
		</div>
		<span class="help-block"> <%= job.errors.salary_range_min or '' %> </span>
	</div>
	<div class="checkbox ">
		<div class="col-sm-1"> </div>
		<div class="col-sm-4">
			<%= form.checkbox(job,'allow_remote','Allows Telecommuting') %>
		</div>
		<span class="help-block"> <%= job.errors.allow_remote or '' %> </span>
	</div>
	<div class="checkbox">
		<div class="col-sm-3">
			<%= form.checkbox(job,'visa_sponsoring','Visa Sponsor') %> 
		</div>
		<span class="help-block"> <%= job.errors.visa_sponsoring or '' %> </span>
	</div>
	<div class="checkbox">
		<div class="col-sm-4">
			<%= form.checkbox(job,'relocation_aid','Relocation Aid') %>
		</div>
		<span class="help-block"> <%= job.errors.relocation_aid or '' %> </span>
	</div>
	<br/><br/>
	<div class="form-group">
		<label>Job description: <span class="red">*</span> (markdown accepted)</label>
		<%= form.textarea(job,'description', 'class="form-control big-input" placeholder="Job description..."') %>
		<span class="help-block"> <%= job.errors.description or '' %> </span>
	</div>
	<div class="form-group">
		<label>Skills required: (markdown accepted) </label>
		<%= form.textarea(job,'skills_required', 'class="form-control big-input" placeholder="Requirements..."') %>
		<span class="help-block"> <%= job.errors.skills_required or '' %> </span>
	</div>
	<div class="form-group">
		<label>Skills desired: (markdown accepted)</label>
		<%= form.textarea(job,'skills_desired', 'class="form-control big-input" placeholder="Bonus points..."') %>
		<span class="help-block"> <%= job.errors.skills_desired or '' %> </span>
	</div>
	<div class="form-group">
		<label>About the company: <span class="red">*</span> (markdown accepted)</label>
		<%= form.textarea(job,'about_company', 'class="form-control big-input" placeholder="Tells us a little about you..."') %>
		<span class="help-block"> <%= job.errors.about_company or '' %> </span>
	</div>
	<div class="form-group">
		<label>Benefits: (markdown accepted)</label>
		<%= form.textarea(job,'benefits', 'class="form-control big-input" placeholder="What are the perks?"') %>
		<span class="help-block"> <%= job.errors.benefits or '' %> </span>
	</div>
	<div class="form-group">
		<label>How to apply: <span class="red">*</span> (markdown accepted)</label>
		<%= form.textarea(job,'how_to_apply', 'class="form-control big-input" placeholder="Intructions on how to reach you..."') %>
		<span class="help-block"> <%= job.errors.how_to_apply or '' %> </span>
	</div>
	<!--
	<div class="form-group">
		<label>approved:</label>
		<%= form.text(job,'approved', 'class="form-control" placeholder="approved"') %>
		<span class="help-block"> <%= job.errors.approved or '' %> </span>
	</div>
	-->
	<input type="submit" class="btn btn-primary" value="Submit to approval"/>
</form>
<br/>
<a href="<%= page:make_url('jobs/index') %>"><- Back Job Listing</a>


<?lua@client


?>



