select count(*) 
from co.customers;

select count(*) 
from co.orders;

select count(*) 
from co.order_items;

select count(*) 
from co.products;

select count(*) 
from co.stores;

-- Number of orders per customer 
select c.customer_id, c.full_name, count(*) as num_orders 
from co.orders o
join co.customers c on o.customer_id = c.customer_id
group by c.customer_id, c.full_name
order by count(*) desc;

-- Number of orders per store
select s.store_id, s.store_name, count(*) as num_orders_from_store 
from co.orders o
join co.stores s on o.store_id = s.store_id
group by s.store_name, s.store_id
order by count(*) desc;

-- Number of items per order
select order_id, sum(quantity) from co.order_items
group by order_id
order by sum(quantity) desc;

-- Orders per year 
select trunc(order_datetime, 'year') as year_start, count(*) as orders_per_year
from co.orders
group by trunc(order_datetime, 'year')
order by 1;

-- Orders per month of the year 
select trunc(order_datetime, 'month') as month_start, count(*) as orders_per_month
from co.orders
group by trunc(order_datetime, 'month')
order by 1;

-- Most popular products
select oi.product_id, p.product_name, sum(quantity)
from co.order_items oi
join co.products p on p.product_id = oi.product_id
group by oi.product_id, p.product_name
order by sum(quantity) desc;

-- Total for each order
select oi.order_id, sum((oi.unit_price*oi.quantity)) as order_total
from co.order_items oi
group by order_id
order by sum((oi.unit_price*oi.quantity)) desc;

-- Total for each order with store name
select s.store_name, oi.order_id, sum((oi.unit_price*oi.quantity)) as order_total
from co.order_items oi
join co.orders o on o.order_id = oi.order_id
join co.stores s on o.store_id = s.store_id
group by oi.order_id, s.store_name
order by sum((oi.unit_price*oi.quantity)) desc;

-- Max sale amount from each store
select store_name, max(order_total) as max_order_total from 
(select s.store_name, oi.order_id, sum((oi.unit_price*oi.quantity)) as order_total
from co.order_items oi
join co.orders o on o.order_id = oi.order_id
join co.stores s on o.store_id = s.store_id
group by oi.order_id, s.store_name) x
group by store_name
order by max_order_total desc;

-- Average sale amount from each store 
select store_name, round(avg(order_total), 2) as avg_order_total from 
(select s.store_name, oi.order_id, sum((oi.unit_price*oi.quantity)) as order_total
from co.order_items oi
join co.orders o on o.order_id = oi.order_id
join co.stores s on o.store_id = s.store_id
group by oi.order_id, s.store_name) x
group by store_name
order by avg_order_total desc;

-- Max sale amount from each store using 'with' clause
with x as
(select s.store_name, oi.order_id, sum((oi.unit_price*oi.quantity)) as order_total
from co.order_items oi
join co.orders o on o.order_id = oi.order_id
join co.stores s on o.store_id = s.store_id
group by oi.order_id, s.store_name) ,
y as
(select store_name, max(order_total) as max_order_total 
from x
group by store_name)
select x.*
from x
join y on x.store_name = y.store_name and x.order_total = y.max_order_total
order by max_order_total desc;
