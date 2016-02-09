local M = {}
local Job = require "sailor.model"("job")

function M.index(page)
	local jobs = Job:find_all('approved = 1')
	page:render('index',{jobs = jobs})
end

function M.add(page)
	local date = require "date"
	local job = Job:new()
	local saved
	if next(page.POST) then
		job:get_post(page.POST)
		job.posted_date = date():fmt("%Y-%m-%d %T")
		job.allow_remote = job.allow_remote == 'on' and true or false
		job.visa_sponsoring  = job.visa_sponsoring == 'on' and true or false
		job.relocation_aid = job.relocation_aid == 'on' and true or false
		job.approved = false
		saved = job:save()
		if saved then
			local mail = require "mail"
			mail.send_message('', "New job post waiting", "please check, this was the sender: "..job.email)
			page:redirect('jobs/waiting')
		end
	end
	page:render('add',{job = job, saved = saved})
end

function M.waiting(page)
	page:write("Your request has been registered and is now pending approval. Thank you :)")
end

function M.modify(page)
	local job = Job:find_by_id(page.GET.id)
	if not job then
		return 404
	end
	local saved
	if next(page.POST) then
		job:get_post(page.POST)
		saved = job:update()
		if saved then
			page:redirect('job/index')
		end
	end
	page:render('update',{job = job, saved = saved})
end

function M.view(page)
	local job = Job:find_by_id(page.GET.id)
	if not job or not job.approved then
		return 404
	end
	page:render('view',{job = job})
end

function M.delete(page)
	local job = Job:find_by_id(page.GET.id)
	if not job then
		return 404
	end

	if job:delete() then
		page:redirect('job/index')
	end
end

function M.admin(page)
	local pw = (require "conf.conf").admin_pass
	if not next(page.GET) or page.GET.pw ~= pw then return 404 end

	if next(page.POST) and page.POST.approve_job then
		local job_to_approve = Job:find_by_id(page.POST.approve_job)
		job_to_approve.allow_remote = job_to_approve.allow_remote and true or false
		job_to_approve.visa_sponsoring  = job_to_approve.visa_sponsoring and true or false
		job_to_approve.relocation_aid = job_to_approve.relocation_aid and true or false
		job_to_approve.approved = true
		job_to_approve:save()
	end

	local admin = true
	local jobs = Job:find_all("approved is NULL")
	page:render('index',{jobs = jobs, admin=admin})
end

return M
