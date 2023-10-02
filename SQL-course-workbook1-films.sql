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

--Challenge: Create anonymized version of email where initials are visible and rest is '***'.  pt2: last letter of first stanza then first initial of last stanza
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
	
	


-- Question 3:
-- Which title has GEORGE LINTON rented the most often?
-- Answer: CADDYSHACK JEDI - 3 times.