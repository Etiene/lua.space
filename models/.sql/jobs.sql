--MySQL
drop table if exists jobs;
create table jobs(
	id int primary key auto_increment,
	title varchar(100),
	description text,
	type varchar(50), 
	length int,
	salary_range_min varchar(50),  
	salary_range_max varchar(50), 
	location varchar(200), 
	employer varchar(100), 
	employers_website  varchar(255), 
	skills_required text,
	skills_desired text,
	about_company text,
	benefits text,
	how_to_apply text,
	email  varchar(255), 
	posted_date datetime, 
	allow_remote tinyint(1),
	visa_sponsoring tinyint(1),
	relocation_aid tinyint(1),
	approved tinyint(1)
);
