/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES 7

*******************************************************************************
*******************************************************************************
USE publications;

In the exercises below you will need to use the clauses you used in the
previous SQL Challenges, plus the following clauses:
    - CASE
*/

/*******************************************************************************
CASE

https://www.w3schools.com/sql/sql_case.asp
*******************************************************************************/

/* 1. Select everything from the sales table and create a new column called 
   "sales_category" with case conditions to categorise qty:
   
		qty >= 50 high sales
		20 <= qty < 50 medium sales
		qty < 20 low sales
*/

SELECT
	*,
CASE    
    WHEN qty >= 50 THEN 'high sales'
	WHEN qty >= 20 THEN 'medium sales'
	ELSE 'low sales'
    END AS 'sales category' 
    FROM sales;
--

SELECT 
    *,
    CASE
        WHEN qty >= 50 THEN 'high sales'
        WHEN qty >= 20 AND qty < 50 THEN 'medium sales'
        ELSE 'low sales'
    END AS sales_category
FROM sales;

--

SELECT
	*,
	CASE
		WHEN qty >= 50 THEN 'high sales'
		WHEN qty BETWEEN 20 AND 50 THEN 'medium sales'
		ELSE 'low sales'
    END AS sales_category
FROM sales;


/* 2. Given your three sales categories (high, medium, and low), 
   calculate the total number of books sold in each category. 
*/

SELECT
	SUM(qty) AS 'books_sold', # hier wird die Summe von qty gemacht
	CASE
		WHEN qty >= 50 THEN 'high' # hier werden alle werte größer und gleich 50 definiert.
		WHEN qty >= 20 THEN 'medium' # hier werden alle werte größer und gleich 20 definiert.
		ELSE 'low' # hier wird alle werte kleiner als 20  definiert.
    END AS 'sales_category' # Ende der case mit der Spalte-Name sales_categorie 
FROM sales
GROUP BY sales_category; 	#hier wird sales categorie gruppiert. Damit alle Werte, die größer gleich 50 sind, addiert werden (category = high),
							#genauso für 20 sales (categorry = medium) und für kleiner als 20 sales (categorry = low) 

--
## aqui tomaria solo los valores iguales en qty sumandolos
SELECT
SUM(qty) AS 'books_sold', 
CASE
	WHEN qty >= 50 THEN 'high' 
    WHEN qty >= 20 THEN 'medium'
    ELSE 'low'
    END AS 'sales_category'
FROM sales
GROUP BY qty;
--
SELECT
	SUM(qty) AS total_books_sold,
    CASE
        WHEN qty >= 50 THEN 'high sales'
        WHEN qty >= 20 THEN 'medium sales'
        ELSE 'low sales'
    END AS sales_category
FROM sales
GROUP BY sales_category;
--
-- additional
-- Given your three sales categories (high, medium, and low), 
-- calculate the total number of transactions in each category.

SELECT
 COUNT(qty) AS total_transactions, # hier zählt man an Anzahl von transactionen gezählt
    CASE
        WHEN qty >= 50 THEN 'high sales' # hier werden alle werte größer und gleich 50 definiert.
        WHEN qty >= 20 THEN 'medium sales' # hier werden alle werte größer und gleich 20 definiert
        ELSE 'low sales' # hier wird alle werte kleiner als 20  definiert.
    END AS sales_category # Ende der case mit der Spalte-Name sales_categorie    
FROM sales
GROUP BY sales_category; #hier wird sales categorie gruppiert. Damit alle Werte, die größer gleich 50 sind, gezählt werden (category = high),
							#genauso für 20 sales (categorry = medium) und für kleiner als 20 sales (categorry = low)

-- zum analysiren:

#SELECT
#t.type AS category,
#SUM(s.qty) AS books_sold,
#	CASE
#		WHEN SUM(s.qty) >= 50 THEN 'high'
#		WHEN SUM(s.qty) BETWEEN 20 AND 50 THEN 'medium'
#		ELSE 'low'
#	END AS 'sales_category'
#FROM sales s
#	LEFT JOIN titles t USING (title_id)
#GROUP BY sales_category


