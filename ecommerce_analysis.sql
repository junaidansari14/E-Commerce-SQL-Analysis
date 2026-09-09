-- first we want how a data look like ;

select * from customers ;


-- NOW changig the data types and name or columns;

alter table customers add primary key(customer_id);
alter table customers modify column Customer_Gender varchar(25);
alter table customers modify column City varchar(50);
alter table customers rename column City to city;
alter table customers modify column Customer_Segment varchar(25);
alter table customers modify column Membership_Status varchar(25);
alter table customers modify column Customer_Lifetime_Value decimal(8,2);
alter table customers modify column Country varchar(50);

-- check the null values 

select*
from customers
where country is null;

-- check how many country we have using group by;

select 
  country 
from customers
group by Country ;

-- now check all the data from orders ;

select * from orders ;

-- now chaging the data types and names using alter command ;


alter table orders add primary key ﻿(﻿Order_ID);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

alter table orders modify column Customer_ID varchar(25);

alter table orders modify column Order_Date date ;
alter table orders modify column Shipping_Cost int;
alter table orders modify column Shipping_Cost decimal (5,2);
alter table orders modify column Tax_Amount decimal(8,2);
alter table orders modify column Payment_Method varchar(50);
alter table orders modify column Device_Type varchar(25);
alter table orders modify column Traffic_Source varchar(50);
alter table orders modify column Warehouse_Region varchar(50);
alter table orders modify column Delivery_Days int;
alter table orders modify column Order_Status varchar(50);
alter table orders modify column Returned enum('Yes','No');
alter table orders modify column Season varchar(25);
alter table orders modify column Holiday_Season enum('Yes','No');
alter table orders modify column Review_Rating decimal(2,1);
alter table orders modify column Shipping_Method varchar(50);
alter table orders modify column Warehouse_Region varchar(25);
alter table orders modify column Shipping_Method varchar(50);
alter table orders modify column Shipping_Method varchar(50);

-- using safe mode fro changing the date fromat ;


SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;


UPDATE orders
SET Order_Date = STR_TO_DATE(Order_Date, '%m/%d/%Y');

select order_date from orders;

-- check null values from orders;

select order_id
 from orders
   where Returned is null ;
   
-- check date format;
   
select
   order_id,
   order_date
   from orders 
limit 10;

-- now ussing select comand to see the data;

select * from order_items;

-- changing the data types and columns names from order_items;

alter table order_items modify column Product_ID varchar(50);

alter table order_items add column order_item_id int 
auto_increment primary key first;

alter table products add column product_key int 
auto_increment primary key first;

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (﻿Order_ID)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (product_key)
REFERENCES products(product_key);


alter table order_items modify Discount_Amount decimal (8,2);

ALTER TABLE order_items modify column Coupon_Used enum('yes','No');

ALTER TABLE order_items MODIFY column Order_Amount decimal (8,2);

ALTER TABLE order_items modify column Profit_Margin_Percent decimal(6,2);

ALTER TABLE order_items modify column Profit_Amount decimal(6,2);

-- check the null values;

SELECT *
FROM order_items
WHERE product_key IS NULL;


SELECT *
FROM order_items
LIMIT 10;

SELECT COUNT(*) AS missing_product_keys
FROM order_items 
WHERE product_key IS NULL;

-- check the null values ussing joins;

select count(*) as missing_values 
from order_items oi
join orders o 
on oi.﻿Order_ID= o.order_id
where o.order_id is null;


-- see all the data from product;


select * from products;

-- changing the data typees and column name ussing alter ;

ALTER TABLE products modify column Product_ID varchar(50);

ALTER table products modify column Product_Category varchar(50);

ALTER TABLE products modify column Brand varchar(50);

ALTER TABLE products modify column Unit_Price decimal(6,2);


-- check the null values ussing joins;

select count(*) as missing_values 
from products p 
join order_items oi 
on p.product_key = oi.product_key
where oi.product_key is null;


-- 1 basic level queries

-- count all row from all the tables ussing count function;


-- total no of customers 
select count(*) as total_count_customers 
from customers ;

-- total no of order_items 

select count(*) as total_count_order_items
from order_items;

-- total no of orders ;

select count(*) as total_count_orders
from orders;

-- total no of product ;

select count(*)as total_count_products
from products;

-- total revenue

select sum(Order_Amount)  as total_revenue
from orders ;

-- total quantity sold;

select sum(Quantity)     as total_quantity 
from order_items;

-- check duplicates customers_id from customers table ;

select customer_id, count(*)   as duplicate_ids
from customers
group by customer_id
having count(*)>1;

-- check duplicate order_id from orders table 

