# 🛒 Retail Sales Analysis (SQL Project)

## 📌 Project Overview
This project focuses on analyzing a **Retail Sales dataset** using **SQL**.  
The dataset contains transaction-level data, including customer demographics, sales details, and product categories.  
The goal is to clean, explore, and analyze the dataset to derive meaningful business insights.

---

## 📂 Dataset Description
The dataset `retail_sales` contains the following columns:

- `transaction_id` (Primary Key)  
- `sale_date` (Date of transaction)  
- `sale_time` (Time of transaction)  
- `customer_id` (Unique ID for customer)  
- `gender` (Customer gender)  
- `age` (Customer age)  
- `category` (Product category)  
- `quantity` (Number of items purchased)  
- `price_per_unit` (Price per item)  
- `cogs` (Cost of goods sold)  
- `total_sale` (Total sale value)

---

## 🧹 Data Cleaning
- Checked for **NULL values** across all columns.  
- Removed transactions with missing data to ensure data consistency.

```sql
select * from retail_sales
where transaction_id is null
   or sale_date is null
   or sale_time is null
   or customer_id is null
   or gender is null
   or age is null
   or category is null
   or price_per_unit is null
   or cogs is null
   or total_sale is null
   or quantity is null;

delete from retail_sales
where transaction_id is null
   or sale_date is null
   or sale_time is null
   or customer_id is null
   or gender is null
   or age is null
   or category is null
   or price_per_unit is null
   or cogs is null
   or total_sale is null
   or quantity is null;


## 📊 Data Exploration

Total number of sales transactions  
```sql
select count(*) as totl_sales_count from retail_sales;
```

Total number of unique customers  
```sql
select count(distinct customer_id) as no_of_customer from retail_sales;
```

Number of unique categories  
```sql
select count(distinct category) as total_categories from retail_sales;
```

---

## 🔎 Business Questions & SQL Queries

Q1. Retrieve all sales made on 2022-11-05  
```sql
select * from retail_sales
where sale_date = '2022-11-05';
```

Q2. Transactions in Clothing category for November 2022  
```sql
select * from retail_sales
where category = 'Clothing'
  and to_char(sale_date, 'yyyy-mm') = '2022-11';
```

Q3. Total sales for each category  
```sql
select category, sum(total_sale) as net_sale, count(*) as total_orders
from retail_sales
group by category;
```

Q4. Average age of customers who purchased Beauty items  
```sql
select category, avg(age) as avg_age
from retail_sales
group by category
having category = 'Beauty';
```

Q5. Transactions with total sales greater than 1000  
```sql
select * from retail_sales
where total_sale > 1000;
```

Q6. Number of transactions by gender in each category  
```sql
select category, gender, count(transaction_id) as total_transactions
from retail_sales
group by category, gender
order by 1, 2;
```

Q7. Best-selling month in each year (based on average sales)  
```sql
select *
from (
    select to_char(sale_date, 'yyyy') as year,
           to_char(sale_date, 'mm') as month,
           avg(total_sale),
           rank() over(partition by to_char(sale_date,'yyyy')
                       order by avg(total_sale) desc) as rnk
    from retail_sales
    group by to_char(sale_date, 'yyyy'), to_char(sale_date, 'mm')
) as t
where rnk = 1;
```

Q8. Top 5 customers by highest total sales  
```sql
select customer_id, sum(total_sale) as net_sales
from retail_sales
group by customer_id
order by 2 desc
limit 5;
```

Q9. Unique customers per category  
```sql
select category, count(distinct customer_id) as unique_cus
from retail_sales
group by category;
```

Q10. Orders by shift (Morning, Afternoon, Evening)  
```sql
select 
    case
        when extract(hour from sale_time) < 12 then 'Morning'
        when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
        when extract(hour from sale_time) > 17 then 'Evening'
    end as shift,
    count(transaction_id) as no_of_orders
from retail_sales
group by 1;
```

---

## ✅ Key Insights

- Identified **top-performing customers** and **categories**.  
- Discovered **best-selling months** for each year.  
- Analyzed **customer demographics** (age, gender) per category.  
- Segmented sales by **time of day (shifts)**.  

---

## 📌 Conclusion

This project demonstrates how SQL can be used for **data cleaning, exploration, and analysis** in a real-world retail dataset.  
It provides valuable insights into customer behavior, sales trends, and category performance, which can guide **business decision-making**.

