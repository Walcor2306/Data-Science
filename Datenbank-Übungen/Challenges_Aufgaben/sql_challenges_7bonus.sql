/******************************************************************************
*******************************************************************************

SQL CHALLENGES bonus 2

*******************************************************************************
*******************************************************************************/

USE publications;

-- 1. Using LEFT JOIN: in which cities has "Is Anger the Enemy?" been sold?

SELECT
t.title,
p.city
FROM titles AS t
	LEFT JOIN publishers AS p USING (pub_id)
WHERE title = 'is Anger the Enemy?';

/* 2. Select all the book titles that have a link to the employee Howard Snyder 
    (he works for the publisher that has published those books). */

SELECT
t.title AS bokks_title,
e.fname AS first_name,
e.lname AS last_name

FROM publishers AS p
	INNER JOIN titles AS t USING (pub_id)
    INNER JOIN employee AS e USING (pub_id)
WHERE 
	e.fname = 'Howard'
    AND
    e.lname = 'Snyder';

/* 3. Using the JOIN of your choice: Select the book title with highest number of 
   sales (qty) */

SELECT
	t.title AS book_titel,
	(SUM(s.qty)) AS total_quantity_sold
FROM titles AS t
	INNER JOIN sales AS s USING (title_id)
GROUP BY t.title
ORDER BY (SUM(s.qty)) DESC
LIMIT 1;

--

SELECT
    t.title AS book_title,
    SUM(s.qty) AS total_quantity_sold
FROM titles AS t
    INNER JOIN sales AS s USING (title_id)
GROUP BY t.title
ORDER BY total_quantity_sold DESC
LIMIT 1;


/* 4. Select all book titles and the full name of their author(s).
      
      - If a book has multiple authors, all authors must be displayed (in 
      multiple rows).
      
      - Books with no authors and authors with no books should not be displayed.
*/



/* 5. Select the full name of authors of Psychology books

   Bonus hint: if you want to prevent duplicates but allow authors with shared
   last names to be displayed, you can concatenate the first and last names
   with CONCAT(), and use the DISTINCT clause on the concatenated names. */



/* 6. Explore the table roysched and try to grasp the meaning of each column. 
   The notes below will help:
   
   - "Royalty" means the percentage of the sale price paid to the author(s).
   
   - Sometimes, the royalty may be smaller for the first few sales (which have
     to cover the publishing costs to the publisher) but higher for the sales 
     above a certain threshold.
     
   - In the "roysched" table each title_id can appear multiple times, with
     different royalty values for each range of sales.
     
   - Select all rows for particular title_id, for example "BU1111", and explore
	 the data. */



/* 7. Select all the book titles and the maximum royalty they can reach.
    Display only titles that are present in the roysched table. */
    