select order_id,count(*)    as duplicate_ids
from orders
group by order_id
having count(*)>1;

-- check duplicate order_item_id from order_items table ;

select order_item_id,count(*)   as duplicate_ids
from order_items
group by order_item_id
having count(*)>1;

-- check missing values from cusomters tabel;


select count(*)   as missing_values 
from customers 
where customer_id is null;


-- check  broken relationship between customers and orders table 

select count(*)   as unmatched_customers
from orders o 
 left join customers c
on o.customer_id = c.Customer_ID
where c.Customer_ID is null;


-- check broken realationship between product and order_items;

select count(*)    as unmatched_order_item
from products p
left join order_items oi
on p.product_key = oi.product_key
where oi.product_key is null;

select count(*)  as unmatched_product 
from order_items oi
left join products p 
on oi.product_key = p. product_key
where p.product_key is null;

-- joins intermideate level queries 

-- find how many customers have palced which ones orders;
 
select 
  c. customer_id,
  c.Customer_Gender,
  c.Country,
  c. City,
  o.order_id,
  o.Order_Date,
  o.Order_Status
from customers c
inner join orders o
on c.Customer_ID = o.customer_id;

-- find the total revenue generate from each cusotmers ;

select
    c.customer_id,
    c.Customer_Segment,
    count(o.order_id)      as total_orders,
    sum(oi.Order_Amount)   as total_revenue
from customers c  
join orders o
on c.customer_id = o.customer_id
join order_items oi 
on o.order_id = oi.﻿Order_ID
group by 
    c.customer_id,
	c.Customer_Segment
order by total_revenue desc;


-- find the quantity of each product sold and the revenue generated from it ;

select 
     p.Product_ID,
     p.Product_Category,
     p.Brand,
     sum(oi.Quantity)      as total_quantity ,
     sum(oi.Order_Amount)  as total_revenue
from products p 
join order_items oi 
on p.product_key = oi.product_key
group by p.Product_ID,
     p.Product_Category,
     p.Brand
order by total_revenue;


-- find what product category generate max revenue;
select
    p.Product_Category,
    count( distinct oi.﻿Order_ID)     as total_orders,
    sum(oi.Quantity)                 as total_quantity,
    sum(oi.Order_Amount)             as total_revenue
from products p 
join order_items oi
on p.product_key = oi.product_key 
group by p.Product_Category
order by total_revenue desc;

-- find which ones customer purchase which product;

select 
    c.customer_id,
    c.Customer_Segment,
    c.City,
    o.order_id,
    o.Order_Date,
    oi.Quantity,
    oi.Order_Amount,
    p.Product_ID,
    p.Product_Category,
    p.Brand
from customers c
join orders o
on c.customer_id = o.Customer_ID
join order_items oi 
on o.order_id = oi.﻿Order_ID
join products p 
on oi.product_key = p. product_key;

-- find a customers who never palced orders;

select 
  c.customer_id,
  c.City,
  c.Customer_Segment
from customers c
left join orders o
on c.customer_id = o.Customer_ID
where o.Customer_ID is null;

-- find total customers or unique customers 
select count(*) from customers ;
select count(distinct customer_id)    as unique_customers 
from customers;

-- find the products who are in database but not purchased;

select 
  p.Product_ID,
  p.Product_Category,
  p.Brand
from products p 
 left join order_items oi
on p.product_key = oi.product_key
where oi.product_key is null;

-- find how many customers has generate higest revenue;

select 
   c.Customer_Segment,
   count( distinct c.customer_id)   as total_customers,
   count( distinct o.order_id)      as total_orders,
   sum(oi.Order_Amount)             as total_revenue
from customers c
left join orders o 
   on c.customer_id = o.Customer_ID
left join order_items oi
   on o.order_id = oi.﻿order_id
group by c.Customer_Segment
order by total_revenue desc;

-- find which product have sold the most in which country;

select 
   c.Country,
   p.Product_Category,
   sum(oi.Order_Amount) as total_revenue,
   sum(oi.Quantity) as total_quantity
from customers c 
left join orders o 
on c.customer_id = o.Customer_ID
left join order_items oi 
on o.order_id = oi.﻿order_id
left join products p 
on oi.product_key = p.product_key
group by c.Country,p.Product_Category 
order by total_revenue desc;

-- find the top 1  product of every country; 

