-- ***SQL Masterclass: Day 1 Challenge:
-- SELECT * FROM Customer

-- 1. Create a list of distinct districts customers
-- SELECT DISTINCT * FROM customer

-- 2. Waht is the latest rental date
-- SELECT MAX(rental_date) FROM rental
-- SELECT rental_date
-- FROM rental
-- ORDER BY rental_date DESC
-- LIMIT 1

-- 3. How many films does the company have
-- SELECT COUNT(DISTINCT(title)) FROM film

-- 4.How many distinct last names of customers
-- SELECT DISTINCT(last_name) FROM Customer


-- ***SQL Masterclass: Day 2
-- How many rentlas not returned
-- SELECT COUNT(*) FROM rental WHERE return_date is null

-- List of payment ids with amount less than $2
-- SELECT payment_id, amount FROM payment WHERE amount =<2

-- SELECT *
-- FROM payment
-- WHERE customer_id = 30
-- OR customer_id = 31 AND amount <2
-- ORDER BY customer_id

-- How many payments betwen Jan 26/27 2000 with amounts between 2-4
-- SELECT *
-- FROM payment
-- WHERE amount BETWEEN 1.99 AND 3.99
-- AND payment_date BETWEEN '2007-02-16' AND '2007-02-17 23:59'
-- ORDER BY payment_date

/*
SELECT *
FROM customer
WHERE first_name LIKE '___'
*/

-- ***SQL Masterclass: Day 2 Challenge:
/*
1. How many movies are there that have 'saga' in the description and title starts with 'A' or ends with 'R' +++
use alias 'no_of_movies'
2. create list of customers where first name contains 'ER' and second letter is 'A', order by last name desc
3. How many payments where amount is 0 or betwen 4-8, and on ___ date
*/ 

-- 1.
-- SELECT COUNT(*) as no_of_movies
-- FROM film
-- WHERE description ILIKE '%saga%'
-- 	AND (title ILIKE 'A%' OR title ILIKE '%R')
-- 2. 
-- SELECT *
-- FROM customer
-- WHERE first_name ILIKE '%ER%'
-- AND first_name LIKE '_a%'
-- ORDER BY last_name DESC
-- 3. 
-- SELECT *
-- FROM payment
-- WHERE (amount = 0 OR amount BETWEEN 4 AND 8)
-- AND payment_date BETWEEN '2007-05-14' AND '2007-05-15'
-- ORDER BY amount

-- ***SQL Masterclass: Day 3: Grouping
-- SELECT
-- staff_id,
-- COUNT(*) as count_payments,
-- SUM(amount) as sum_payments
-- FROM payment
-- WHERE amount != 0
-- GROUP BY staff_id

-- Which staff had the most sales in a day and highest gross amount (excluding 0s)
-- SELECT
-- staff_id,
-- DATE(payment_date),
-- SUM(amount),
-- COUNT(*)
-- FROM payment
-- WHERE amount != 0
-- GROUP BY staff_id, DATE(payment_date)
-- -- HAVING Count(*) >300
-- ORDER BY sum(amount) DESC

-- SELECT
-- 	ROUND(AVG(amount),2) as Avg_amt,
-- 	SUM(amount),
-- 	COUNT(amount)
-- FROM payment
-- WHERE payment_date BETWEEN '2007-04-28' AND '2007-04-30 23:59'
-- GROUP BY customer_id, DATE(payment_date)
-- HAVING COUNT(amount) > 1
-- ORDER BY Avg_amt DESC


-- ***SQL Masterclass: Day 3 Challenge:

-- ***SQL Masterclass: Day 4: Intermediate String Functions

-- Yawn:  Upper, lower, length, left, right, concatenate (||)
-- Position ( _ IN col_name)
-- Substring(string FROM start [for length])
-- i.e. get last name, first name from email assuming consistent structure
-- SELECT
-- email,
-- SUBSTRING(email FROM POSITION('.' IN email)+1 FOR (POSITION('@' IN email)-POSITION('.' IN email))-1) AS last_name
-- FROM customer

