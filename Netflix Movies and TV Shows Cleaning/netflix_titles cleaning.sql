create database cleaning_project
use cleaning_project

-- view dataset
select * 
from netflix_titles

-- check duplicates
select show_id, 
	count(*) as count
from netflix_titles
group by show_id
having count(*)>1 --> no duplicates

-- check null values
select 
	count(case when show_id is null then 'null' end) as showid_null,
	count(case when type is null then 'null' end) as type_nulls,
	count(case when title is null then 'null' end) as title_nulls,
	count(case when director is null then 'null' end) as director_nulls,
	count(case when cast is null then 'null' end) as cast_nulls,
	count(case when country is null then 'null' end) as country_nulls,
	count(case when date_added is null then 'null' end) as date_nulls,
	count(case when release_year is null then 'null' end) as release_nulls,
	count(case when rating is null then 'null' end) as rating_nulls,
	count(case when duration is null then 'null' end) as duration_nulls,
	count(case when listed_in is null then 'null' end) as listedin_nulls,
	count(case when description is null then 'null' end) as description_nulls
from netflix_titles;
/* director_nulls : 2634
cast_nulls: 825
country_nulls: 831
date_nulls: 10
rating_nulls: 4
duration_nulls: 3 
The date_added, rating and duration rows nulls are just 17 out of 8807 rows (0.19%). 
Deleting them cannot affect the analysis */

-- Remove missing values in 'date_added', 'rating', 'duration' columns
delete from netflix_titles
where date_added is null 
	or rating is null
	or duration is null
-- Remove missing values in director, cast and country columns
delete from netflix_titles
where director is null 
	and cast is null
	and country is null


-- Handle missing values of director, cast, country columns
-- HANDLE MISSING VALUE IN director COLUMN
-- find out if there is relationship between title column and director column
-- Create CTE
with CTE as (
	select director, 
		title,
		row_number() over (partition by title order by count(*) desc) as row_num
	from netflix_titles
	where director is not null
	group by director, title)
-- Update netflix_titles with the director values from CTE
update netflix_titles
set director = (
	select director
	from CTE
	where title = netflix_titles.title and row_num=1
	)
where director is null;
-- find out if there is relationship between cast column and director column
-- Create CTE
with CTE as (
	select director, 
		cast,
		row_number() over (partition by cast order by count(*) desc) as row_num
	from netflix_titles
	where director is not null
	group by director, cast)
-- Update netflix_titles with the director values from CTE
update netflix_titles
set director = (
	select director
	from CTE
	where cast = netflix_titles.cast and row_num=1
	)
where director is null; 
--Populate the rest of the NULL in director as "Not Given"
update netflix_titles
set director = 'Not Given'
where director IS NULL

-- HANDLE MISSING VALUE IN cast COLUMN
-- find out if there is relationship between title column and cast column
-- Create CTE
with CTE as (
	select cast, 
		title,
		row_number() over (partition by title order by count(*) desc) as row_num
	from netflix_titles
	where cast is not null
	group by cast, title)
-- Update netflix_titles with the director values from CTE
update netflix_titles
set cast = (
	select cast
	from CTE
	where title = netflix_titles.title 
		and row_num=1
	)
where cast is null;
-- find out if there is relationship between director column and cast column
with CTE as (
	select director, 
		cast,
		row_number() over (partition by director order by count(*) desc) as row_num
	from netflix_titles
	where country is not null
	group by director, cast)
-- Update netflix_titles with the director values from CTE
update netflix_titles
set cast = (
	select director
	from CTE
	where director = netflix_titles.director and row_num=1
	)
where cast is null;
--Populate the rest of the NULL in cast as "Not Given"
update netflix_titles
set cast = 'Not Given'
where cast IS NULL;

-- HANDLE MISSING VALUE IN country COLUMN
-- Populate the country using the director column
with CTE as (
	select director, 
		country,
		row_number() over (partition by director order by count(*) desc) as row_num
	from netflix_titles
	where country is not null
	group by director, country)
-- Update netflix_titles with the director values from CTE
update netflix_titles
set country = (
	select director
	from CTE
	where director = netflix_titles.director and row_num=1
	)
where country is null;
-- Populate the rest of the NULL in country as "Not Given"
update netflix_titles
set country = 'Not Given'
where country IS NULL
