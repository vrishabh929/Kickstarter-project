-- Data Exploration

select 
	*
from 
	[Maven data analytics].[dbo].[kickstarter_projects]

-- Category

select 
	category,
	count(state) as success_count,
	round(cast(count(state) as float)/cast((select count(*) from [Maven data analytics].[dbo].[kickstarter_projects] where state = 'Successful') as float )* 100,2) as [success_percentage(%)],
	sum(goal) as goal,
	sum(pledged) as pledged_amount
from 
	[Maven data analytics].[dbo].[kickstarter_projects]
where
	state = 'Successful'
group by 
	category
order by 
	2 desc

--subcategory

select top (15)
	subcategory,
	count(state) as success_count,
	round(cast(count(state) as float)/cast((select count(*) from [Maven data analytics].[dbo].[kickstarter_projects] where state = 'Successful') as float )* 100,2) as [success_percentage(%)],
	sum(goal) as goal,
	sum(pledged) as pledged_amount
from 
	[Maven data analytics].[dbo].[kickstarter_projects]
where
	state = 'Successful'
group by 
	subcategory
order by 
	2 desc




--Success Count

select top (5)
	country,
	count(state) as success_count,
	round(cast(count(state) as float)/cast((select count(*) from [Maven data analytics].[dbo].[kickstarter_projects] where state='Successful') as float)* 100,2) as [success_rate(%)],
	sum(goal) as goal
from 
	[Maven data analytics].[dbo].[kickstarter_projects]
where
	state like 'Successful'
group by 
	country
order by 
	2 desc


--Goal Percentage


select top (5)
	name,
	goal,
	category,
	cast(round((pledged / goal)*100,0)as int) as [goal_completion_rate(%)],
	pledged
from 
	[Maven data analytics].[dbo].[kickstarter_projects]
where
	state like 'Successful'
	and goal > 1000
order by 
	4 desc

-- year wise success and failed

select t1.year_launched, t1.success_count, t2.failed_count
from
(
select
	distinct(year(launched)) as year_launched,
	count(state) as success_count
from 
	[Maven data analytics].[dbo].[kickstarter_projects]
where 
	state = 'Successful'
group by 
	year(launched)
) as t1 ,

(
select
	distinct(year(launched)) as year_launched,
	count(state) as failed_count
from 
	[Maven data analytics].[dbo].[kickstarter_projects]
where 
	state = 'Failed'
group by 
	year(launched)
) as t2

where 
	t1.year_launched = t2.year_launched
order by 
	1

-- state

select 
	state,
	count(state),
	round(cast(count(state) as float)/cast((select count(*) from [Maven data analytics].[dbo].[kickstarter_projects]) as float )* 100,2) as [percentage(%)]

from 
	[Maven data analytics].[dbo].[kickstarter_projects]
group by 
	state
order by 
	3 desc


-- Goal, pledged


select 
	count(*) as number_of_projects,
	(select count(*) from [Maven data analytics].[dbo].[kickstarter_projects] where state = 'Successful') as [No. of Successful project],
	sum(goal) as Total_goal,
	sum(pledged) as pleadged_amount
from 
	[Maven data analytics].[dbo].[kickstarter_projects]