--Challenge: Create anonymized version of email where initials are visible and rest is '***'.  
-- pt2: last letter of first stanza then first initial of last stanza
-- pt1.
-- SELECT
-- email,
-- UPPER(LEFT(email, 1))
-- 	|| '***'
-- 	|| UPPER(SUBSTRING(email FROM POSITION('.' in email) for 2))
-- 	|| '***'
-- 	|| SUBSTRING(email FROM POSITION('@' in email))
-- FROM customer

-- pt2.
-- SELECT
-- email,
-- '***'
-- -- 	|| UPPER(RIGHT(LEFT(email, POSITION('.' IN email)),2))
-- 	|| UPPER(SUBSTRING(email FROM POSITION('.' IN email)-1 FOR 3))
-- 	|| '***'
-- 	|| SUBSTRING(email from POSITION('@' IN email))
-- FROM customer

-- Qs: (1) month with payment amount, day of week with highest payment amount, most a customer has spent in a week
-- 1.
-- SELECT
-- EXTRACT(month from payment_date) AS month,
-- SUM(amount) AS total_payment_amount
-- FROM payment
-- GROUP BY month
-- ORDER BY total_payment_amount DESC

-- 2. 
-- SELECT
-- EXTRACT(DOW from payment_date) AS dow,
-- SUM(amount) AS total_payment_amount
-- FROM payment
-- GROUP BY dow
-- ORDER BY total_payment_amount DESC

-- 3.
-- SELECT
-- customer_id,
-- EXTRACT(WEEK from payment_date) as week,
-- SUM(amount) as total_payment_amount
-- FROM payment
-- GROUP BY week, customer_id
-- ORDER BY total_payment_amount DESC

-- Q: (1) Rental duration for customer_id: 35 (2) which customer has the longest avg rental duration
-- 1.
-- SELECT
-- *,
-- (return_date - rental_date) AS rental_duration
-- FROM rental
-- WHERE customer_id = 35

-- 2.
-- SELECT
-- customer_id,
-- Avg(return_date - rental_date) AS avg_rental_duration
-- FROM rental
-- GROUP BY customer_id
-- ORDER BY avg_rental_duration DESC

-- ***SQL Masterclass: Day 5: Conditional Expressions
-- Q: Replacement rate = rental cost / replacement cost, highlight those <4%
-- SELECT
-- film_id,
-- title,
-- round(100*rental_rate/replacement_cost,2) AS rep_rate
-- FROM film
-- WHERE round(100*rental_rate/replacement_cost,2) <4
-- ORDER BY rep_rate

-- Tierlist for movies
-- SELECT
-- COUNT(*),
-- CASE
-- WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Tier 1'
-- WHEN description ILIKE '%drama%' AND length > 90 THEN 'Tier 2'
-- WHEN description ILIKE '%drama%' THEN 'Tier 3'
-- WHEN rental_rate < 1 THEN 'Tier 4'
-- ELSE 'No Tier'
-- END AS Tiers
-- FROM film
-- GROUP BY Tiers
-- ORDER BY Tiers

-- SELECT
-- rating,
-- COUNT(*)
-- FROM film
-- GROUP BY rating
-- ORDER BY rating

-- SELECT
-- SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS "G",
-- SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS "PG",
-- SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS "PG-13",
-- SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS "R",
-- SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS "NC-17"
-- FROM film

-- *** SQL Masterclass: Day 6: Joins
SELECT
first_name,last_name,phone,district
FROM address a
LEFT JOIN customer c
ON a.address_id = c.address_id
WHERE district = 'Texas';

-- *** Q: Get fname, lname, email, country = Brazil
SELECT first_name,last_name,email, country
FROM customer c
LEFT JOIN address a
	ON c.address_id = a.address_id
LEFT JOIN city
	ON a.city_id = city.city_id
LEFT JOIN country
	ON city.country_id = country.country_id;
	
	

