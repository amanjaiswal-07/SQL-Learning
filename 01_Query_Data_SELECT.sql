/* ==============================================================================
   SQL SELECT Query
-------------------------------------------------------------------------------
   This guide covers various SELECT query techniques used for retrieving, 
   filtering, sorting, and aggregating data efficiently.

   Table of Contents:
     1. SELECT ALL COLUMNS
     2. SELECT SPECIFIC COLUMNS
     3. WHERE CLAUSE
     4. ORDER BY
     5. GROUP BY
     6. HAVING
     7. DISTINCT
     8. TOP
     9. Combining Queries
	 10. COOL STUFF - Additional SQL Features
=================================================================================
*/

/* ==============================================================================
   COMMENTS
=============================================================================== */

-- This is a single-line comment.

/* This
   is
   a multiple-line
   comment
*/

/* ==============================================================================
   SELECT ALL COLUMNS
=============================================================================== */

-- Retrieve All Customer Data
SELECT *
FROM customers

-- Retrieve All Order Data
SELECT *
FROM orders

/* ==============================================================================
   SELECT FEW COLUMNS
=============================================================================== */

-- Retrieve each customer's name, country, and score. (make a list of columns)
SELECT 
    first_name,
    country, 
    score
FROM customers
-- here if you change the order in the o/p order also changed

/* ==============================================================================
   WHERE (filter your data based on condition) (before aggregation)
=============================================================================== */

-- Retrieve customers with a score not equal to 0
SELECT *
FROM customers
WHERE score != 0

-- Retrieve customers from Germany
SELECT *
FROM customers
WHERE country = 'Germany'

-- Retrieve the name and country of customers from Germany
SELECT
    first_name,
    country
FROM customers
WHERE country = 'Germany'

/* ==============================================================================
   ORDER BY (sort your data) (is not specified it assumes ascending) ASC / DESC 
=============================================================================== */

/* Retrieve all customers and 
   sort the results by the highest score first. */
SELECT *
FROM customers
ORDER BY score DESC

/* Retrieve all customers and 
   sort the results by the lowest score first. */
SELECT *
FROM customers
ORDER BY score ASC

/* Retrieve all customers and 
   sort the results by the country. */
SELECT *
FROM customers
ORDER BY country ASC

/* Retrieve all customers and 
   sort the results by the country and then by the highest score. */
SELECT *
FROM customers
ORDER BY country ASC, score DESC

--here Column order in ORDER BY is crucial, as sorting is sequential

/* Retrieve the name, country, and score of customers 
   whose score is not equal to 0
   and sort the results by the highest score first. */
SELECT
    first_name,
    country,
    score
FROM customers
WHERE score != 0
ORDER BY score DESC

/* ==============================================================================
   GROUP BY (aggregate column by another column)
=============================================================================== */

-- Find the total score for each country
SELECT 
    country,   --(category)
    SUM(score) AS total_score --(aggregrate)
FROM customers
GROUP BY country
 
--AS (ALIAS)
--shorthand name (Label) assigned to a column or table in a query

/* This will not work because 'first_name' is neither part of the GROUP BY 
   nor wrapped in an aggregate function. SQL doesn't know how to handle this column. */

-- All columns in the SELECT must be either aggregated or included in the GROUP BY
--The Result of GROUP BY determined by the unque values of the grouped columns
SELECT 
    country,
    first_name,
    SUM(score) AS total_score
FROM customers
GROUP BY country

-- Find the total score and total number of customers for each country
SELECT 
    country,
    SUM(score) AS total_score,
    COUNT(id) AS total_customers
FROM customers
GROUP BY country

/* ==============================================================================
   HAVING (filter data after aggregation) (can be only used with/after group by) (after aggregation)
=============================================================================== */

/* Find the average score for each country
   and return only those countries with an average score greater than 430 */
SELECT
    country,
    AVG(score) AS avg_score
FROM customers
GROUP BY country
HAVING AVG(score) > 430

/* Find the average score for each country
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430 */
SELECT
    country,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430

/* ==============================================================================
   DISTINCT (remove duplicates / repeated values) 
=============================================================================== */

-- Don't use DISTINCT unless it's necessary, it can slow down your query
-- Return Unique list of all countries
SELECT DISTINCT country
FROM customers

/* ==============================================================================
   TOP (Restrict the number of rows returned)
=============================================================================== */

-- Retrieve only 3 Customers
SELECT TOP 3 *
FROM customers

-- Retrieve the Top 3 Customers with the Highest Scores
SELECT TOP 3 *
FROM customers
ORDER BY score DESC

-- Retrieve the Lowest 2 Customers based on the score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC

-- Get the Two Most Recent Orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC

/* ==============================================================================
   All Together
=============================================================================== */

/* Calculate the average score for each country 
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430
   and sort the results by the highest average score first. */
SELECT
    country,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430
ORDER BY AVG(score) DESC

/* ============================================================================== 
   COOL STUFF - Additional SQL Features
=============================================================================== */

-- Execute multiple queries at once
SELECT * FROM customers;
SELECT * FROM orders;

/* Selecting Static Data */
-- Select a static or constant value without accessing any table
SELECT 123 AS static_number;

SELECT 'Hello' AS static_string;

-- Assign a constant value to a column in a query
SELECT
    id,
    first_name,
    'New Customer' AS customer_type
FROM customers;