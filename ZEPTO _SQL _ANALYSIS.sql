create database Zepto_SQl_Project;

use  Zepto_SQl_Project;

create table zepto (
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);
select*from zepto;

## data exploration

## count of rows
select count(*) from zepto;

## sample data
SELECT * FROM zepto
LIMIT 10;

## null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

## different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

## how many products are out of stock
select count(*) from zepto where outofstock=True;

## data cleaning

##  products with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0;

##  convert paise to rupees
UPDATE zepto
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT mrp, discountedSellingPrice FROM zepto;

## data analysis

# Q1. Which products have the highest MRP and represent the premium segment of the catalog?

select name , category,mrp from zepto order by mrp desc limit 10;

# Q2. Which products are receiving the highest discounts on the platform?

select name , category, discountpercent from zepto order by discountpercent desc limit 10;

# Q3. Which categories offer the highest average discounts to customers?

select category,round(avg(discountpercent),2) as avg_discount from zepto group by category order by avg_discount desc;

# Q4. Which categories have the largest number of out-of-stock products?

select category, count(*) as out_of_stock_products from zepto where outofstock =true group by category order by out_of_stock_products desc;

# Q5. Which product categories contain the highest number of products?

select category,count(*) as total_products from zepto group by category order by total_products desc;

# Q6. Which categories currently hold the highest inventory levels?

select category,sum(availablequantity)as total_inventory from zepto group by category order  by total_inventory desc;

# Q7. Which categories contribute the highest inventory value to the business?

select category,sum(discountedsellingprice*availablequantity) as inventory_value from zepto group by category order by inventory_value desc;

# Q8. Which products provide the greatest savings to customers after discounts?

select name,category,mrp,discountedsellingprice,(mrp-discountedsellingprice)as savings from zepto order by savings desc limit 10;

# Q9.Which categories have the highest average product prices?

select category,round(avg(mrp),2)As avg_mrp from zepto group by category order by avg_mrp desc;

# 10. How many products are currently sold without any discount?

select count(*) AS no_discount_products from zepto where discountpercent=0;