-- *** Day 7: SQL: Unions & subqueries
-- example: union
SELECT first_name, 'actor' AS origin FROM actor
UNION ALL
SELECT first_name, 'customer' FROM customer
UNION
SELECT UPPER(first_name) AS first_name, 'Staff' FROM staff
ORDER BY 2;

-- example: subqueries
SELECT *
FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer 
					  WHERE last_name LIKE 'A%');

-- Select films where length is greater than average
SELECT *
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Return all films that are in inventory for store 2 more than 3 times; RETURN film_id, count of inventory and title

SELECT *
FROM film
WHERE film_id IN
(SELECT film_id
FROM inventory
WHERE store_id = 2
GROUP BY film_id
HAVING count(film_id) > 3);

-- Q: Subqueries in WHERE: return customer name and email iff spend > $30
SELECT first_name, email
FROM customer
WHERE customer_id IN 
	(SELECT customer_id
	 FROM payment
	 GROUP BY customer_id
	 HAVING SUM(amount) > 30);

-- Q: Subqueries in WHERE: return customer fname, lname iff California && spend > $100
SELECT first_name,last_name
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE district = 'California'
	)
	AND
	customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 100
	);

SELECT first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM customer c
	LEFT JOIN address a
	ON c.address_id = a.address_id
	WHERE district = 'California'
	)
	AND
	customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 100
	);




-- Q: Waht is the avg daily spend
SELECT AVG(daily_amt)
FROM
(SELECT SUM(amount) as daily_amt, DATE(payment_date) AS day
FROM payment
GROUP BY day) as subquery;

-- Correlated Subquery in WHERE
-- Ex.  Show payments that only have the highest payment per customer
SELECT *
FROM payment p1
WHERE amount = (SELECT MAX(amount) FROM payment p2 WHERE p1.customer_id = p2.customer_id)
ORDER BY customer_id;

-- Q: Show movies with highest length in their category, including rating also
-- Problem:  How to get 1 entry for each rating when multiple movies tite for length
SELECT film_id, title, length, rating
FROM film f1
WHERE length = (SELECT MAX(length) FROM film f2 WHERE f1.rating = f2.rating);

-- Correlated subquery in SELECT
-- Q: Show all payments plus the count and total amount per customer

SELECT *,
(SELECT COUNT(customer_id) FROM payment p2 WHERE p1.customer_id=p2.customer_id) as count,
(SELECT SUM(amount) FROM payment p3 WHERE p1.customer_id=p3.customer_id) as sum
FROM payment p1
ORDER BY count;

-- ***Day 7: Challenges:
-- 1. Show only films with highest replacement cost in their category + avg replacement_cost
SELECT film_id, title, replacement_cost, rating,
ROUND((SELECT AVG(replacement_cost) FROM film f3 WHERE f1.rating=f3.rating),2) as Avg_replacement_cost
FROM film f1
WHERE replacement_cost = (SELECT MAX(replacement_cost) FROM film f2 WHERE f1.rating = f2.rating)
ORDER BY rating;


-- 2. Show highest payment, including payment_id, for each customer (using joins show first name)
SELECT first_name, amount, payment_id
FROM payment p1
INNER JOIN customer c
	ON c.customer_id = p1.customer_id
WHERE amount = (SELECT MAX(amount) FROM payment p2 
				WHERE p1.customer_id = p2.customer_id);
	
-- SELECT * FROM payment

-- 2. Bonus: how ot solve if didn't need payment_id
SELECT first_name, MAX(amount)
FROM payment p1
INNER JOIN customer c
	ON c.customer_id = p1.customer_id
GROUP BY c.customer_id;


-- *** DAY 8: SQL: PROJECT/Portfolio problems  (goal: 10/14)
/*
Question 1:
Level: Simple
Topic: DISTINCT
Task: Create a list of all the different (distinct) replacement costs of the films.
Question: What's the lowest replacement cost?
Answer: 9.99
*/
SELECT DISTINCT replacement_cost
FROM film
ORDER BY replacement_cost ASC
LIMIT 1;

