/* ==============================================================================
   SQL Joins 
-------------------------------------------------------------------------------
   This document provides an overview of SQL joins, which allow combining data
   from multiple tables to retrieve meaningful insights.
   
   If we want to combine TABLE A TABLE B 
   for columns use JOINs (need key columns / id to join)
   for rows use SET (both have same columns)

   Table of Contents:
     1. Basic Joins
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
     2. Advanced Joins
        - LEFT ANTI JOIN
        - RIGHT ANTI JOIN
        - ALTERNATIVE INNER JOIN
        - FULL ANTI JOIN
        - CROSS JOIN
     3. Multiple Table Joins (4 Tables)
=================================================================================
*/

/* ============================================================================== 
   BASIC JOINS 
=============================================================================== */

-- No Join (Return all data from both tables without combining them)
/* Retrieve all data from customers and orders as separate results */
SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN (only returns matching rows from both tables)

-- SELECT *
-- FROM A -- here order of tables does not matter
-- INNER JOIN B
-- ON a.key = b.key

/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id

-- LEFT JOIN (Return all rows from the left table and matching rows from the right table)

-- SELECT *
-- FROM A -- here order of tables matters (in FROM A is left table and in JOIN B is right table)
-- INNER JOIN B
-- ON a.key = b.key

/* Get all customers along with their orders, 
   including those without orders */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id

-- RIGHT JOIN (Return all rows from the right table and matching rows from the left table)
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c 
RIGHT JOIN orders AS o 
ON c.id = o.customer_id

-- Alternative to RIGHT JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders AS o 
LEFT JOIN customers AS c
ON c.id = o.customer_id

-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */
-- order of tables does not matter in FULL JOIN
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c 
FULL JOIN orders AS o 
ON c.id = o.customer_id

/* ============================================================================== 
   ADVANCED JOINS
=============================================================================== */

-- LEFT ANTI JOIN (Return all rows from the left table that do not have a match in the right table)

-- SELECT *
-- FROM A
-- LEFT JOIN B
-- ON a.key = b.key
-- WHERE b.key IS NULL

/* Get all customers who haven't placed any order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

-- RIGHT ANTI JOIN (Return all rows from the right table that do not have a match in the left table)
/* Get all orders without matching customers */
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL

-- Alternative to RIGHT ANTI JOIN using LEFT JOIN
/* Get all orders without matching customers */
SELECT *
FROM orders AS o 
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL

-- Alternative to INNER JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c 
FULL JOIN orders AS o 
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL AND c.id IS NOT NULL

-- FULL ANTI JOIN (Return all rows from both tables that do not have a match in the other table)

SELECT *
FROM A
FULL JOIN B
ON a.key = b.key
WHERE b.key IS NULL OR a.key IS NULL

/* Find customers without orders and orders without customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c 
FULL JOIN orders AS o 
ON c.id = o.customer_id
WHERE o.customer_id IS NULL OR c.id IS NULL

-- CROSS JOIN
/* Generate all possible combinations of customers and orders , combines every row from the first table with every row from the second table. order of tabel doesnt matter*/
SELECT *
FROM customers
CROSS JOIN orders

/* ============================================================================== 
   MULTIPLE TABLE JOINS (4 Tables)
=============================================================================== */

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

USE SalesDB

SELECT 
    o.OrderID,
    o.Sales,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    p.Product AS ProductName,
    p.Price,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID

SELECT 
	o.OrderID,
	o.Sales,
	c.FirstName AS customer_firstname,
	c.LastName AS customer_lastname,
	p.Product,
	p.Price,
	e.FirstName AS salesperson_firstname,
	e.LastName AS salesperson_lastname
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID