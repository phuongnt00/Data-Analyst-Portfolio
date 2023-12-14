
--A. Product Analysis
--1.Which product line has the highest sales?
select top 1    
    Product_line, 
    sum(Total) TotalSales
from project1.dbo.supermarket_sales
group by Product_line
order by TotalSales desc

--2.Which city has the highest sales and product line?
select top 1 
    City,   
    Product_line,   
    sum(Total) TotalSales
from project1.dbo.supermarket_sales
group by City, Product_line
order by TotalSales desc

--3.Total sale each month in 2019
select 
    datepart(month, Date) as Month, 
	sum(Total) as TotalSales
from project1.dbo.supermarket_sales
group by datepart(month, Date)
order by Month

--4.Products line with the highest sale in each month
with rank_pro as
    (
	select 
        Product_line, 
		datepart(month, Date) as Month,
		Total,
		rank() over (partition by datepart(month, Date) order by Total desc) as Rank
	from project1.dbo.supermarket_sales
    )
select 
    Product_line, 
    Month, 
    Total
from rank_pro
where Rank = 1
order by Month

--5.Products line with the highest total sales in each category.
with sale_pro as
(
    select 
        Invoice_ID,
        Product_line,
        Total,
		rank() over(partition by Product_line order by Total desc) as Rank
	from project1.dbo.supermarket_sales
)
select 
    Invoice_ID, 
    Product_line, 
    Total
from sale_pro
where Rank = 1;

--B.Customer Analysis
--1.What type of customer usually buys?
select 
    Customer_type, 
    count(Customer_type) NumberCustomer
from project1.dbo.supermarket_sales
group by Customer_type
order by NumberCustomer 

--2.Daily purchase time analysis
select 
    datepart(hour, Time) Purchasehour, 
    count (*) Purchasecount
from project1.dbo.supermarket_sales
group by datepart(hour, Time)
order by Purchasecount desc

--3.Number of customers by customer type and gender
select 
    Customer_type, 
    Gender, 
    count(distinct Invoice_ID) CountCustomer
from project1.dbo.supermarket_sales
group by 
    Customer_type, 
    Gender;

-- C.Analysis Branch
--1.Average rating among branchs?
select 
    Branch,
    round(avg(Rating), 2) as AvgRating
from project1.dbo.supermarket_sales
group by Branch
order by AvgRating

--2.Which brand is the most busy?
select 
    Branch, 
    count(Branch) as CountBranch
from project1.dbo.supermarket_sales
group by Branch
order by CountBranch desc

--3.Which payment method is used in each branch?
select 
    Branch, 
    Payment, 
    count(*) as CountPayment
from project1.dbo.supermarket_sales
group by Branch, Payment
order by Branch, CountPayment desc

--4.Sales growth rate
select
    Branch,
    Month,
    round(((MonthlyTotal - PreviousMonthTotal) / PreviousMonthTotal) * 100, 2)  SalesGrowthRate
from
    (
--- total previous month
    select
        *,
        lag(MonthlyTotal) over (PARTITION BY Branch order by Month) PreviousMonthTotal
    from
        (
--- total month
        select
            Branch, 
            DATEPART(month, Date) Month,
            sum(Total) MonthlyTotal
        from project1.dbo.supermarket_sales
        group by
            Branch, 
            DATEPART(month, Date)
        ) total_month
    ) total_prev_month