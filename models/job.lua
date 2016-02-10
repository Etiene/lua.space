local job = {}
local v = require "valua"

job.types = {
	"Contract",
	"Internship",
	"Part-time",
	"Full-time",
	"Part or Full-time"
}

job.formTypes = (function() local jt = {}
		for _,t in ipairs(job.types) do
			jt[t] = t
		end
		return jt
	end)()

job.attributes = {
	{ id = "safe"},
	{ title = v:new().not_empty().len(10,100) },
	{ description = v:new().not_empty().len(10,2000) },
	{ type = v:new().not_empty().in_list(job.types) },
	{ length = v:new().integer() }, -- 0 or empty assumes indefinite
	{ salary_range_min = v:new().len(0,50) },
	{ salary_range_max = v:new().len(0,50) },
	{ location = v:new().len(0,200) },
	{ employer = v:new().not_empty().len(5,100) },
	{ employers_website = v:new().not_empty().len(1,255).match('^https?://[%w]+%.[%w]+.*') },
	{ skills_required = v:new().len(0,500) },
	{ skills_desired = v:new().len(0,500) },
	{ about_company  = v:new().not_empty().len(10,500) },
	{ benefits = v:new().len(0,500) },
	{ how_to_apply  = v:new().not_empty().len(10,500) },
	{ email = v:new().not_empty().email() },
	{ posted_date = v:new().not_empty() },
	{ allow_remote = v:new().boolean() },
	{ visa_sponsoring  = v:new().boolean() },
	{ relocation_aid  = v:new().boolean() },
	{ approved = v:new().boolean() }
}



job.db = {
  key = 'id', -- the primary key
  table = 'jobs' -- make sure this field contains the same name as your SQL table!
}

return job
