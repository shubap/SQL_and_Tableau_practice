-- COUNTRIES TABLE

-- Number of countries
select count(*) 
from sh.countries;

-- Getting a sense of countries table format
select * 
from sh.countries;

-- Number of regions in countries table
select count(distinct country_region)
from sh.countries;

-- Regions in countries table
select distinct(country_region)
from sh.countries;

-- Sub regions in countries table
select distinct(country_subregion)
from sh.countries;

-- Number of countries per region
select country_region, count(*) as num_countries
from sh.countries
group by country_region;

-- All countries from Americas region
select country_name as Countries_in_Americas_Region 
from sh.countries
where country_region = 'Americas';


-- SALES TABLE

-- Total row count in sales table
select count(*) 
from sh.sales;

-- Getting a sense of sales table
select * 
from sh.sales;

-- Total quantity sold in sales table 
select sum(quantity_sold) as total_quantity_sold
from sh.sales;

-- Total amount sold in sales table
select sum(amount_sold*quantity_sold) as total_sales_amount
from sh.sales;

-- Total amount sold by product id in sales table
select prod_id, sum(amount_sold*quantity_sold) as sales_amount
from sh.sales
group by prod_id
order by sales_amount desc;

-- Total amount and quantity sold by channel_id in sales table
select channel_id, sum(quantity_sold) as total_quantity_sold, sum(amount_sold*quantity_sold) as total_amount_sold
from sh.sales
group by channel_id;

-- Total amount sold by year
select to_char(time_id, 'yyyy') as year, sum(amount_sold*quantity_sold) as total_amount_sold
from sh.sales
group by to_char(time_id, 'yyyy')
order by total_amount_sold desc;

-- Total amount sold by product id in 1998
select prod_id, sum(amount_sold*quantity_sold) as total_amount_sold
from sh.sales
where to_char(time_id, 'yyyy') = '1998'
group by prod_id;

-- Total amount sold between Feb 1998 and Apr 1998
select sum(amount_sold*quantity_sold) as total_amount_sold
from sh.sales
where time_id between '01-feb-1998' and '01-apr-1998';


-- SALES AND PRODUCTS TABLES

-- Total amount sold by product category
select sh.products.prod_category, sum(amount_sold*quantity_sold) as total_amt_sold
from sh.sales
join sh.products 
on sh.sales.prod_id = sh.products.prod_id
group by sh.products.prod_category;

-- Total amount sold by product sub category
select sh.products.prod_subcategory, sum(amount_sold*quantity_sold) as total_amt_sold
from sh.sales
join sh.products 
on sh.sales.prod_id = sh.products.prod_id
group by sh.products.prod_subcategory;

-- Total amount sold by product sub category but only for product category Electronics and Photo
select sh.products.prod_subcategory, sum(amount_sold*quantity_sold) as total_amt_sold
from sh.sales
join sh.products 
on sh.products.prod_id = sh.sales.prod_id
where sh.products.prod_category = 'Electronics' or sh.products.prod_category = 'Photo'
group by sh.products.prod_subcategory;

-- Total amount sold by product name
select sh.products.prod_name as product_name, sum(sh.sales.amount_sold*sh.sales.quantity_sold) as total_amt_sold
from sh.sales
join sh.products 
on sh.products.prod_id = sh.sales.prod_id
group by sh.products.prod_name;