/*
Question 2:
Level: Moderate
Topic: CASE + GROUP BY
Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges
low: 9.99 - 19.99
medium: 20.00 - 24.99
high: 25.00 - 29.99
Question: How many films have a replacement cost in the "low" group?
Answer: 514
*/
SELECT COUNT(*),
(CASE
WHEN replacement_cost >= 9.99 AND replacement_cost <=19.99 THEN 'low'
WHEN replacement_cost >=20 AND replacement_cost <=24.99 THEN 'medium'
WHEN replacement_cost >=25 AND replacement_cost <=29.99 THEN 'high'
ELSE NULL
END) AS category
FROM film
GROUP BY category;


/*
Question 3:
Level: Moderate
Topic: JOIN
Task: Create a list of the film titles including their title, length, and category name ordered descendingly by length. 
Filter the results to only the movies in the category 'Drama' or 'Sports'.
Question: In which category is the longest film and how long is it?
Answer: Sports and 184
*/
-- SELECT title, length, 
-- FROM film

SELECT f.title,f.length,c.name
FROM film f
LEFT JOIN film_category fc
	ON f.film_id = fc.film_id
LEFT JOIN category c
	ON c.category_id=fc.category_id
WHERE name IN ('Drama','Sports')
ORDER BY length DESC;

-- SELECT * FROM category
/*
Question 4:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of how many movies (titles) there are in each category (name).
Question: Which category (name) is the most common among the films?
Answer: Sports with 74 titles
*/
SELECT COUNT(*),c.name
FROM film f
LEFT JOIN film_category fc
	ON f.film_id=fc.film_id
LEFT JOIN category c
	ON fc.category_id=c.category_id
GROUP BY c.name
ORDER BY count DESC;




/*
Question 5:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of the actors' first and last names and in how many movies they appear in.
Question: Which actor is part of most movies??
Answer: Susan Davis with 54 movies
*/
SELECT COUNT(*), a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa
	ON a.actor_id=fa.actor_id
GROUP BY a.actor_id
ORDER BY count DESC;
-- Note: Answer is different.  Confident in the structure of my answer; updates have been made to dataset


/*
Question 6:
Level: Moderate
Topic: LEFT JOIN & FILTERING
Task: Create an overview of the addresses that are not associated to any customer.
Question: How many addresses are that?
Answer: 4
*/
SELECT a.address_id, a.address, a.district
FROM address a
LEFT JOIN customer c
	ON a.address_id=c.address_id
WHERE c.address_id IS NULL;

/*
Question 7:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of the cities and how much sales (sum of amount) have occurred there.
Question: Which city has the most sales?
Answer: Cape Coral with a total amount of 221.55
*/
SELECT ci.city,SUM(amount)
FROM city ci
LEFT JOIN address a
	ON ci.city_id = a.city_id
LEFT JOIN customer cu
	ON cu.address_id = a.address_id
LEFT JOIN payment p
	ON p.customer_id = cu.customer_id
GROUP BY ci.city
ORDER BY sum DESC;

-- table map:: payment: amount and customer_id  > customer: customer_id, address_id > address: address_id, city_id > city: city, city_id

/*
Question 8:
Level: Moderate to difficult
Topic: JOIN & GROUP BY
Task: Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city".
Question: Which country, city has the least sales?
Answer: United States, Tallahassee with a total amount of 50.85.
*/

SELECT (co.country || ', ' || ci.city) as "country, city", SUM(amount) AS sum
FROM city ci
FULL JOIN country co
	ON ci.country_id=co.country_id
LEFT JOIN address a
	ON ci.city_id = a.city_id
LEFT JOIN customer cu
	ON cu.address_id = a.address_id
LEFT JOIN payment p
	ON p.customer_id = cu.customer_id
-- WHERE sum IS NOT NULL
GROUP BY "country, city"
ORDER BY sum ASC;


/*
Question 9:
Level: Difficult
Topic: Uncorrelated subquery
Task: Create a list with the average of the sales amount each staff_id has per customer.
Question: Which staff_id makes on average more revenue per customer?
Answer: staff_id 2 with an average revenue of 56.64 per customer.
*/
SELECT * FROM payment;

