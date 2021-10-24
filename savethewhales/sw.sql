-- How much money has been collected from adoption fees?
select sum(charge_amt)
from adoption; 

-- Count how many sightings there are for male whales and for female whales.
select count(whale_id)
from sighting join whale using (whale_id)
group by gender; 

-- For each adoption, list the name of the whale, the last name of the adopting user,
-- the adoption charge amount, and the type of credit card used for the adoption.
select name, user_lastname, charge_amt, type
from adoption join whale using (whale_id)
join user using (user_id)
join creditcard using (user_id); 

-- How many total times was any adopted whale sighted?
-- Return a single number.
select count(*) 
from adoption join whale using (whale_id)
join sighting using (whale_id); 

-- The YEAR function extracts the year from a date.
-- List all users who adopted a whale in 2021. 
-- Only list each user once, even if they adopted more than one whale. 
-- List their first and last name and all address-related fields
-- Output the list in alphabetical order by last name.
-- The New England Aquarium plans to send these users an end-of-year holiday thank you!
select user_firstname, user_lastname, address, city, state, country, zipcode
from adoption join user using (user_id)
where year(dt) = 2021
group by user_id
order by user_lastname; 

-- How much did each user spend on adoption fees?
-- Include users that didn't spend anything
-- If they didn't spend anything, show "0" rather than "null"
-- Sort users from biggest spender to smallest.
-- In case of a tie, sort by the user's last name
select user_firstname, user_lastname, sum(ifnull(charge_amt, 0)) as fees
from user left join adoption using (user_id)
group by user_firstname, user_lastname
order by fees desc, user_lastname; 

-- -- Overall, ON AVERAGE, how many times was each whale sighted?
-- Factor into your average those whales that were never sighted.
-- I'm looking for a single number.
-- For example, if I had two whales and one was sighted 3 times and the other 0 times
-- that would be 1.5 sightings per whale on average.
select avg(ifnull(researchteam_id,0)) as avg_sighting
from whale left join sighting using(whale_id); 

-- The MONTHNAME function takes a date and returns the name of the month (January...December).
-- The MONTH function takes a date and returns the NUMBER of month 1, 2, ..., 12.
-- How many whales were born in each month? 
-- List the name of the month and the number of births.
--  You may ignore months that have no births, BUT, months should be listed in calendar order!
-- Filter out whales and counts for when the date of birth is unknown
-- Note this may not be scientifically accurate!
select monthname(dob), count(whale_id)
from whale 
where month(dob) != ""
group by month(dob)
order by month(dob); 

-- For each research team, list the name and affiliation of the team,
-- The principle investigator (PI) last name,
-- The number of sightings, and the number of  sightings where the
-- identity of the whale was certain.
-- Include research teams that made no sightings
-- Zero counts should show "0" not "null"
-- Assign column aliases where appropriate
-- Sort output from most total sightings to least total sightings.
select name, affiliation, pi_lastname, count(whale_id) as whale_sightings
from researchteam left join sighting using (researchteam_id)
where is_certain_ident = 1 or whale_id is null
group by researchteam_id
order by whale_sightings desc; 

-- What whales were sighted more than once?
-- List their names and the number of times they were sighted
-- order from most sighted to least sighted.
-- In cases of a tie, order alphabetically by the name of the whale
select w.name, count(w.whale_id) as num_sighted 
from whale w join sighting s using (whale_id)
group by w.name 
having num_sighted > 1
order by num_sighted desc, name; 

-- How many times was each whale adopted? 
-- Include only whales that were sighted more than once.
-- In implementing this query, do not hard-code the names of these whales. 
-- Use a subquery.
select * 
from whale; 

select* 
from adoption 
where whale in (
	select w.name, count(w.whale_id) as num_sighted
    from whale w join sighting s using (whale_id)
    group by w.name
    having num_sighted > 1
    order by num_sighted desc, name)
group by whale_id; 

-- List the name and gender of every whale along with the name and gender of that whale's mother.
-- Include whales that have no known mother.
-- Add column aliases where appropriate
select w1.name as b_name, w1.gender as b_gender, w2.name as m_name, w2.gender as m_gender
from whale w1 left join whale w2 on (w1.mother_id = w2.whale_id);

-- Which North Atlantic Right Whales should be saved? 
-- Select all the whales. Show all their attributes.
select * 
from whale; 
