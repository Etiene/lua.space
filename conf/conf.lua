local conf = {
	sailor = {
		app_name = 'Lua.Space',
		app_url = 'http://lua.space/',
		default_static = nil, -- If defined, default page will be a rendered lp as defined. 
							  -- Example: 'maintenance' will render /views/maintenance.lp
		default_controller = 'main', 
		default_action = 'index',
		theme = 'devAid',
		layout = 'index',
		route_parameter = 'r',
		default_error404 = 'error/404',
		enable_autogen = false, -- default is false, should be true only in development environment
		friendly_urls = true,
		max_upload = 1024 * 1024, 
		environment = "development",  -- this will use db configuration named development
		hide_stack_trace = false -- false recommended for development, true recommended for production
	},

	

	db = {
		development = { -- current environment
			driver = 'mysql',
			host = '',
			user = '',
			pass = '',
			dbname = ''
		}
	},

	smtp = {
		server = '',
		user = '',
		pass = '',
		from = ''
	},

	lua_at_client = {
		vm = "starlight", -- starlight is default. Other options are moonshine, lua51js and luavmjs. They need to be downloaded.
	},

	debug = {
		inspect = false
	}
}

return conf
