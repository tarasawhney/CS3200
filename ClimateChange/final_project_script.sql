USE `climatechange`;

-- 1. Rainforest vs jaguar 

-- gets the forest percentage of Brazil and Population information of jaguar
select distinct country_name, cs.year, forest_percentage, animal_name, ap.population
from animal_population ap join animal a using (animal_id)
join country_stats cs using (country_id)
join country c using (country_id)
where cs.year = ap.year and a.animal_name like '%jaguar%' and c.country_name like '%Brazil%' and cs.forest_percentage != 0
order by cs.year;

-- 2. CO2 vs Human Population

-- collect carbon dioxide emissions information to compare against population information
select country_name, year, co2_emission, population
from country_stats join country using (country_id)
where (country_name like "China" or country_name like "%United States%" or country_name like "%India%") and co2_emission != ""
order by year, country_name;

-- query we wanted to do but no forest_percentage data to use to create bubble graph :(
select country_name, year, co2_emission, population, forest_percentage
from country_stats join country using (country_id)
where year = 2019 and country_name like "China" or country_name like "%United States%" or country_name like "%India%"
order by year, country_name;
 
 -- 3. Forest/vegetation vs elephant

-- comparison of forest_percentage and population of elephant
select c.country_name, cs.year, cs.forest_percentage, a.animal_name, ap.population
from animal_population ap join animal a using (animal_id)
left join country c using (country_id)
left join country_stats cs using (country_id)
where a.animal_name like '%elephant%' and c.country_name like '%Botswana%' and forest_percentage != ""
and (cs.year = ap.year);

-- elephant population data
 select * 
 from animal_population ap join animal a using (animal_id) 
 where a.animal_name like '%elephant%' ;

-- 4. CO2 emissions vs number of laws

-- collects the carbon emissions data and the laws per country
select country_name, co2_emission, count(*) num_laws
from regulation 
right join (select *
from country_stats
left join country using (country_id)
where year = '2019'
order by co2_emission desc
limit 10) tmp using (country_id)
group by country_name
order by co2_emission desc;

