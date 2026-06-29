/* ==============================================================================
   SQL Data Manipulation Language (DML)
-------------------------------------------------------------------------------
   This guide covers the essential DML commands used for inserting, updating, 
   and deleting data in database tables.

   Table of Contents:
     1. INSERT - Adding Data to Tables (add new rows in existing database tables)
     2. UPDATE - Modifying Existing Data
     3. DELETE - Removing Data from Tables
=================================================================================
*/

/* ============================================================================== 
   INSERT
=============================================================================== */

-- INSERT SYNTAX

-- INSERT INTO table_name (column1, column2, column3, ...) -- OPTIONAL: If no columns are specified, SQL expects values for all columns 
-- VALUES (value1, value2, value3, ...),
--         (value1, value2, value3, ...) -- Multiple Inserts 
-- Match the number of columns and Values (ORDER). 

/* #1 Method: Manual INSERT using VALUES */
-- Insert new records into the customers table
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100)

-- Incorrect column order 
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (8, 'Max', 'USA', NULL)
    
-- Incorrect data type in values
INSERT INTO customers (id, first_name, country, score)
VALUES 
	('Max', 9, 'Max', NULL)

-- Insert a new record with full column values
INSERT INTO customers (id, first_name, country, score)
VALUES (8, 'Max', 'USA', 368)

-- Insert a new record without specifying column names (not recommended)
INSERT INTO customers 
VALUES 
    (9, 'Andreas', 'Germany', NULL)
    
-- Insert a record with only id and first_name (other columns will be NULL or default values)
INSERT INTO customers (id, first_name)
VALUES 
    (10, 'Sahra')
-- also you can skip that is NULL allowed in the table definition, and it will be automatically set to NULL or default value if defined.
-- for example if you dont mention id in INSERT INTO customers (first_name) then id will be set to NULL but id is defined as NOT NULL then it will throw an error.

/* #2 Method: INSERT DATA USING SELECT - Moving Data From One Table to Another */
-- steps 
-- 1. using SELECT FROM the source table to get the data you want to INSERT INTO the target table.
-- 2. use the INSERT INTO target_table (column1, column2, ...) SELECT column1, column2, ... FROM source_table WHERE condition; to insert the selected data into the target table.

-- Copy data from the 'customers' table into 'persons'
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers

/* ============================================================================== 
   UPDATE
=============================================================================== */
-- UPDATE Syntax

-- UPDATE table_name
-- SET
--     column1 = value1,
--     column2 = value2
-- WHERE <condition>
-- NOTE : - Always use WHERE to avoid UPDATING all rows unintentionally

-- Change the score of customer with ID 6 to 0
UPDATE customers
SET score = 0
WHERE id = 6

-- Change the score of customer with ID 10 to 0 and update the country to 'UK'
UPDATE customers
SET score = 0,
    country = 'UK'
WHERE id = 10

-- Update all customers with a NULL score by setting their score to 0
UPDATE customers
SET score = 0
WHERE score IS NULL

-- Verify the update
SELECT *
FROM customers
WHERE score IS NULL

/* ============================================================================== 
   DELETE
=============================================================================== */

-- DELETE Syntax

-- DELETE FROM table_name
-- WHERE <condition>
-- NOTE :- Always use WHERE to avoid DELETING all rows unintentionally

-- Select customers with an ID greater than 5 before deleting
SELECT *
FROM customers
WHERE id > 5

-- Delete all customers with an ID greater than 5
DELETE FROM customers
WHERE id > 5

-- Delete all data from the persons table
DELETE FROM persons

-- Faster method to delete all rows, especially useful for large tables
TRUNCATE TABLE persons
