/*
*******************************************************************************
*******************************************************************************

SQL CHALLENGES 3

*******************************************************************************
*******************************************************************************

In the exercises below you will need to use the following clauses/operators:
	- ORDER BY
	- LIMIT
    - MIN(), MAX()
    - COUNT(), AVG(), SUM()

In SQL we can have many databases, they will show up in the schemas list
We must first define which database we will be working with.
*/

USE publications;

/******************************************************************************
ORDER BY
******************************************************************************/
-- https://www.w3schools.com/sql/sql_orderby.asp

/* 1. Select the title and ytd_sales from the table titles. Order them by the
year to date sales. */

SELECT
	title AS book_title,
    ytd_sales AS year_to_Date_Sales
FROM 
	titles
WHERE
	ytd_sales > 0	# so that "null" doesn't appear 
ORDER BY
	ytd_sales;		# default ist ASC (ascending)
					# by DESC is descending



-- 2. Repeat the same query, but this time sort the titles in descending order

SELECT
	title AS book_title,
    ytd_sales AS year_to_Date_Sales
FROM 
	titles
WHERE
	ytd_sales > 0
ORDER BY
	ytd_sales DESC;		


/******************************************************************************
LIMIT

https://www.w3schools.com/mysql/mysql_limit.asp
******************************************************************************/

-- 3. Select the top 5 titles with the most ytd_sales from the table titles

SELECT
	title AS book_title,
	ytd_sales AS year_to_date_sales
FROM titles
ORDER BY
	ytd_sales DESC
LIMIT
	5;
/******************************************************************************
MIN and MAX

https://www.w3schools.com/sql/sql_min_max.asp
******************************************************************************/

-- 4. What's the maximum amount of books ever sold in a single order?

SELECT
	MAX(qty) AS max_quantity_sold
FROM sales;

--

SELECT 
	qty AS books_per_order
FROM 
	sales
ORDER BY
	qty DESC
LIMIT
	1;

-- 5. What's the price of the cheapest book?

SELECT
	MIN(price) AS cheapest_book
FROM
	titles;

SELECT
	price
FROM 
	titles
WHERE 
	price > 0
ORDER BY 
	price
LIMIT 
	1;

/******************************************************************************
COUNT, AVG, and SUM

https://www.w3schools.com/sql/sql_count_avg_sum.asp

******************************************************************************/

 -- 6. How many rows are there in the table authors?

SELECT
	COUNT(*) AS numbers_of_rows
FROM
	authors;

 -- 7. What's the total amount of year-to-date sales?

SELECT
	SUM(ytd_sales) AS total_sales
FROM
	titles;


 -- 8. What's the average price of books?

SELECT
	AVG(price) AS AVG_price_of_books
FROM 
	titles;
    
-- # Mit Rundung auf 2 Stellen

SELECT 
ROUND(AVG(price),2) AS price_AVG
FROM titles;


/* 9. In a single query, select the count, average and sum of quantity in the
table sales */

SELECT
	COUNT(*) AS COUNT_of_SALES,
	AVG(qty) AS AVG_of_quantity,
	SUM(qty) AS SUMME_of_quantity
FROM 
	sales;

/*
In the exercises below you will need to use the following clauses/operators:
	- SELECT FROM
    - AS
	- DISTINCT
	- WHERE
	- AND / OR / NOT
	- ORDER BY
	- LIMIT
    - MIN(), MAX()
    - COUNT(), AVG(), SUM()

*/

-- 10. From how many different states are our authors?

SELECT
	COUNT(DISTINCT state)
FROM 
authors;



-- 11. How many publishers are based in the USA?

SELECT
	COUNT(country)
FROM 
	publishers
WHERE 
	country = 'USA';

--

SELECT
	COUNT(*)
FROM 
	publishers
WHERE 
	country = 'USA';


-- 12. What's the average quantity of titles sold per sale by store 7131?

SELECT
stor_id,
AVG(qty)
FROM sales
WHERE stor_id = 7131
GROUP BY stor_id;


-- 13. When was the employee with the highest level hired?

SELECT
MAX(job_lvl),
hire_date
FROM employee
GROUP BY hire_date
ORDER BY MAX(job_lvl) DESC
LIMIT 1;
--

SELECT
job_lvl,
hire_date
FROM employee
ORDER BY job_lvl DESC
LIMIT 1;

-- 14. What's the average price of psychology books?

SELECT
AVG(price),
type
FROM titles
WHERE type = 'psychology';

-- 15. Which category of books has had more year-to-date sales, "business" or
-- "popular_comp"? You can write two queries to answer this question.

-- business

SELECT
SUM(ytd_sales)
FROM titles
WHERE type = 'business';
--
SELECT
SUM(ytd_sales)
FROM titles
WHERE type = 'popular_comp';

-- popular_comp


-- 16. What's the title and the price of the most expensive book?

SELECT
title,
price
FROM titles
ORDER BY price DESC
LIMIT 1;


-- 17. What's the price of the most expensive psychology book?

SELECT
type,
price
FROM titles
WHERE type = 'psychology'
ORDER BY price DESC
LIMIT 1;


-- 18. How many authors live in either San Jose or Salt Lake City

SELECT
COUNT(city)
FROM authors
WHERE city IN ('San Jose', 'Salt Lake City');