-- First incorrect answer:  misinterpreted question as avg transaction amount by customer + staff id, which doesn't require a subquery. 
-- After reviewing solution it was clear they wanted each customers total spend by staff id, and an average taken of each customers total spend.
SELECT
staff_id,
ROUND(AVG(total),2)
FROM (
	SELECT
	staff_id, customer_id, SUM(amount) as total
	FROM payment
	GROUP BY staff_id, customer_id
	ORDER BY customer_id
	) subquery
GROUP BY staff_id
;



/*
Question 10:
Level: Difficult to very difficult
Topic: EXTRACT + Uncorrelated subquery
Task: Create a query that shows average daily revenue of all Sundays.
Question: What is the daily average revenue of all Sundays?
Answer: 1410.65
*/
-- Extract DOW, Sunday = 0.

SELECT ROUND(AVG(revenue),2)
FROM (
	SELECT sum(amount) as revenue, DATE(payment_date) as date
	FROM payment
	WHERE EXTRACT(DOW from payment_date) = 0
	GROUP BY DATE(payment_date)
	) subquery
	;


/*
Question 11:
Level: Difficult to very difficult
Topic: Correlated subquery
Task: Create a list of movies - with their length and their replacement cost - 
		that are longer than the average length in each replacement cost group.
Question: Which two movies are the shortest on that list and how long are they?
Answer: CELEBRITY HORN and SEATTLE EXPECTATIONS with 110 minutes.
*/
SELECT * FROM film;

SELECT title, length, replacement_cost
FROM film f1
WHERE length > (SELECT AVG(length) FROM film f2 WHERE f1.replacement_cost=f2.replacement_cost)
ORDER BY length;



/*
Question 12:
Level: Very difficult
Topic: Uncorrelated subquery
Task: Create a list that shows the "average customer lifetime value" grouped by the different districts.
Example:
If there are two customers in "District 1" where one customer has a total (lifetime) spent of $1000 
	and the second customer has a total spent of $2000 
	then the "average customer lifetime spent" in this district is $1500.
So, first, you need to calculate the total per customer and then the average of these totals per district.
Question: Which district has the highest average customer lifetime value?
Answer: Saint-Denis with an average customer lifetime value of 216.54.
*/
SELECT * FROM address;
-- join map:: payment: customer_id > customer: address_id > address: district
-- no possibility of customer being in 2 districts

SELECT district, ROUND(AVG(customer_lifetime_value),2) as avg_customer_lifetime_spend
FROM
	(
	SELECT p.customer_id, a.district,SUM(amount) as customer_lifetime_value
	FROM payment p 
	LEFT JOIN customer c ON c.customer_id=p.customer_id
	LEFT JOIN address a ON a.address_id=c.address_id
	GROUP BY p.customer_id, a.district
	) as sub1
GROUP BY district
ORDER BY avg_customer_lifetime_spend DESC
;



/*
Question 13:
Level: Very difficult
Topic: Correlated query
Task: Create a list that shows all payments including the payment_id, amount, and the film category (name) 
	plus the total amount that was made in this category. Order the results ascendingly by the category (name) 
	and as second order criterion by the payment_id ascendingly.
Question: What is the total revenue of the category 'Action' 
	and what is the lowest payment_id in that category 'Action'?
Answer: Total revenue in the category 'Action' is 4375.85 and the lowest payment_id in that category is 16055.
*/
-- map:: payment (rental_id) > rental (inventory_id) > inventory (film_id) > film_cat (category_id) > category (name)
SELECT title, payment_id, amount, c.name,
(SELECT SUM(amount) FROM payment p
					LEFT JOIN rental r ON r.rental_id = p.rental_id
					LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
					LEFT JOIN film f ON f.film_id = i.film_id
					LEFT JOIN film_category fc ON fc.film_id = f.film_id
					LEFT JOIN category c1 ON c1.category_id = fc.category_id
					WHERE c1.name=c.name)

