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
<form method="post" id="job_add">
	<div class="form-group">
		<label class="control-label">Email: <span class="red">*</span></label>
		<%= form.email(job,'email', 'class="form-control" placeholder="a@a.com"') %>
		<span class="help-block" id='job:email:error'> <%= job.errors.email or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">Job title: <span class="red">*</span></label>
		<%= form.text(job,'title', 'class="form-control" placeholder="Title"') %>
		<span class="help-block" id='job:title:error'> <%= job.errors.title or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">Location: </label>
		<%= form.text(job,'location', 'class="form-control" placeholder="Location"') %>
		<span class="help-block" id='job:location:error'> <%= job.errors.location or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">Employer name: <span class="red">*</span></label>
		<%= form.text(job,'employer', 'class="form-control" placeholder="Employer"') %>
		<span class="help-block" id='job:employer:error'> <%= job.errors.employer or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">Employer's website: <span class="red">*</span></label>
		<%= form.url(job,'employers_website', 'class="form-control" placeholder="http://"') %>
		<span class="help-block" id='job:employers_website:error'> <%= job.errors.employers_website or '' %> </span>
	</div>
	<div class="form-group form-inline">
		<label class="col-sm-3" class="control-label">Job type: <span class="red">*</span></label>
		<%= form.dropdown(job,'type', job.formTypes, 'Select job type...', 'class="form-control" placeholder="type"') %>
		<span class="help-block" id='job:type:error'> <%= job.errors.type or '' %> </span>
	</div>
	<div class="form-group form-inline">
		<label class="col-sm-3" class="control-label">Duration:</label>
		<div class="input-group">
			<%= form.number(job,'length', 'class="form-control"') %>
			<div class="input-group-addon">months</div>
		</div>
		<span class="help-block" id='job:length:error'> <%= job.errors.length or '' %> </span>
	</div>
	<div class="form-group form-inline">
		<label class="col-sm-3" class="control-label">Salary Range:</label>
		<div class="input-group">
			<div class="input-group-addon">Between</div>
			<%= form.text(job,'salary_range_min', 'class="form-control" style="width: 100px" placeholder="min"') %>
			<div class="input-group-addon">and</div>
			<%= form.text(job,'salary_range_max', 'class="form-control"  style="width: 100px" placeholder="max"') %>
		</div>
		<span class="help-block" id='job:salary_range_min:error'> <%= job.errors.salary_range_min or '' %> </span>
		<span class="help-block" id='job:salary_range_max:error'> <%= job.errors.salary_range_max or '' %> </span>
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
		<label class="control-label">Job description: <span class="red">*</span> (markdown accepted)</label>
		<%= form.textarea(job,'description', 'class="form-control big-input" placeholder="Job description..."') %>
		<span class="help-block" id='job:description:error'> <%= job.errors.description or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">Skills required: (markdown accepted) </label>
		<%= form.textarea(job,'skills_required', 'class="form-control big-input" placeholder="Requirements..."') %>
		<span class="help-block" id='job:skills_required:error'> <%= job.errors.skills_required or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">Skills desired: (markdown accepted)</label>
		<%= form.textarea(job,'skills_desired', 'class="form-control big-input" placeholder="Bonus points..."') %>
		<span class="help-block" id='job:skills_desired:error'> <%= job.errors.skills_desired or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">About the company: <span class="red">*</span> (markdown accepted)</label>
		<%= form.textarea(job,'about_company', 'class="form-control big-input" placeholder="Tells us a little about you..."') %>
		<span class="help-block" id='job:about_company:error'> <%= job.errors.about_company or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">Benefits: (markdown accepted)</label>
		<%= form.textarea(job,'benefits', 'class="form-control big-input" placeholder="What are the perks?"') %>
		<span class="help-block" id='job:benefits:error'> <%= job.errors.benefits or '' %> </span>
	</div>
	<div class="form-group">
		<label class="control-label">How to apply: <span class="red">*</span> (markdown accepted)</label>
		<%= form.textarea(job,'how_to_apply', 'class="form-control big-input" placeholder="Intructions on how to reach you..."') %>
		<span class="help-block" id='job:how_to_apply:error'> <%= job.errors.how_to_apply or '' %> </span>
	</div>
	<input type="submit" class="btn btn-primary" value="Submit to approval"/>
</form>
<br/>
<a href="<%= page:make_url('jobs/index') %>"><- Back Job Listing</a>


<?lua page:to_browser{job_types = job.types} ?>

<?lua@client
window.extract()

local v = require "valua"

local rules = {
	email = v:new().not_empty().email(),
	title = v:new().not_empty().len(10,100),
	location = v:new().len(0,200),
	employer = v:new().not_empty().len(5,100),
	employers_website = v:new().not_empty().len(1,255).match('^http://[%w]+%.[%w]+.*'),
	description = v:new().not_empty().len(10,2000),
	skills_required = v:new().len(0,500),
	skills_desired = v:new().len(0,500),
	about_company  = v:new().not_empty().len(10,500),
	benefits = v:new().len(0,500),
	how_to_apply  = v:new().not_empty().len(10,500),
	type = v:new().not_empty().in_list(job_types),
	length = v:new().integer(),
	salary_range_min = v:new().len(0,50),
	salary_range_max = v:new().len(0,50),
}


local function validateInput(attr,input)
	return function()
		local check,msg = rules[attr](input.value)
		local parent = input.parentNode
		local error = document:getElementById('job:'..attr..':error')

		if check then
			parent.classList:remove('has-error')
			parent.classList:add('has-success')
			error.innerHTML = ''
		else
			parent.classList:remove('has-success')
			parent.classList:add('has-error')
			error.innerHTML = 'Value '..tostring(msg)
		end
		return check
	end
end

-- Add focus out listeners
for attr,rule in pairs(rules) do 
	local input = document:getElementById('job:'..attr)
	input:addEventListener("focusout", validateInput(attr,input))
end

local form = document:getElementById('job_add')
local function validateForm()
	local check = true
	for attr,rule in pairs(rules) do 
		local input = document:getElementById('job:'..attr)
		local val = validateInput(attr,input)()
		check = check and val
	end
	
	if check == true then
		form:submit()
	end
end
form.onsubmit = function(event) event:preventDefault() validateForm() end


?>



