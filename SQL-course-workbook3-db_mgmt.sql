/*
*** Day 9:  Managing tables and databases. 

*/
CREATE DATABASE company_x
	WITH ENCODING 'UTF-8';
	
COMMENT ON DATABASE company_x IS 'This is our DB';

-- Example
CREATE TABLE sample (
sample_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
city VARCHAR(50) DEFAULT 'Toronto',
date_of_birth DATE,
address_id INT REFERENCES address(address_id), /*[address references other tbale in database]*/
UNIQUE(sample_id,last_name)
);


-- Assignment 1:
CREATE TABLE online_sales (
	transaction_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customer(customer_id),
	film_id INT REFERENCES film(film_id),
	amount NUMERIC(5,2) NOT NULL,
	promotion_code VARCHAR(10) DEFAULT 'None'
);

-- Example: Insert
INSERT INTO online_sales
(customer_id, film_id,amount)
VALUES (269,13,10.99);

SELECT * FROM online_sales

-- Assignment 2:
INSERT INTO online_sales
(customer_id,film_id,amount,promotion_code)
VALUES 
(124,65,14.99,'PROMO2022'),
(225,231,12.99,'JULYPROMO'),
(119,53,15.99,'SUMMERDEAL')


-- Example: Alter table, drop:  Note: rename is only action that cannot be combined with others.
-- ALTER TABLE staff
-- DROP COLUMN IF EXISTS col1,
-- ADD COLUMN IF NOT EXISTS col2,
-- ALTER COLUMN col1 TYPE smallint,
-- RENAME COLUMN col1 TO col3,
-- ALTER COLUMN col1 SET DEFAULT 'haha',
-- ADD CONSTRAINT (constraint name)
-- Etc

-- Also
-- DROP TABLE
-- DROP SCHEMA
-- TRUNCATE TABLE <tablename>: deletes all entries in table

-- Also
-- CHECK ( col1 > col2; col1 > x; etc)

-- Challenge:
CREATE TABLE songs (
	song_id SERIAL PRIMARY KEY,
	song_name VARCHAR(30) NOT NULL,
	genre VARCHAR(30) DEFAULT 'Not defined',
	price numeric(4,2) CHECK(price >=1.99),
	release_date DATE CONSTRAINT date_check CHECK(release_date BETWEEN '01-01-1950' AND CURRENT_DATE)
)

SELECT * FROM songs

INSERT INTO songs (song_name, price, release_date)
VALUES ('SQL SONG', 8.99, '01-07-2222')

-- Note date outside constraint

ALTER TABLE songs
DROP CONSTRAINT song_date_check