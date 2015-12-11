--
--	1 Rule = More Recent posts on the top!
--  To unpublish, comment the entry
--  Warning, posts with the category and short_url will clash
--  Congratulations on your article and thanks for your contribution!
--

local authors = { 
	 -- Copy paste this entry and modify it to add yourself
	 -- You can leave all fields nil except name
	etiene = {
		name = 'Etiene Dalcol',
		picture = 'https://scontent-cdg2-1.xx.fbcdn.net/hphotos-xaf1/v/t1.0-9/10302647_10205896098953415_7657524150962637562_n.jpg?oh=350d15cd44b05f205949c2105e41ece6&oe=56E10C30', 
		description = 'Etiene is a Software Engineering student from Brazil currently living in France. She is also the Lead developer of Sailor and founder of LuaLadies.',
		website = 'http://etiene.net',
		twitter = 'http://twitter.com/etiene_d',
		github = 'http://github.com/Etiene',
		linkedin = nil,
		facebook = nil,
	}
}

return {
	{
	
		page_title = 'Blog opening and contribution guide!', -- Post and page title
		short_url = 'blog-opening-and-contribution-guide', -- Short url and same as md file name
		category = 'general', -- folder of where it's in
		date = 'Dec 11 2015 13:31', -- Just for printing, ordering is done by this table order
		reblogged_from = nil, -- [string] URL if this was posted somewhere else first
		author = authors.etiene
	}
}