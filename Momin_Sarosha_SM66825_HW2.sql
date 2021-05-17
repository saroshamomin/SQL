-- Author: Sarosha Momin
-- Date: 03/11/2021
-- UTEID: sm66825


--update the late_flag if the the due back date is before today, Sarosha Momin sm66825
UPDATE CHECKOUTS
SET late_flag = 'Y'
WHERE due_back_date < SYSDATE;


--Queries: 
--display genre, title, publisher, and number_of_pages in ascending order of pages, Sarosha Momin sm66825
SELECT genre, title, publisher, number_of_pages
FROM Title
ORDER BY number_of_pages;

--get authors full name where the first name starts with A, B or C in last name desc order, Sarosha Momin sm66825 
SELECT First_Name || ' ' || Last_Name AS "author_full_name"
FROM Author
WHERE First_Name IN (SELECT First_Name
                    FROM Author
                    WHERE First_Name LIKE 'A%' OR First_Name LIKE 'B%' OR First_Name LIKE 'C%')
ORDER BY Last_Name DESC;

--find info on books checkout out in feb and order by date out and date in, Sarosha Momin sm66825
SELECT patron_id, title_copy_id, date_out, due_back_date, date_in
FROM CHECKOUTS
WHERE date_out BETWEEN '01-FEB-2021' AND '28-FEB-2021'
ORDER BY date_in, date_out;

--duplicate of the previous query but the WHERE clause uses only (<, >, <=, or >=), Sarosha Momin sm66825
SELECT patron_id, title_copy_id, date_out, due_back_date, date_in
FROM CHECKOUTS
WHERE date_out >= '01-FEB-2021' AND date_out <= '28-FEB-2021'
ORDER BY date_in, date_out;

--get columns from checkouts and create an alias with only 5 rows returned, Sarosha Momin sm66825
SELECT checkout_id, title_copy_id, (2 - times_renewed) AS "renewals_left"
FROM CHECKOUTS
WHERE ROWNUM <= 5
ORDER BY "renewals_left";

--select columns where the book_level > 9 from title, Sarosha Momin sm66825
SELECT title, genre, ROUND(number_of_pages/100) AS "Book_Level"
FROM TITLE
WHERE ROUND(number_of_pages/100) > 9;

--statement that retrieves author name where there is a middle name that is not null, Sarosha Momin sm66825
SELECT first_name, middle_name, last_name
FROM AUTHOR
WHERE middle_name IS NOT NULL
ORDER BY 2, 3;

--format today's date and add other columns to the DUAL table, Sarosha Momin sm66825
SELECT SYSDATE AS "today_unformatted", TO_CHAR(SYSDATE, 'MM-DD-YYYY') AS "today_formatted", 5 AS "days_late",
    .25 AS "late_fee", 5 * .25 AS "total_late_fees", 5-(5*.25) AS "late_fees_until_lock"
FROM DUAL;

--get checkout_id, title_copy_id & renewals_left. sort table by renewals left before filtering 5 rows, Sarosha Momin sm66825
SELECT * 
FROM (SELECT checkout_id, title_copy_id, (2 - times_renewed) AS "renewals_left"
     FROM CHECKOUTS
     ORDER BY "renewals_left")
WHERE ROWNUM <= 5;

--query that returns the distinct list of genres from the title table sorted by genre ascending, Sarosha Momin sm66825
SELECT DISTINCT genre
FROM TITLE
ORDER BY genre;

--return all rows from Title for books with 'bird' in them, Sarosha Momin sm66825
SELECT * 
FROM TITLE 
WHERE LOWER(title) LIKE '%bird%' AND FORMAT = 'B';



