--Author: Sarosha Momin
--UTEID: SM66825
--Date: 04/01/2021


--Return title, format, genre, isbn using subquery in WHERE clause, Sarosha sm66825
--#1 
SELECT DISTINCT title, format, genre, isbn
FROM title t 
WHERE t.title_id IN 
    (SELECT title_id 
     FROM patron_title_holds)
ORDER BY t.genre, t.title;


--Titles have a higher than average number of pages, Sarosha sm66825
--#2
SELECT title, publisher, number_of_pages, genre 
FROM title
WHERE number_of_pages > (SELECT AVG(number_of_pages)
                         FROM title)
ORDER BY genre, number_of_pages DESC;


--Returns the patron info for patrons that don't have phone records, Sarosha sm66825
--#3
SELECT first_name, last_name, email
FROM patron p
WHERE p.patron_id NOT IN (SELECT patron_id
                          FROM patron_phone)
ORDER BY last_name;


--Returns title info for those published by publisher with more than 3 books, Sarosha sm66825
--#4
SELECT t.title, t.publisher, t.genre, t.isbn
FROM title t JOIN (
                   SELECT publisher, COUNT(title)
                   FROM title 
                   HAVING COUNT(title) > 3
                   GROUP BY publisher
                   ) pp
             ON t.publisher = pp.publisher
ORDER BY t.publisher;


--List of patrons that have current checkouts and also have accrued_fees, Sarosha sm66825
--#5
SELECT patron_id, email, accrued_fees, primary_branch
FROM patron p
WHERE p.patron_id IN    (SELECT DISTINCT patron_id
                        FROM checkouts
                        WHERE date_in is NULL)
ORDER BY primary_branch, email;


--Pull six columns from DUAL table with diff formats, Sarosha sm66825
--#6

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YEAR') AS Year, RTRIM(TO_CHAR(SYSDATE, 'DAY MONTH')) as Day_Month, 
       ROUND(TO_NUMBER(TO_CHAR(SYSDATE, 'HH'))) AS HR, ROUND((TO_DATE('31-DEC-21') - SYSDATE), 2)
       AS Days_End, TO_CHAR(SYSDATE, LOWER('MON DY YYYY')) AS Low_Date
FROM DUAL;


--Checkout status report for patrons with checkouts, Sarosha sm66825
--#7
SELECT first_name || ' ' || last_name AS patron, 
       'Checkout ' || checkout_id || ' due back on ' || due_back_date AS checkout_due_back, 
       CASE 
            WHEN (date_in is NULL)
                THEN 'Not returned yet'
            ELSE 'Returned'
       END AS Return_Status, 
       'Accrued fee total is:'||TO_CHAR(accrued_fees, '$999.99') AS fees
FROM CHECKOUTS c JOIN PATRON p on c.patron_id = p.patron_id
ORDER BY Return_Status, due_back_date;


--Pull a list of inactive patrons with name format as c.Tuttle (Example), Sarosha sm66825
--#8
SELECT LOWER(SUBSTR(first_name, 1, 1)) || '.' || UPPER(last_name) AS inactive_patron
FROM PATRON p 
WHERE p.patron_id NOT IN (SELECT patron_id
                          FROM CHECKOUTS)
ORDER BY last_name;


--Returns a list of all the book titles that are at least 5 years old based on their publish_date, Sarosha sm66825 
--#9
SELECT title, LENGTH(title) AS Length_of_Title, publish_date, ROUND((SYSDATE - publish_date)/365.25, 2) AS age_of_book
FROM TITLE t
WHERE ROUND((SYSDATE - publish_date), 2)/365.25 > 5
ORDER BY age_of_book;


--Return the branch_id, a column based on first word in branch_name and divide the address, Sarosha sm66825
--#10
SELECT branch_id, substr(branch_name, 1, instr(branch_name,' ')-1) AS District, 
       substr(address, 1, instr(address,' ')-1) AS street_number, 
       substr(address, instr(address,' ')) AS street_name
FROM location;


--Redacted contact list with first and last name, redacted email, phone type and redacted_phone, Sarosha sm66825 
--#11
SELECT first_name, last_name, '*******' || SUBSTR(email, INSTR(email, '@')) AS redacted_email, phone_type,
       '***-***' || SUBSTR(phone, 8) AS redacted_phone
FROM PATRON p INNER  JOIN PATRON_PHONE pp ON p.patron_id = pp.patron_id;


--Returns the reading level of books in 'b' and 'e' using CASE, Sarosha sm66825
--#12
SELECT CASE 
            WHEN (number_of_pages > 700)
                THEN 'College'
            WHEN (number_of_pages between 250 and 700)
                THEN 'High School'
            WHEN (number_of_pages <= 250)
                THEN 'Middle School'
       END AS Reading_Level, 
       title, publisher, number_of_pages, genre, format
FROM TITLE
WHERE FORMAT IN ('B', 'E')
ORDER BY Reading_Level, title;


--Pulls all books their popularity based on how many checkouts they’ve had, Sarosha sm66825 
--#13
SELECT DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT checkout_id)) AS Popularity_Rank, title, 
       COUNT(DISTINCT checkout_id) AS Number_of_Checkouts
FROM CHECKOUTS c FULL JOIN TITLE_LOC_LINKING tll ON c.title_copy_id = tll.title_copy_id 
                 FULL JOIN TITLE t ON tll.title_id = t.title_id
GROUP BY title;


--Update the previous query to return a row_number, title, and number_of_checkouts using inline subquery, Sarosha sm66825
--#14
SELECT * 
FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY COUNT (DISTINCT CHECKOUT_ID)) AS row_number, title, 
               COUNT(DISTINCT checkout_id) AS Number_of_Checkouts
        FROM CHECKOUTS c FULL JOIN TITLE_LOC_LINKING tll ON c.title_copy_id = tll.title_copy_id 
                         FULL JOIN TITLE t ON tll.title_id = t.title_id
        GROUP BY title
     )
WHERE ROW_NUMBER = 58;






