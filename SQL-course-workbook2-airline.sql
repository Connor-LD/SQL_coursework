-- *** SQL Masterclass: Day 6: Joins
-- airline: how many people choose seats in business, economy, comfort; using seats and boarding_passes

SELECT
*
FROM boarding_passes;

SELECT
COUNT(*),
fare_conditions
FROM boarding_passes AS b
INNER JOIN seats AS s
ON b.seat_no = s.seat_no
GROUP BY fare_conditions;


-- -- Q: Find tickets without a related boarding pass
-- SELECT
-- *
-- FROM tickets t
-- FULL OUTER JOIN boarding_passes b
-- ON t.ticket_no = b.ticket_no
-- WHERE b.flight_id is null

-- Find which line (A, B, H, etc) has been chosen the most frequently using left outer join
-- unnecessary join,just need boarding passes
SELECT
RIGHT(s.seat_no,1), COUNT(*)
FROM seats s
LEFT OUTER JOIN boarding_passes b
ON s.seat_no = b.seat_no
GROUP BY RIGHT(s.seat_no,1)
ORDER BY COUNT(*) DESC;


-- Q:  Find avg price for each seat after joining tables (multiple conditions)
SELECT
seat_no,ROUND(AVG(amount),2) AS avg_cost
FROM boarding_passes b
LEFT JOIN ticket_flights t
ON b.ticket_no = t.ticket_no
	AND b.flight_id = t.flight_id
GROUP BY seat_no
ORDER BY avg_cost DESC;


-- Day 15: Indexing assignment
SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   )
-- base runtime: 12.9s
-- index - flight_id: 12.9s
-- index - flight_no: 10.7s
-- index - depart.air: 12.9s
-- index - dept+fligt_no: 0.16s. !!!!!
-- index - fligt_No+dept: 0.24s

DROP INDEX index_depart_flightNo_flights;
CREATE INDEX index_depart_flightNo_flights
ON flights (flight_no,departure_airport);

SELECT * FROM flights