SELECT Country, Product_Category, total_revenue
FROM (
SELECT
   c.Country,
   p.Product_Category,
   SUM(oi.Order_Amount) AS total_revenue,
   ROW_NUMBER() OVER 
(
   PARTITION BY c.Country
   ORDER BY SUM(oi.Order_Amount) DESC
) AS rn
FROM customers c
LEFT JOIN orders o
 ON c.customer_id = o.Customer_ID
LEFT JOIN order_items oi
 ON o.order_id = oi.order_id
LEFT JOIN products p
 ON oi.product_key = p.product_key
GROUP BY c.Country, p.Product_Category
) as ranked
WHERE rn = 1
ORDER BY total_revenue DESC;

-- find the members who generate more revenue than non members;
select 
  c.Membership_Status,
  count(distinct c.customer_id)                              as total_customers,
  count(distinct o.order_id)                                 as total_orders,
  sum(oi.Order_Amount)                                       as total_revenue,
  round(sum(oi.Order_Amount)/count(distinct o.order_id) , 2) as avg_order_value
from customers c 
left join orders o 
on c.Customer_ID = o.Customer_ID
left join order_items oi
on o.order_id = oi.﻿order_id
group by c.Membership_Status
order by total_revenue desc;

-- find the top 10 customers who generate higest revenue?
select * from orders;
select
  c.customer_id,
  c.Customer_Segment,
  c.Membership_Status,
  count(distinct o.Order_ID)      as  total_orders,
  sum(oi.Quantity)                as  total_quantity,
  sum(oi.Order_Amount)            as  total_revenue
from customers c
left join orders o 
   on c.customer_id=o.Customer_ID
left join order_items oi
   on o.Order_ID = oi.﻿order_id
group by 
   c.customer_id,
   c.Customer_Segment,
   c.Membership_Status
order by total_revenue  desc
limit 10;


desc orders;
desc order_items;

-- find the top five product category based on the total revenue?

select 
    p.Product_Category,
    count(distinct oi.﻿Order_ID)    as total_orders,
    sum(oi.Quantity)               as total_quantity,
    sum(oi.Order_Amount)           as total_revenue
from products  p
left join order_items oi
   on p.product_key = oi.product_key
group by p.Product_Category
order by total_revenue desc
limit 5 ;

-- Find the top 5 product categories based on total profit.

select 
  p.Product_Category,
  sum(oi.Order_Amount)                    as total_revenue,
  sum(oi.Profit_Amount)                   as total_profit,
  avg(oi.Profit_Margin_Percent)           as avg_profit_margin
from products p 
left join order_items oi
   on p.product_key = oi.product_key
group by p.Product_Category
order by total_profit desc
limit 5;


-- Classify customers into three categories based on their total revenue:

select 
  customer_id,
  total_revenue,
  case 
     when total_revenue >= 8000  then 'high value'
     when total_revenue >= 5000  then 'medium value'
     else 'low value' 
     end as customers_value_category 
     from 
(
select 
   c.customer_id,
   sum(oi.Order_Amount)        as total_revenue
from customers c
left join orders o
  on c.customer_id = o.Customer_ID
left join order_items oi 
  on  o.Order_ID = oi.﻿Order_ID
group by c.customer_id 
order by total_revenue desc)
as customer_revenue;

-- rank the customers on the bases of there total revenue?

select 
   customer_id,
   total_revenue,
   rank() over (order by total_revenue desc) as ranking
from 
(
select 
   c.customer_id,
   sum(oi.Order_Amount)        as total_revenue
from customers c
left join orders o
  on c.customer_id = o.Customer_ID
left join order_items oi 
  on  o.Order_ID = oi.﻿Order_ID
group by c.customer_id 
order by total_revenue desc
) as customer_revenue;


-- classify the  customers on the bases of there ranking in to three category ?

select 
  customer_id,
  total_revenue,
  ranking,
  case 
     when ranking <=8000 then 'high value'
     when ranking<=5000 then 'medium value'
     else 'low value'
     end as customer_ranking
     from 
(
select 
   customer_id,
   total_revenue,
   rank() over (order by total_revenue desc) as ranking
from 
(
select 
   c.customer_id,
   sum(oi.Order_Amount)        as total_revenue
from customers c
left join orders o
  on c.customer_id = o.Customer_ID
left join order_items oi 
  on  o.Order_ID = oi.﻿Order_ID
group by c.customer_id 
) as customer_revenue
)as ranked_csutomers;


-- find the top 10 customers based on total revenue use rank , dens_rank , row_no;

select 
customer_id,
Customer_Segment,
total_revenue,
rank () over 
(
partition by Customer_Segment
order by total_revenue desc
)                                                   as ranking,
row_number () over (order by total_revenue desc)    as customer_no,
dense_rank () over (order by total_revenue desc)    as customer_rank
from 
(
select 
  c.customer_id,
  c.Customer_Segment,
  sum(oi.Order_Amount)                 as total_revenue
from customers c
 join orders o 
  on o.Customer_ID = c.customer_id
left join order_items oi
  on o.Order_ID = oi.﻿Order_ID
group by c.customer_id,c.Customer_Segment
) as  customer_revenue
order by total_revenue desc
limit 10;

