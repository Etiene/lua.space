<style>
	.table td {
	    cursor: pointer;
	}
	a {
		text-decoration: none !important;
	}
</style>
<h1>Lua Job Offers</h1>
	<?lua 

	local date = require "date"
	for _,v in ipairs(jobs) do 
		if v.approved then
			local salary_range 
			salary_range_min = v.salary_range_min
			if not v.salary_range_min and not v.salary_range_max then
				salary_range = ' '
			elseif v.salary_range_min and not v.salary_range_max then
				salary_range = v.salary_range_min..' or more '
			elseif not v.salary_range_min and v.salary_range_max then
				salary_range = 'Up to '..v.salary_range_max
			else
				salary_range = v.salary_range_min..' - '..v.salary_range_max
			end

			local location = v.location or ''

			local remote = v.allow_remote and '<i class="fa fa-wifi"></i> Remote allowed' or ''
			local visa = v.visa_sponsoring and '<i class="fa fa-newspaper-o" style="margin-left: 8px;"></i> Visa sponsor' or ''
			local reloc = v.relocation_aid and '<i class="fa fa-suitcase" style="margin-left: 8px;"></i> Relocation aid' or ''

		?>
		<hr/>
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-10">
						<h3>
							<a href="<%= page:make_url('job/view',{id = v.id}) %>"> 
								<%= v.title %> <small> ( <%= v.type %> )  </small> 
							</a>
						</h3>
					</div>
					<div class="col-md-2">
						<h3><small><p class="text-success text-right"> <%= salary_range %> </p></small></h3>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<a href="<%= v.employers_website %>" target="_blank"><%= v.employer %></a> 
					</div>
					<div class="col-md-4">
						<p class="text-right"><%= location %></p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						Posted on <%= date(v.posted_date ):fmt("%b %d %Y") %>
					</div>
					<div class="col-md-6 pull-right text-right">
						<%= remote %>
						<%= reloc %>
						<%= visa %>
					</div>
				</div>
			</div>
	<?lua end 
	end ?>
<hr/>
<br/>
<a href="<%= page:make_url('jobs/add') %>" class="btn btn-primary">Add a job offer to the listing!</a>
<br/>
