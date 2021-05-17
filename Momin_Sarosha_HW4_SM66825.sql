-- Author: Sarosha Momin
-- Date: 03/25/2021
-- UTEID: sm66825

--Statement joins Patron to Patron_Phone, order by Last_Name & Phone_Type DESC, Sarosha sm66825
--1
SELECT first_name || ' ' || last_name AS "Full_Name", Phone_Type, Phone
FROM PATRON INNER JOIN Patron_Phone ON PATRON.Patron_id = Patron_Phone.Patron_id
ORDER BY Last_Name, Phone_Type DESC;


--Query that returns the first_name, last name, email, and accrued_fees patrons from “Northeast Central”. Filter out any patrons with no accrued fees, Sarosha sm66825
--2
SELECT first_name, last_name, email, accrued_fees
FROM PATRON INNER JOIN location ON patron.primary_branch = location.branch_id
WHERE accrued_fees > 0 AND branch_name = 'Northeast Central Branch';


--Query that shows the title, number of pages, and author’s full name. Only titles that are books and FIC. Sort by author name and title, Sarosha sm66825
--3
SELECT title, number_of_pages, First_Name || ' ' || Last_Name AS "author_name"
FROM TITLE t, AUTHOR a, title_author_linking l
WHERE t.title_id = l.title_id 
      AND a.author_ID = l.title_id
      AND t.format = 'B'
      AND t.genre = 'FIC'
ORDER BY "author_name", title;


--Query for Title, Format, Genre, and ISBN of titles with no holds & sort by genre and title, Sarosha sm66825
--4
SELECT title, format, genre, isbn
FROM TITLE t LEFT OUTER JOIN patron_title_holds h ON t.title_ID = h.title_ID
WHERE h.hold_id is NULL 
ORDER BY t.genre, t.title; 


--Query that pulls titles & their holds & patron info for SCI titles, Sarosha sm66825
--5
SELECT title, hold_ID, first_name, last_name, genre
FROM TITLE t LEFT JOIN patron_title_holds h ON t.title_ID = h.title_id 
     LEFT JOIN patron p ON h.patron_ID = p.patron_ID
WHERE genre = 'SCI';


--Query that shows title info for book or e-book with “Reading_Level” column, Sarosha sm66825
--6
SELECT title, publisher, number_of_pages, genre, 'College' AS Reading_Level
FROM title
WHERE format IN ('B', 'E') AND number_of_pages > 700
    UNION
SELECT title, publisher, number_of_pages, genre, 'High School' AS Reading_Level
FROM title
WHERE format IN ('B', 'E') AND number_of_pages >= 250 AND number_of_pages <= 700
    UNION
SELECT title, publisher, number_of_pages, genre, 'Middle School' AS Reading_Level
FROM title
WHERE format IN ('B', 'E') AND number_of_pages < 250
ORDER BY 5, 1;


--return single row with the columns and their aliases, Sarosha SM66825
--7
SELECT COUNT(patron_id) AS patron_count, COUNT(UNIQUE zip) AS Distinct_Zipcodes,
       MIN(accrued_fees) AS Lowest_Fees, ROUND(AVG(accrued_fees), 2) AS Average_Fees,
       MAX(accrued_fees) AS Highest_Fees
FROM patron;
       

--Return one row for each branch & their count Patron_Count, Sarosha sm66825
--8
SELECT branch_name, COUNT(patron_id) AS patron_count
FROM LOCATION l LEFT JOIN PATRON p ON l.branch_id = p.primary_branch
GROUP BY branch_name; 


--Query that pulls patrons & their checkouts that aren't flagged as “Late”, Sarosha sm66825
--9
SELECT zip, ROUND(AVG(accrued_fees), 2) AS "Average_Accrued_Fees"
FROM PATRON p INNER JOIN CHECKOUTS c ON p.patron_id = c.patron_id
WHERE late_flag <> 'Y'
GROUP BY zip
ORDER BY "Average_Accrued_Fees" DESC;


--Return Branch_Name and Avg_Days_Overdue(today’s date - due_back_date), Sarosha sm66825
--10
SELECT l.branch_name, ROUND(AVG(SYSDATE - c.due_back_date)) AS "Avg_Days_Overdue"
FROM location l INNER JOIN title_loc_linking tll ON l.branch_id = tll.last_location
     INNER JOIN checkouts c ON tll.title_copy_id = c.title_copy_id
WHERE c.date_in is NULL AND (SYSDATE - c.due_back_date) > 0
GROUP BY l.branch_name
HAVING ROUND(AVG(SYSDATE - c.due_back_date)) >= 10;


--Find all titles with more than 1 author & sort by genre desc and title, Sarosha sm66825
--11
SELECT t.title, t.genre, COUNT(l.author_id) as Author_Count
FROM title t INNER JOIN title_author_linking l ON t.title_ID = l.title_ID
WHERE l.title_id is NOT NULL AND l.author_id is NOT NULL
GROUP BY (t.title, t.genre)
HAVING COUNT(l.author_id) > 1
ORDER BY t.genre DESC, t.title; 


--Copy previous query and add filter to show authors with 'PhD' in last_name, Sarosha sm66825
--12
SELECT t.title, t.genre, COUNT(l.author_id) as Author_Count
FROM title t INNER JOIN title_author_linking l ON t.title_ID = l.title_ID 
     INNER JOIN author a ON l.author_id = a.author_id
WHERE l.title_id is NOT NULL AND l.author_id is NOT NULL AND a.last_name LIKE '%PhD%'
GROUP BY (t.title, t.genre)
HAVING COUNT(l.author_id) > 1
ORDER BY t.genre DESC, t.title; 


--Find average accrued fees for each city and rollup to get subtotal, Sarosha sm66825
--13 A
SELECT city, ROUND(AVG(accrued_fees), 2) AS Avg_Accrued_Fees
FROM patron 
GROUP BY ROLLUP(city);
--The rollup does a subtotal based on the city, guillory and west guillory. The average of fees for all cities is $0.76.

--Update previous query to include zip and filter out patrons with 0 accrued_fees, Sarosha sm66825
--13 B
SELECT city, zip, ROUND(AVG(accrued_fees), 2) AS Avg_Accrued_Fees
FROM patron 
WHERE accrued_fees > 0
GROUP BY ROLLUP(city, zip);
--The most problematic fees would be Guillory 73944 and West Guillory 73940 because 73944 is significantly lower than the rest and 73940 is significantly higher than the rest which would skew the data.


--Find which branches have too few or too many copies of titles, Sarosha sm66825
--Problem 14
SELECT l.branch_id, l.branch_name, COUNT(t.title_copy_id) AS Count_of_Title_Copies
FROM location l FULL JOIN title_loc_linking t ON l.branch_id = t.last_location
GROUP BY (l.branch_id, l.branch_name)
HAVING COUNT(t.title_copy_id) < 40 OR COUNT(t.title_copy_id) > 50;