-- find the higest revenue customers from each customer segment;


select 
customer_id ,
Customer_Segment,
total_revenue,
customer_rank
from  
(
select 
c.customer_id,
c.Customer_Segment,
sum(oi.Order_Amount)                                                                 as total_revenue,
rank () over (partition by c.Customer_Segment order by sum(oi.Order_Amount)desc)     AS customer_rank
from customers c
 left join orders o 
   on c.customer_id  = o.customer_id
 left join order_items oi
   on o.order_id = oi.order_id
 group by
    c.customer_id,
    c.Customer_Segment
) as ranked_customers
where customer_rank =1
order by total_revenue desc;


 alter table order_items rename column ﻿Order_ID to order_id;

-- calculate monthly revenue;
select 
  year(o.Order_Date)                            as years  ,
  month(o.Order_Date)                           as months,
  sum(oi.Order_Amount)                          as total_revenue
from orders o 
left join order_items oi
  on o.Order_ID = oi.order_id
group by  
       year(o.Order_Date),
	   month(o.Order_Date)
order by 
      years,
	  months;

----------------------------------------------------------------------------
select 
    years,
    months,
    total_revenue,
    lag(total_revenue) over
    (
    order by years,months 
    ) as previous_month_revenue
from 
(
select 
  year(o.Order_Date)                            as years  ,
  month(o.Order_Date)                           as months,
  sum(oi.Order_Amount)                          as total_revenue
from orders o 
left join order_items oi
  on o.Order_ID = oi.order_id
group by  
       year(o.Order_Date),
	   month(o.Order_Date)
order by 
      years,
	  months)as revenue;
------------------------------------------------------------------------------
select 
  years,
  months,
  total_revenue,
  preveious_month_revenue,
  preveious_month_revenue - total_revenue as revenue_change
  from 
(
select 
    years,
    months,
    total_revenue,
    lag(total_revenue) over
    (
    order by years,months 
    ) as preveious_month_revenue
from 
(
select 
  year(o.Order_Date)                            as years  ,
  month(o.Order_Date)                           as months,
  sum(oi.Order_Amount)                          as total_revenue
from orders o 
left join order_items oi
  on o.Order_ID = oi.order_id
group by  
       year(o.Order_Date),
	   month(o.Order_Date)
order by 
      years,
	  months
      )as monthly_revenue
      )as revenue_comparision;
-- calculate the each month show the current month revenue and next month revenue lead();

select 
  years,
  months,
  total_revenue,
  next_month_revenue,
  total_revenue - next_month_revenue as revenue_change
  from 
(
select 
    years,
    months,
    total_revenue,
    lead(total_revenue) over
    (
    order by years,months 
    ) as next_month_revenue
from 
(
select 
  year(o.Order_Date)                            as years  ,
  month(o.Order_Date)                           as months,
  sum(oi.Order_Amount)                          as total_revenue
from orders o 
left join order_items oi
  on o.Order_ID = oi.order_id
group by  
       year(o.Order_Date),
	   month(o.Order_Date)
order by 
      years,
	  months
      )as monthly_revenue
      )as revenue_comparision;

-- find the top five customers based on the total_revenue?
alter table customers rename column customer_id to Customer_ID;

with cte as 
(
select 
   c.Customer_ID,
   sum(oi.Order_Amount)                   as total_revenue
from customers c 
 join orders o 
  on c.Customer_ID = o.Customer_ID
 join order_items oi
 on o.Order_ID = oi.order_id
group by c.Customer_ID
)

select 
   Customer_ID,
   total_revenue
from cte
order by total_revenue desc
limit 5;
 
-- find the top three customers on the bases of total revenue??
with cte as 
(

select
  c.Customer_ID,
  c.Customer_Segment,
  sum(oi.Order_Amount)                           as total_revenue
from customers c
left join orders o
  on c.Customer_ID = o.Customer_ID
LEFT JOIN order_items oi
  on o.Order_ID = oi.order_id
group by 
  c.Customer_ID,
  c.Customer_Segment
) 
,
 customer_revenue as 
(
select
 Customer_ID,
 Customer_Segment,
 total_revenue,
row_number() over (partition by Customer_Segment order by total_revenue desc)   as ranked
from cte
) 
select 
Customer_ID,
Customer_Segment,
total_revenue,
ranked
from customer_revenue
where ranked <= 3
order by 
  Customer_Segment,
  ranked;
