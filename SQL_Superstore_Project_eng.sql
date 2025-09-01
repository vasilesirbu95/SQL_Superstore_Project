-- =========================================================
-- SUPERSTORE SQL PROJECT
-- Data Cleaning + KPIs + Analysis
-- =========================================================

-- ========================
-- 1. DATA CLEANING
-- ========================

-- Drop the table if it already exists
DROP TABLE IF EXISTS superstore_data;

-- Create a new table with the same structure as the original dataset
CREATE TABLE superstore_data
LIKE `us superstore data`;

-- Insert the data into the new table
INSERT superstore_data
SELECT * 
FROM `us superstore data`;

-- Remove columns Country and Sub-Category from the table
ALTER TABLE superstore_data
DROP COLUMN Country,
DROP COLUMN `Sub-Category`;

-- Check for duplicates
WITH duplicate_cte AS (
    SELECT *, 
    ROW_NUMBER() OVER(
        PARTITION BY `Order ID`, `Customer ID`, `Product ID`, `Postal Code`, `Order Date`, `Ship Date`, `Sales`, `Quantity`
    ) AS row_num
    FROM superstore_data
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

-- Check for NULL or empty values
SELECT *
FROM superstore_data
WHERE 
`Row ID` IS NULL OR `Row ID` = ''
OR `Order ID` IS NULL OR `Order ID` = ''
OR `Order Date` IS NULL OR `Order Date` = ''
OR `Ship Date` IS NULL OR `Ship Date` = ''
OR `Customer ID` IS NULL OR `Customer ID` = ''
OR `Customer Name` IS NULL OR `Customer Name` = ''
OR `Segment` IS NULL OR `Segment` = ''
OR `City` IS NULL OR `City` = ''
OR `State` IS NULL OR `State` = ''
OR `Postal Code` IS NULL OR `Postal Code` = ''
OR `Region` IS NULL OR `Region` = ''
OR `Product ID` IS NULL OR `Product ID` = ''
OR `Category` IS NULL OR `Category` = ''
OR `Product Name` IS NULL OR `Product Name` = ''
OR Sales IS NULL OR Sales = ''
OR Quantity IS NULL OR Quantity = ''
OR Discount IS NULL OR Discount = ''
OR Profit IS NULL OR Profit = '';

-- Convert Order Date from text to DATE
UPDATE superstore_data
SET `Order Date` = STR_TO_DATE(`Order Date`,  '%d.%m.%Y');

ALTER TABLE superstore_data
MODIFY COLUMN `Order Date` DATE;

-- Convert Ship Date from text to DATE
UPDATE superstore_data
SET `Ship Date` = STR_TO_DATE(`Ship Date`,  '%d.%m.%Y');

ALTER TABLE superstore_data
MODIFY COLUMN `Ship Date` DATE;

-- Convert Sales from text to DOUBLE
UPDATE superstore_data
SET Sales = CAST(REPLACE(Sales, ',', '.') AS DOUBLE PRECISION);

ALTER TABLE superstore_data
MODIFY COLUMN Sales DOUBLE;

-- Convert Discount from text to DOUBLE
UPDATE superstore_data
SET Discount = CAST(REPLACE(Discount, ',', '.') AS DOUBLE PRECISION);

ALTER TABLE superstore_data
MODIFY COLUMN Discount DOUBLE;

-- Convert Profit from text to DOUBLE
UPDATE superstore_data
SET Profit = CAST(REPLACE(Profit, ',', '.') AS DOUBLE PRECISION);

ALTER TABLE superstore_data
MODIFY COLUMN Profit DOUBLE;

-- Show the dataset after data cleaning
SELECT *
FROM superstore_data;


-- ========================
-- 2. KPI QUERIES
-- ========================

-- Total Sales and Profit
SELECT 
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore_data;

-- Sales by City
SELECT City, ROUND(SUM(Sales), 2) AS Sales
FROM superstore_data
GROUP BY City
ORDER BY Sales DESC;

-- Sales by State
SELECT State, ROUND(SUM(Sales), 2) AS Sales
FROM superstore_data
GROUP BY State
ORDER BY Sales DESC;

-- Sales by Region
SELECT Region, ROUND(SUM(Sales), 2) AS Sales
FROM superstore_data
GROUP BY Region
ORDER BY Sales DESC;

-- Sales by Segment
SELECT Segment, ROUND(SUM(Sales), 2) AS Sales
FROM superstore_data
GROUP BY Segment
ORDER BY Sales DESC;

-- Top 10 Products by Sales
SELECT `Product Name`, ROUND(SUM(Sales), 2) AS Sales
FROM superstore_data
GROUP BY `Product Name`
ORDER BY Sales DESC
LIMIT 10;

-- Top 10 Customers by Sales
SELECT 
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS Sales,
    RANK() OVER(ORDER BY SUM(Sales) DESC) AS customer_sales_rank
FROM superstore_data
GROUP BY `Customer Name`
ORDER BY Sales DESC
LIMIT 10;

-- Average Profit per Category
SELECT Category, ROUND(AVG(Profit), 2) AS Avg_Profit
FROM superstore_data
GROUP BY Category
ORDER BY Avg_Profit DESC;

-- Total Sales + Share in %
SELECT 
    Category,
    ROUND(SUM(Sales), 2) AS Sales,
    ROUND(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER(), 2) AS Percent_of_Total
FROM superstore_data
GROUP BY Category
ORDER BY Sales DESC;

-- Yearly Sales including Year-over-Year Growth
WITH yearly_sales AS (
    SELECT 
        YEAR(`Order Date`) AS year,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM superstore_data
    GROUP BY YEAR(`Order Date`)
)
SELECT 
    year,
    total_sales,
    LAG(total_sales) OVER (ORDER BY year) AS prev_year_sales,
    ROUND(
        ((total_sales - LAG(total_sales) OVER (ORDER BY year)) / 
         NULLIF(LAG(total_sales) OVER (ORDER BY year), 0)) * 100, 2
    ) AS yoy_growth_percent
FROM yearly_sales;


-- ========================
-- 3. ANALYSIS QUERIES
-- ========================

-- Average Processing Time (in days) across all orders
SELECT 
    ROUND(AVG(DATEDIFF(`Ship Date`, `Order Date`)),2) AS Avg_Processing_Days
FROM superstore_data;

-- Average Processing Time by Ship Mode
SELECT 
    `Ship Mode`,
    ROUND(AVG(DATEDIFF(`Ship Date`, `Order Date`)),2) AS Avg_Processing_Days
FROM superstore_data
GROUP BY `Ship Mode`
ORDER BY Avg_Processing_Days;

-- Sales Volume by Discount
SELECT Discount,
       SUM(Quantity) AS Total_Quantity,
       RANK() OVER(ORDER BY SUM(Quantity) DESC) AS Rank_By_Quantity
FROM superstore_data
GROUP BY Discount
ORDER BY Total_Quantity DESC;

-- Sales by Discount
SELECT Discount,
       ROUND(SUM(Sales), 2) AS Total_Sales,
       RANK() OVER(ORDER BY SUM(Sales) DESC) AS Rank_By_Sales
FROM superstore_data
GROUP BY Discount
ORDER BY Total_Sales DESC;

-- Profit by Discount
SELECT Discount,
       ROUND(SUM(Profit), 2) AS Total_Profit,
       RANK() OVER(ORDER BY SUM(Profit) DESC) AS Rank_By_Profit
FROM superstore_data
GROUP BY Discount
ORDER BY Total_Profit DESC;

-- Average discount per category
SELECT ROUND(AVG(Discount), 2) AS avg_disc,
       Category,
       RANK() OVER(ORDER BY ROUND(AVG(Discount), 2) DESC) AS Categ_By_Profit
FROM superstore_data
GROUP BY Category
ORDER BY avg_disc DESC;
