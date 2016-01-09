local M = {}
local Job = require "sailor.model"("job")

function M.index(page)
	local jobs = Job:find_all()
	page:render('index',{jobs = jobs})
end

function M.add(page)
	local job = Job:new()
	local saved
	if next(page.POST) then
		job:get_post(page.POST)
		saved = job:save()
		if saved then
			page:redirect('job/index')
		end
	end
	page:render('add',{job = job, saved = saved})
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
	if not job then
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

end

return M
