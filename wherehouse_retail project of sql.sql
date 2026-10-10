create database Retail_Warehouse ;

use Retail_Warehouse ;


create table orders(
order_id int primary key,
customer_id int,
store_id int ,
order_date date ,
promotion_id int);

create table order_item(
order_item_id int primary key,
order_id int,
product_id int,
qty int,
price int
);

create table payment(
payment_id int primary key,
order_id int,	
amount int
);
create table product (
product_id int primary key,
category_id int,
supplier_id int,
price int);

create table promotion(
promotion_id	int primary key,
discount int);

create table retrun (
return_id	int primary key,
order_item_id int,
refund int);

create table shipements(shipment_id int primary key,
order_id int,
status varchar(50));

create table stores(
store_id	int primary key,
city varchar(50));

create table supplier(supplier_id int primary key,
country varchar(40));

create table categories(
category_id int primary key,
category_name varchar(40));

create table customres(customer_id	int primary key,
city varchar(50));


-- import data into table with import wizerd;
select * from customres;

-- Q1 find toatal no of customers;
select count(*) from customres;

-- Q2 Find all Unique Customer Location;
select distinct city from customres;

-- Q3 Find Products above 100 Price,
select product_id ,price from product where price >100;

-- Q4 Display 10 most Expansive products;
select product_id ,price from product 
order by price desc limit 10;

-- Q5  Find the total number of orders;
select count(order_id) as total_orders from orders;

-- Q6 Calculate Total Sales;
select sum(qty*price)  as total_sales from order_item;

-- Q7 find avarage order value;
select avg(order_id) from orders;

-- Q8 find total sales by product;
select product_id ,sum(qty*price) as total_sals from order_item
group by product_id order by total_sals desc  ;

-- Q9 Find order with sales greater than 10000;
select sum(qty*price) ,order_id 
from order_item group by order_id 
having sum(qty*price)>10000;

-- Q10 Show Customer with their order ;
select c.customer_id ,o.order_id ,o.order_date
from customres c
join orders o on c.customer_id=o.customer_id;

-- Q11 show product with their category ;
select p.product_id, c.category_name from product p join  categories c
on p.category_id=c.category_id;

-- Q12 Find the top 10 best slling product;
select p.product_id , sum(oi.qty) as Unite_sold from product p join order_item oi 
on p.product_id=oi.product_id group by  product_id
order by Unite_sold   desc limit 10;

-- Q13 find customer who placed more than 1 order;
select customer_id,count(order_id) from orders group by customer_id  
  having  count(customer_id)>1;
  
  -- Q14 calculate mothly sales;
  select year(order_date) as sales_year,
  month(order_date) as sales_month  from orders group by year (order_date)
  , month(order_date) order by sales_year ,sales_month;
  
 -- Q15 findng the highst spending customer
  select customer_id , sum(order_id) as total_orders from orders 
  group by customer_id order by total_orders desc limit 5;
  
  -- Q16 find product whose sales are above average;
  select product_id , sum(qty*price) as product_sales from order_item group by product_id
  having sum(qty*price)>
 ( select avg(product_sales) from (select product_id , sum(qty*price) as product_sales from order_item group by product_id) as sales);
  
  

-- Q17 find repeated customers;
select  customer_id ,count(order_id) as total_orders from orders group by customer_id 
having count(order_id) >1;

-- Q18 find the top three product in each category ;
select p.category_id,o.product_id , sum(o.qty*o.price) as total_sales from order_item o join product p on 
o.product_id=p.product_id group by product_id order by total_sales desc limit 3;

-- Q19  find the second highest order value;
select max(order_id) from orders where order_id<(select  max(order_id) from orders); 

-- Q20 calculate each product percentage contribut to total_sales;\
select product_id , sum(qty*price)/100  as total_sales from order_item group by product_id order by total_sales ;



