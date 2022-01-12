select count(*) 
from sh.customers;

select cust_first_name, cust_last_name, count(*) 
from sh.customers c
group by cust_first_name, cust_last_name;

select cust_city, count(*)
from sh.customers
group by cust_city;

select count(distinct(cust_city))
from sh.customers;

select(count(distinct(cust_state_province)))
from sh.customers;

select count(distinct(cust_state_province))
from sh.customers
where cust_state_province like 'England%';

select cust_state_province, count(*)
from sh.customers
where cust_state_province like 'England%'
group by cust_state_province
order by 2 desc;

select c.cust_state_province, sum(s.amount_sold*s.quantity_sold) as total_amt
from sh.customers c
join sh.sales s
on c.cust_id = s.cust_id
where cust_state_province like 'England%'
group by cust_state_province
order by 2 desc;