FROM payment p
LEFT JOIN rental r ON r.rental_id = p.rental_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film f ON f.film_id = i.film_id
LEFT JOIN film_category fc ON fc.film_id = f.film_id
LEFT JOIN category c ON c.category_id = fc.category_id
ORDER BY name
;

--  Later optimizated by partitions  (90msec vs 25sec!!)
SELECT c.name, p.payment_id, p.amount, SUM(p.amount) OVER(PARTITION BY c.name) AS category_total
FROM payment p
LEFT JOIN rental r ON r.rental_id = p.rental_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film f ON f.film_id = i.film_id
LEFT JOIN film_category fc ON fc.film_id = f.film_id
LEFT JOIN category c ON c.category_id = fc.category_id
ORDER BY c.name, p.payment_id;



/*
Bonus question 14:
Level: Extremely difficult
Topic: Correlated and uncorrelated subqueries (nested)
Task: Create a list with the top overall revenue of a film title (sum of amount per title) for each category (name).
Question: Which is the top-performing film in the animation category?
Answer: DOGMA FAMILY with 178.70.
*/
SELECT title,name,SUM(amount) as total
FROM payment p
LEFT JOIN rental r ON r.rental_id=p.rental_id
LEFT JOIN inventory i ON i.inventory_id=r.inventory_id
LEFT JOIN film f ON f.film_id=i.film_id
LEFT JOIN film_category fc ON fc.film_id=f.film_id
LEFT JOIN category c ON c.category_id=fc.category_id
GROUP BY name,title
HAVING SUM(amount) =
	(SELECT MAX(total)
	FROM (
			SELECT title,name,SUM(amount) as total
			FROM payment p
			LEFT JOIN rental r ON r.rental_id=p.rental_id
			LEFT JOIN inventory i ON i.inventory_id=r.inventory_id
			LEFT JOIN film f ON f.film_id=i.film_id
			LEFT JOIN film_category fc ON fc.film_id=f.film_id
			LEFT JOIN category c ON c.category_id=fc.category_id
			GROUP BY name,title
		) as sub
	 WHERE c.name=sub.name)
ORDER BY total DESC
;

-- Score (13/14): Incorrect answers: #9 (misinterpreted question)


-- *** Day 9:  Managing Tables and Databases
SELECT COUNT(*) FROM film WHERE 'Behind the Scenes' = ANY(special_features);
;


-- *** Day 10: Window Functions
-- Often an upgrade on correlated subqueries:
-- Helpful for returning additional columns based on conditions. 
-- i.e. what is the average for this location
-- Over, Partition

-- Example
SELECT *,
COUNT(*) OVER(PARTITION BY customer_id,staff_id)
FROM payment
ORDER BY 1;
-- Round goes around entire partition
SELECT *,
ROUND(AVG(amount) OVER(PARTITION BY customer_id,staff_id),2)
FROM payment
ORDER BY 1;

-- Challenge1: return list of movies inc. film_id, title, length, category, avg length for category, order by film_id
SELECT f.film_id,f.title,f.length,c.name as category,
ROUND(AVG(length) OVER(PARTITION BY c.name),2)
FROM film f
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON c.category_id=fc.category_id
ORDER BY film_id;

-- Challenge2: return payment details incl # payments at same amount
SELECT *,
COUNT(*) OVER(PARTITION BY customer_id, amount)
FROM payment
ORDER BY customer_id,amount;


-- *** DAY 11: Window Functions
-- Write a query that returns customer name, # payments, and country
-- Then add ranking for each customer by country
-- dataset in previously computed view

SELECT * FROM (
	SELECT
	name,
	country,
	COUNT(*),
	RANK() OVER(PARTITION BY country ORDER BY COUNT(*) DESC) as rank
	FROM customer_list
	LEFT JOIN payment ON id=customer_id
	GROUP BY name, country) sub
WHERE rank BETWEEN 1 AND 3;

SELECT * FROM customer_list;

-- Challenge: Lead/Lag: Write a query that shows rev by day & previous day, calculate diff & % growth
SELECT * FROM payment;

