SELECT TOP (1000) [InvoiceNo]
      ,[StockCode]
      ,[Description]
      ,[Quantity]
      ,[InvoiceDate]
      ,[UnitPrice]
      ,[CustomerID]
      ,[Country]
  FROM [RetailOnline].[dbo].[Online_Retail]

use RetailOnline
go
--- view whole dataset
select *
from Online_Retail

--- cleaning dataset
delete from Online_Retail
where CustomerID is null

delete from Online_Retail
--select *
--from Online_Retail
where 
    Quantity < 0 or
    UnitPrice < 0

--- COHORT ANALYSIS ---
-- create cohort date
select 
    CustomerID,
    min(InvoiceDate) first_order_date,
    DATEFROMPARTS(year(min(InvoiceDate)), month(min(InvoiceDate)), 1) cohort_date
into #cohort_date
from Online_Retail
group by CustomerID

select * from #cohort_date
--- create cohort index
select 
    m.*,
    cohort_index=(order_year-cohort_year)*12 + (order_month-cohort_month) + 1
into #cohort_retention 
from   
    (
    select
        o.*,
        c.cohort_date,
        month(c.cohort_date) cohort_month,
        year(c.cohort_date) cohort_year,
        month(o.InvoiceDate) order_month,
        year(o.InvoiceDate) order_year
    from Online_Retail o
    left join #cohort_date c
        on o.CustomerID=c.CustomerID
    )m

select * from #cohort_retention

--- Cohort retention by customer ---
select
    cohort_date,
    cohort_index,
    count (distinct CustomerID) Count_customer
into #cohort_customer
from #cohort_retention
group by
    cohort_date,
    cohort_index
order by cohort_date

select * from #cohort_customer

--pivot to see table
select *
--into #piv_cohort_customer
from #cohort_customer
pivot
    (
    sum(Count_customer)
    for cohort_index in ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13])
    ) piv_cus

--- Cohort Retention Rate ---
select 
    cohort_date,
    round(1.0 * [1]/[1] *100, 2) as [1],
    round(1.0 * [2]/[1] *100, 2) as [2],
    round(1.0 * [3]/[1] *100, 2) as [3],
    round(1.0 * [4]/[1] *100, 2) as [4],
    round(1.0 * [5]/[1] *100, 2) as [5],
    round(1.0 * [6]/[1] *100, 2) as [6],
    round(1.0 * [7]/[1] *100, 2) as [7],
    round(1.0 * [8]/[1] *100, 2) as [8],
    round(1.0 * [9]/[1] *100, 2) as [9],
    round(1.0 * [10]/[1] *100, 2) as [10],
    round(1.0 * [11]/[1] *100, 2) as [11],
    round(1.0 * [12]/[1] *100, 2) as [12],
    round(1.0 * [13]/[1] *100, 2) as [13]
from #piv_cohort_customer

--- Cohort retention by sales ---
select
    cohort_date,
    cohort_index,
    round(sum(Quantity*UnitPrice), 2) Total_Sales
--into #cohort_sales
from #cohort_retention
group by
    cohort_date,
    cohort_index
order by cohort_date
--pivot to see table
select *
from #cohort_sales
pivot
    (
    sum(Total_Sales)
    for cohort_index in ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13])
    ) piv_sales