-- Creating Database 
CREATE DATABASE oyo_sales;

-- USE the database 
USE oyo_sales;

-- Importing data inside MySql
-- 1. Right click on tables present within schemas 
-- 2. Select table data import wizard 
-- 3. Browse through file and select required file.
-- 4. Click Next --> Until you see finish option -->  click to finish

-- Lets show the data 
SELECT * FROM oyo_sales;
SELECT * FROM oyo_city;

-- Data Understanding
DESCRIBE oyo_sales; -- we need to change data type of check_in, check_out and date_of_booking
DESCRIBE oyo_city; -- no changes required

-- Update :- oyo_sales --> "ï»¿booking_id"--> change the name --> this will be our primary key

-- Check for null and duplicate values
SELECT * FROM oyo_sales
WHERE "ï»¿booking_id" IS NULL; --  --> no null values are present

-- Check for duplicates --> Not Present
SELECT COUNT(ï»¿booking_id), ï»¿booking_id FROM oyo_sales
GROUP BY ï»¿booking_id
HAVING  COUNT(ï»¿booking_id)> 1;

-- Data Cleaning

-- Renaming of the data
ALTER TABLE oyo_sales 
RENAME COLUMN ï»¿booking_id TO Booking_id;

-- Renaming of the data
ALTER TABLE oyo_city 
RENAME COLUMN ï»¿hotel_id TO hotel_id;

-- Format Correction 
SET SQL_SAFE_UPDATES = 0;

-- COLUMN - CHECK_IN
SELECT check_in FROM oyo_sales;

-- Updating data inside check_in correctly
UPDATE oyo_sales
SET check_in = str_to_date(check_in,"%d-%m-%Y");

-- Update data type 
ALTER TABLE oyo_sales 
MODIFY COLUMN check_in DATE;

-- Column check_out 
SELECT check_out FROM oyo_sales;

-- Updating data inside check_in correctly
UPDATE oyo_sales
SET check_out = str_to_date(check_out,"%d-%m-%Y"); -- this format should be according to the data

-- Update data type 
ALTER TABLE oyo_sales 
MODIFY COLUMN check_out DATE;

-- COLUMN - date of booking 
SELECT date_of_booking FROM oyo_sales;

-- Updating data inside check_in correctly
UPDATE oyo_sales
SET date_of_booking = str_to_date(date_of_booking,"%d-%m-%Y");

-- Update data type 
ALTER TABLE oyo_sales 
MODIFY COLUMN date_of_booking DATE;

SELECT * FROM oyo_city;
SELECT * FROM oyo_sales;

-- Fact table is sales and dimension table is city but relation between sales to city is many to ne 
ALTER TABLE oyo_city
ADD CONSTRAINT PRIMARY KEY (hotel_id);

ALTER TABLE oyo_sales
ADD CONSTRAINT PRIMARY KEY (booking_id);

ALTER TABLE oyo_sales
ADD CONSTRAINT FOREIGN KEY(hotel_id)
REFERENCES oyo_city(hotel_id);
-- ==============================================================================================================================

-- Data Analysis:- 

-- KPI's:- Key Performance Indicators
/* Create a view for KPIs of oyo sales.
Sales View:- Number of customers | Max(sales) | Min (sales) | Max(discount) | Min(discount) | Total no of rooms | AVG(sales) | AVg(discount)

Date view: - Min(check_in) | Max(check in) | Max(check out) | Min(check out) | Min(date_of_bboking) | Max(date_of_booking) |
*/

-- Sales View
CREATE VIEW Sales_view AS
    SELECT 
        COUNT(*) AS 'Number_of_customers',
        MAX(amount) AS 'Maximum_sales',
        MIN(amount) AS 'Minimum Sales',
        MAX(discount) AS 'Maximum_discount',
        MIN(discount) AS 'Minimum_discount',
        SUM(no_of_rooms) AS 'Total_number_of_rooms',
        AVG(amount) AS 'Average_Sales',
        AVG(discount) AS 'Average_Discount'
    FROM
        oyo_sales;
	
SELECT * FROM sales_view;

-- Date View
CREATE VIEW date_view AS
    SELECT 
        MIN(check_in) AS 'Earliest Check_in_Date',
        MAX(check_in) AS 'Latest Check_in_Date',
        MIN(check_out) AS 'Earliest Check_out_Date',
        MAX(check_out) AS 'Latest Check_outDate',
        MIN(date_of_booking) AS 'Earliest date_of_booking',
        MAX(date_of_booking) AS 'Latest date_of_booking'
    FROM
        oyo_sales;
        
SELECT * FROM date_view;

-- Month Wise Sales
-- Status --> Stayed, Month Name, Actual_sales = amount - discount

SELECT monthname(check_in) AS "Month_of_Stay",
SUM(amount - discount) AS "Actual_Sales" 
FROM oyo_sales
WHERE status = "Stayed"
GROUP BY monthname(check_in)
ORDER BY SUM(amount - discount) DESC;   

-- MAXIMUM DISCOUNT MONTH 
 SELECT monthname(check_in) AS "Month_of_Stay",
SUM(discount) AS "Total_Discount" 
FROM oyo_sales
WHERE status = "Stayed"
GROUP BY monthname(check_in)
ORDER BY SUM(discount) DESC; 

-- 1.Cancellation Rate CR = (cancelled / total rooms) * 100
SELECT monthname(check_in), (SUM(status = "Cancelled")/COUNT(*)) * 100 AS "Cancellation_Rate"
FROM oyo_sales
GROUP BY monthname(check_in);

-- 2.BOOKING RATE Rate BR = (Booked / total rooms) * 100
SELECT c.city, (SUM(s.status = "Stayed")/COUNT(*)) * 100 AS "Average_Booking_Rate"
FROM oyo_sales s
JOIN oyo_city c
ON s.hotel_id = c.hotel_id
GROUP BY city
ORDER BY Average_Booking_Rate;

-- 3.Total Number of Hotels in Each City
SELECT city, COUNT(hotel_id) AS "No_of_Hotels"
FROM oyo_city
GROUP BY city
ORDER BY COUNT(hotel_id);

-- Most Loyal Customer
SELECT  c.city,COUNT(s.customer_id) AS "No_of_Stays", SUM(s.amount - s.discount) AS "Amount_Paid"
FROM oyo_city c 
JOIN oyo_sales s
ON s.hotel_id = c.hotel_id
WHERE s.status = "Stayed"
GROUP BY city;

-- 5. Most Frequent No of Rooms Booked
SELECT no_of_rooms, COUNT(*) AS "Frequency"
FROM oyo_sales
GROUP BY no_of_rooms
ORDER BY no_of_rooms;

-- 6. Average Cost Per room for each city
SELECT c.city, SUM(s.amount)/COUNT(*) AS "Average_Cost_Per_room"
FROM oyo_sales s
JOIN oyo_city c 
ON s.hotel_id = c.hotel_id
GROUP BY city
ORDER BY Average_Cost_Per_room;


SELECT * FROM oyo_city;
SELECT * FROM oyo_sales;