SELECT
SUM(amount),
DATE(payment_date) as date,
LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) AS prev_day_amnt,
SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) AS diff,
ROUND((SUM(amount) / LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)))-1,2) AS growth
FROM payment
GROUP BY date;

-- Day 12: Grouping Sets, Rollups, & Self-joins
SELECT
TO_CHAR(payment_date,'Month') AS month,
staff_id,
SUM(amount)
FROM payment
GROUP BY
	GROUPING SETS (
	(month),
	(staff_id),
	(month,staff_id)
	)
ORDER BY 1,2;

-- Challenge: Return sumary of customer spend by staff_id && total per customer
-- Challenge 2: Add another column to calcualte percentage of total spend
-- My issue:  Not sure how to write it.  Getting error that amount must be in group by or agg
SELECT
customer_id,
staff_id,
SUM(amount) as total,
ROUND(SUM(amount) / (FIRST_VALUE(SUM(amount)) OVER(PARTITION BY customer_id
							 ORDER BY SUM(amount) DESC)),2) AS percentage
FROM payment
GROUP BY
	GROUPING SETS (
	(customer_id),
	(staff_id,customer_id)
	)
ORDER BY 1,2,3;


-- Cube & Rollup
-- subclauses within groupby
-- rollup useful for natural heirarchies, like dates. 
-- Cube for when there is no natural heirarchy: show agg by all possible combinations
SELECT
'Q'||TO_CHAR(payment_date,'Q') as quarter,
EXTRACT(month from payment_date) as month,
DATE(payment_date),
SUM(amount) as total
FROM payment
GROUP BY ROLLUP(
	'Q'||TO_CHAR(payment_date,'Q'),
	EXTRACT(month from payment_date),
	DATE(payment_date)
	)

-- Challenge:  Write a query to summarize sales by q, m, w, date
SELECT
'Q'||TO_CHAR(payment_date,'Q') as quarter,
EXTRACT(month from payment_date) as month,
TO_CHAR(payment_date,'w') as week_in_month,
DATE(payment_date),
SUM(amount) as total
FROM payment
GROUP BY ROLLUP(
	'Q'||TO_CHAR(payment_date,'Q'),
	EXTRACT(month from payment_date),
	TO_CHAR(payment_date,'w'),
	DATE(payment_date)
	);

-- Cube:
SELECT
customer_id,
staff_id,
DATE(payment_date),
SUM(amount)
FROM payment
GROUP BY CUBE(
	customer_id,
	staff_id,
	DATE(payment_date)
)
ORDER BY 1,2,3

-- Challenge: Write a query that returns all grouping sets in all combinations of 
-- customer_id, date and title with the aggregation of the payment amount.
SELECT 
p.customer_id,
DATE(payment_date),
title,
SUM(amount) as total
FROM payment p
LEFT JOIN rental r ON r.rental_id=p.rental_id
LEFT JOIN inventory i ON i.inventory_id=r.inventory_id
LEFT JOIN film f ON f.film_id=i.film_id
GROUP BY CUBE(
	p.customer_id,
	DATE(payment_date),
	title
	)
ORDER BY 1,2,3

-- Self-Join
-- standard join with itself: i.e. when reporting managers of an employee where managers are already in employee table

-- Create table
CREATE TABLE employee (
	employee_id INT,
	name VARCHAR (50),
	manager_id INT
);

INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);

-- Example
SELECT
emp.employee_id,
emp.name as name,
mgt.name as manager,
mgt2.name as managers_manager
FROM employee emp
LEFT JOIN employee mgt ON emp.manager_id = mgt.employee_id
LEFT JOIN employee mgt2 ON mgt.manager_id = mgt2.employee_id


-- Cross Join
-- All combinations of rows between two tables (incl duplicates)
-- Ex
SELECT
t1.col1,
t2.col1
FROM table1 t1
CROSS JOIN table2 t2

-- Natural Join
-- Join iff there exists 1 and only 1 id shared between two tables