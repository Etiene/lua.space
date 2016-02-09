<style>
	a {
		text-decoration: none !important;
	}
</style>
<?lua 
local date = require "date"
	local salary_range 
	salary_range_min = job.salary_range_min
	if not job.salary_range_min and not job.salary_range_max then
		salary_range = ' '
	elseif job.salary_range_min and not job.salary_range_max then
		salary_range = job.salary_range_min..' or more '
	elseif not job.salary_range_min and job.salary_range_max then
		salary_range = 'Up to '..job.salary_range_max
	else
		salary_range = job.salary_range_min..' - '..job.salary_range_max
	end

	local location = job.location or ''

	local remote = job.allow_remote and '<i class="fa fa-wifi"></i> Remote allowed' or ''
	local visa = job.visa_sponsoring and '<i class="fa fa-newspaper-o" style="margin-left: 8px;"></i> Visa sponsor' or ''
	local reloc = job.relocation_aid and '<i class="fa fa-suitcase" style="margin-left: 8px;"></i> Relocation aid' or ''
	local md = require "markdown"
	local description = job.description and 
						job.description:len() > 1 and 
						"<h5>Description</h5>"..md(job.description) or ''
	local skills_r = job.skills_required and 
					 job.skills_required:len() > 1 and
					 "<h5>Skills Required</h5>"..md(job.skills_required) or ''
	local skills_d = job.skills_desired and 
					 job.skills_desired:len() > 1 and
					 "<h5>Skills Desired</h5>"..md(job.skills_desired) or ''
	local about = job.about_company and 
				 	job.about_company:len() > 1 and
				 	"<h5>About the company</h5>"..md(job.about_company) or ''
	local benefits = job.benefits and 
					 job.benefits:len() > 1 and
					 "<h5>Benefits</h5>"..md(job.benefits) or ''
	local apply = job.how_to_apply and 
					job.how_to_apply:len() > 1 and
					"<h5>How to apply</h5>"..md(job.how_to_apply) or ''

?>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-10">
			<h2>
				<%= job.title %> <small> ( <%= job.type %> )  </small> 
			</h2>
		</div>
		<div class="col-md-2">
			<h3><small><p class="text-success text-right"> <%= salary_range %> </p></small></h3>
		</div>
	</div>
	<hr/>
	<div class="row">
		<div class="col-md-8">
			<h3><a href="<%= job.employers_website %>" target="_blank"><%= job.employer %></a></h3>
		</div>
		<div class="col-md-4">
			<p class="text-right"><%= location %></p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			Posted on <%= date(job.posted_date ):fmt("%b %d %Y") %>
		</div>
		<div class="col-md-6 pull-right text-right">
			<%= remote %>
			<%= reloc %>
			<%= visa %>
		</div>
	</div>
		<div class="row">
			<div class="col-md-12">
				<%= description %>
				<%= skills_r %>
				<%= skills_d %>
				<%= about %>
				<%= benefits %>
				<%= apply %>
			</div>
		</div>
</div>
<br/>
<a href="<%= page:make_url('jobs/index') %>" class="btn btn-primary"><-- Go back to all job listings</a>
<br/>
