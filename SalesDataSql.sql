create database if not exists sales_db ; #creating a database with if not exists.
use sales_db;

#Creating a view helps analyse data without altering original tables.
CREATE OR REPLACE VIEW online_sales AS
SELECT
`Order ID` AS order_id,
`Order Date` AS order_date,
Product AS product_id,
Sales AS amount
FROM salesdata;

#This group data by month and year and count unique orders and total revenue in it.
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(amount) AS monthly_revenue,
    COUNT(DISTINCT order_id) AS monthly_order_volume
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

#This show top 3 months by revenue.
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(amount) AS monthly_revenue
FROM online_sales
GROUP BY year, month
ORDER BY monthly_revenue DESC
LIMIT 3;

#This show top 3 years by revenue.
SELECT 
    YEAR(order_date) AS year,
    SUM(amount) AS yearly_revenue
FROM online_sales
GROUP BY year
ORDER BY yearly_revenue DESC
LIMIT 3;

#Top 3 products by revenue.
SELECT 
    product_id,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 3;

#This is not complete data, it only have Jan-2020 and Dec-2019, that's why there are only 2 enteries in top 3 months or years.