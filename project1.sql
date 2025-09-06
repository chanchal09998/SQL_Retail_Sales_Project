-- sql retail_sales analysis

create table retail_sales
(
transaction_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(15),
quantity int,
price_per_unit float,
cogs float,
total_sale float
)
select * from retail_sales

--data cleaning

select * from retail_sales
where transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null
or
quantity is null



delete from retail_sales
where transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null
or
quantity is null

-- data exploration --------

-- how many sales we have
select count(*) as totl_sales_count from retail_sales

-- how many unique customers we have
select count(distinct customer_id) as no_of_customer from retail_sales

-- how many unique customers we have
select count(distinct category) as no_of_customer from retail_sales

-------- data anlaysis & business key problems & answers --------

--Q.1 write a sql query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales
where sale_date ='2022-11-05'

--Q.2 Write a query to retrieve all transactions where the category is clothing in the month of November 2022.
select * from retail_sales
where category='Clothing'
and
to_char(sale_date,'yyyy-mm')='2022-11'

--Q.3 Write a sql query to calculate the total sales for each category
select category,sum(total_sale)as net_sale,count(*)as total_orders from retail_sales
group by category

--Q.4 ryder sql query to find the average age of customer who purchased items from the beauty category.
select category,avg(age)as avg_age from retail_sales
group by category
having category='Beauty'

--Q.5 Write a sql query to find all transactions where the total sale is greater than 1000.
select * from retail_sales
where total_sale >1000

-- Q.6 Writer Sql query to find the total number of transactions made by each gender in each category.
select category,gender,count(transaction_id)as total_transactions from retail_sales
group by category,gender
order by 1,2

-- Q.7 Write a sql query to calculate the average sale for each month find out best selling month in each year.
select *  from( 
	select
	to_char(sale_date,'yyyy')as year,
	to_char(sale_date,'mm') as month,
	avg(total_sale),
	rank() over(partition by to_char(sale_date,'yyyy') order by avg(total_sale) desc ) as rnk
	from retail_sales
	group by to_char(sale_date,'yyyy'),to_char(sale_date,'mm')
	) as t
where rnk=1

--Q.8 Write a sql query to find the top 5 customers based on the highest total sales.
select customer_id,sum(total_sale) as net_sales from retail_sales
group by customer_id
order by 2 desc 
limit 5

--Q.9 Write a sql query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id)as unique_cus from retail_sales
group by 1

--Q.10 Write a sql query to create each shift and number of orders (example morning<=12 ,afternoon btw 12 and 17, evening>17).
select 
    case
        when extract(hour from sale_time) < 12 then 'Morning'
        when extract(hour from sale_time)  between 12 and 17 then 'Afternoon'
		when extract(hour from sale_time) > 17 then 'Evening'
		end as shift,
    count(transaction_id) as no_of_orders
from retail_sales
group by 1;

 
-- end of project1