/* 3. Adding to your answer from the previous questions: output only those 
   sales categories that have a SUM(qty) greater than 100, and order them in 
   descending order */

SELECT
	SUM(qty) AS 'books_sold', # hier wird die Summe von qty gemacht
	CASE
		WHEN qty >= 50 THEN 'high' # hier werden alle werte größer und gleich 50 definiert.
		WHEN qty >= 20 THEN 'medium' # hier werden alle werte größer und gleich 20 definiert.
		ELSE 'low' # hier wird alle werte kleiner als 20  definiert.
    END AS 'sales_category' # Ende der case mit der Spalte-Name sales_categorie 
FROM sales
GROUP BY sales_category 	#hier wird sales categorie gruppiert. Damit alle Werte, die größer gleich 50 sind, addiert werden (category = high),
							#genauso für 20 sales (categorry = medium) und für kleiner als 20 sales (categorry = low) 
HAVING SUM(qty) > 100 # Mit "HAVING SUM(qty) > 100" betrachtet man nur die Summe, die größer als 100 sind 
ORDER BY books_sold DESC; # MI"ORDER BY total_books_sold" ordnet man die Werte absteigend.

--

SELECT
	SUM(qty) AS total_books_sold,
    CASE
        WHEN qty >= 50 THEN 'high sales'
        WHEN qty >= 20 AND qty < 50 THEN 'medium sales'
        ELSE 'low sales'
    END AS sales_category
FROM sales
GROUP BY sales_category
HAVING SUM(qty) > 100 # Mit "HAVING SUM(qty) > 100" betrachtet man nur die Summe, die größer als 100 sind 
ORDER BY total_books_sold DESC; # MI"ORDER BY total_books_sold" ordnet man die Werte absteigend.

/* 4. Find out the average book price, per publisher, for the following book 
    types and price categories:
		book types: business, traditional cook and psychology
		price categories: <= 5 super low, <= 10 low, <= 15 medium, > 15 high
        
    - When displaying the average prices, use ROUND() to hide decimals. */
    
SELECT
	p.pub_name AS publishers_name, # publisher_name wird ausgegeben
    t.type AS category, # category wird ausgegeben
    ROUND(AVG(t.price),2) AS AVG_book_price, # Hier wird den AVG ermittelt und nur Ganze-Zahlen betrachtet
    CASE
		WHEN price <= 5 THEN 'super low' # super low <= 5 wird definiert
		WHEN price <= 10 THEN 'low' # low <=10 wird definiert
        WHEN price <= 15 THEN 'medium' # medium <15 wird definier
		ELSE 'high' # high wird definiert, wenn price größer als 15 ist.
	END AS price_category
FROM titles AS t 
	RIGHT JOIN publishers AS p USING(pub_id)# Verknpfung der titles-Tabelle mit der publisher-Tabelle  
							  # "ON t.pub_id = p.pub_id" kann man auch benutzen 
WHERE t.type IN ('business', 'trad cook', 'psychology') #  wegen: "book types: business, traditional cook and psychology"
GROUP BY p.pub_name, t.type, price_category; # bei Gruppierung: zuerst "p.pub_name" wegen: ...average book price, per publisher...
											 # danach "t.type" wegen: ...for the following book types
                                             #am Ende "price_category" für die Betrachtung der category bei gerundeten AVG.

--
SELECT
    p.pub_name,
    t.type,
    CASE
        WHEN t.price <= 5 THEN 'super low'
        WHEN t.price <= 10 THEN 'low'
        WHEN t.price <= 15 THEN 'medium'
        ELSE 'high'
    END AS price_category,
    ROUND(AVG(t.price), 0) AS avg_price
FROM titles t
JOIN publishers p ON t.pub_id = p.pub_id
WHERE t.type IN ('business', 'trad_cook', 'psychology')
GROUP BY p.pub_name, t.type, price_category;