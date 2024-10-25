SELECT * FROM portfoliowalmart.walmartsalesdata;
--  Data Cleaning  --
-- TIME OF DAY --
SELECT 
     time,
     (CASE
         WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN 'Morning'
         WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN 'Afternoon'
         ELSE "Evening"
         END) AS Time_of_Day
FROM portfoliowalmart.walmartsalesdata;

UPDATE portfoliowalmart.walmartsalesdata
SET Time_of_Day = (
CASE 
   WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN 'Morning'
         WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN 'Afternoon'
         ELSE "Evening"
         END
         );

SELECT *
FROM portfoliowalmart.walmartsalesdata;


-- day_name --
SELECT
      date,
      DAYNAME(date)
FROM portfoliowalmart.walmartsalesdata;
ALTER TABLE portfoliowalmart.walmartsalesdata ADD COLUMN day_name VARCHAR(10);
UPDATE portfoliowalmart.walmartsalesdata
SET day_name = DAYNAME(date);


-- month_name --
select
      date,
      monthname(date)
FROM portfoliowalmart.walmartsalesdata;
ALTER TABLE portfoliowalmart.walmartsalesdata ADD COLUMN month_name VARCHAR(10);
UPDATE portfoliowalmart.walmartsalesdata
SET month_name = monthname(date);



-- EDA --
-- how many unique cities does the data have? --
SELECT 
     distinct CITY
from portfoliowalmart.walmartsalesdata;

-- In which city is each branch? --
select 
      distinct city,
      branch
from portfoliowalmart.walmartsalesdata;


show columns
from portfoliowalmart.walmartsalesdata;

describe portfoliowalmart.walmartsalesdata;


-- PRODUCTS --
-- How many unique product lines does the data have? --
select 
      distinct `Product line`
from portfoliowalmart.walmartsalesdata;

-- Most common payment method? --
select 
      Payment,
      count(Payment)
from portfoliowalmart.walmartsalesdata
group by Payment;

-- What is the most selling product line? --
select 
      `Product line`,
      count(`Product line`) AS cnt
From portfoliowalmart.walmartsalesdata
Group by `Product line`
Order by cnt DESC;

-- What is the total revenue by month? --
SELECT
     month_name AS Month,
     ROUND(SUM(total), 2) AS total_revenue
FROM portfoliowalmart.walmartsalesdata
Group by month_name
Order by total_revenue DESC;

-- What month has the largest COGS? --
SELECT
     month_name AS month,
     ROUND(sum(cogs), 2) AS cogs
FROM portfoliowalmart.walmartsalesdata
Group by month_name
Order by cogs DESC;

-- What product line had the largest revenue? --
SELECT
	  `Product line`,
     ROUND(SUM(total), 2) AS total_revenue
FROM portfoliowalmart.walmartsalesdata
Group by `Product line`
Order by total_revenue DESC;

-- What city has the highest revenue? --
SELECT
     branch,
     city,
     ROUND(SUM(total), 2) AS total_revenue
FROM portfoliowalmart.walmartsalesdata
Group by city, branch
Order by total_revenue DESC;

-- What product line had the largest VAT? --
SELECT
	 `Product line`,
     ROUND(AVG(`Tax 5%`), 2) AS Avg_tax
FROM portfoliowalmart.walmartsalesdata
Group by `Product line`
Order by Avg_tax DESC;

-- Which branch sold more products than average product sold? --
SELECT 
      branch,
      SUM(Quantity)
FROM portfoliowalmart.walmartsalesdata
Group by branch
having SUM(Quantity) > (SELECT avg(Quantity) FROM portfoliowalmart.walmartsalesdata);
 
 -- What is the most common product line by gender? --
 SELECT 
       gender,
       `Product line`,
       COUNT(gender) AS total_cnt
FROM portfoliowalmart.walmartsalesdata
Group by gender,`Product line`
Order by total_cnt DESC;

-- SALES --
-- Number of sales made in eash time of the day per weekday --
SELECT
     time_of_day,
     COUNT(*) AS total_sales
FROM portfoliowalmart.walmartsalesdata
WHERE day_name = "Sunday"
Group by time_of_day
Order by total_sales DESC;

-- WHich customer type brings the most revenue? --
SELECT 
     `Customer type`,
     ROUND(SUM(total), 2) AS total_revenue
FROM portfoliowalmart.walmartsalesdata
Group by `Customer type`
Order by total_revenue DESC;

-- Which city has the largest tax percent/vat percent? --
SELECT 
      City,
      ROUND(AVG(`Tax 5%`), 2) AS VAT
FROM portfoliowalmart.walmartsalesdata
Group by City
Order by VAT DESC;


-- CUSTOMER --
-- How many unique customer types does the data have? --
SELECT 
distinct `Customer type`
FROM portfoliowalmart.walmartsalesdata;

-- How many unique payment methods does te data have? --
SELECT
      distinct payment
FROM portfoliowalmart.walmartsalesdata;

-- Which customer type buys the most? --
SELECT 
      `Customer type`,
      COUNT(*) AS cstm_cnt
FROM portfoliowalmart.walmartsalesdata
Group by `Customer type`;

-- What is the Gender of most Customers? And branch distribution?  --
SELECT
      gender,
      COUNT(*) AS gender_cnt
FROM portfoliowalmart.walmartsalesdata
WHERE branch = "C"
Group by gender
Order by gender_cnt DESC;

-- what time of the day do customers give the most ratings? PER BRANCH? --
SELECT 
      time_of_day,
      ROUND(AVG(Rating), 2) AS avg_rating
FROM portfoliowalmart.walmartsalesdata
WHERE branch = "A"
Group by time_of_day
Order by avg_rating DESC;
-- Branch A and C are doing well in terms of ratings --

-- Which day of the week has the best avg ratings? --
SELECT
     Day_name,
     ROUND(AVG(Rating), 2) AS avg_rating
FROM portfoliowalmart.walmartsalesdata
Group by day_name
Order by avg_rating DESC;
-- Monday,Friday,Sunday has the best average rating --

-- Which day of the week has the best average rating per branch? --
SELECT
      Day_name,
      ROUND(AVG(Rating), 2) AS avg_rating
FROM portfoliowalmart.walmartsalesdata
WHERE branch = "C"
Group by day_name
Order by avg_rating DESC;

-- Which branch has the highest income? --
SELECT 
      branch,
      ROUND(SUM(`gross income`),2) AS Total_gross_income
FROM portfoliowalmart.walmartsalesdata
Group by branch
Order by total_gross_income DESC;
-- Branch C has the highest income --

-- Which branch has the highest gross margin? --
SELECT 
      branch,
      ROUND(SUM(`gross margin percentage`), 2) AS gross_margin_percent
FROM portfoliowalmart.walmartsalesdata
Group by branch
Order by gross_margin_percent DESC;
-- Branch A has the higest gross margin indicating that it retains much profits --
