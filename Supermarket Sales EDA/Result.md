# Result
<p align="right"> Using Microsoft SQL Server </p>

## B. Product Analysis
* Which product line has the highest sales?
````sql
select top 1 ProductLine, sum(Total) as TotalSales
from project1.dbo.supermarket_sales
group by ProductLine
order by TotalSales desc
````
*Answer:*
|ProductLine|TotalSales|
| ----------| ---------|
|Food and beverages |   56144.844   |

* Which city has the highest sales and product line?
````sql
select top 1 City, ProductLine, sum(Total) as TotalSales
from project1.dbo.supermarket_sales
group by City, ProductLine
order by TotalSales desc
````
*Answer:*

|City|ProductLine|TotalSales|
| ---------| ---------|-----|
|Naypyitaw| Food and beverages|23766.855  |		
	

* Total sale each month in 2019
````sql
select datepart(month, Date) as Month, 
	sum(Total) as TotalSales
from project1.dbo.supermarket_sales
group by datepart(month, Date)
order by Month
````
*Answer:*

|Month|TotalSales|
| --- | ---------|
|1|   116291.868   |
|2 |   97219.374 |
|3 |  109455.507 |

* Products line with the highest sale in each month
````sql
with CTE as
(
	select ProductLine, 
		datepart(month, Date) as Month,
		Total,
		rank() over (partition by datepart(month, Date) order by Total desc) as Rank
	from project1.dbo.supermarket_sales
)
select ProductLine, Month, Total
from CTE
where Rank = 1
order by Month
````
*Answer:*

|ProductLine|Month|Total|
| ---------| -----|-----|
|Food and beverages|1|1034.46|	
|Fashion accessories|2|1042.65|
|Home and lifestyle|3|1022.49|

* Products line with the highest total sales in each category
````sql
with CTE as
(
	select InvoiceID,
		ProductLine,
		Total,
		rank() over(partition by ProductLine order by Total desc) as Rank
	from project1.dbo.supermarket_sales
)
select InvoiceID, ProductLine, Total
from CTE
where Rank = 1;
````
*Answer:*

|InvoiceID|	ProductLine|	Total|
|---------|---------------|---------|
|817-69-8206|	Electronic accessories|	942.4485|
|860-79-0874|	Fashion accessories|	1042.65|
|283-26-5248|	Food and beverages|	1034.46|
|280-17-4359|	Health and beauty|	950.25|
|751-41-9720|	Home and lifestyle|	1023.75|
|554-42-2417|	Sports and travel|	1002.12|

## C. Customer Analysis
* What type of customer usually buys?
````sql
select CustomerType, count(CustomerType) as NumberCustomer
from project1.dbo.supermarket_sales
group by CustomerType
order by NumberCustomer 
````
*Answer:*

|CustomerType|	NumberCustomer|
|---------|---------------|
|Normal|	499|
|Member|	501|

* Daily purchase time analysis
````sql
select datepart(hour, Time) as Purchasehour, 
	count (*) as Purchasecount
from project1.dbo.supermarket_sales
group by datepart(hour, Time)
order by Purchasecount desc
````
*Answer:*

|Purchasehour|	Purchasecount|
|---------|---------------|
|19	|113	|
|13	|103	|
|15	|102	|
|10	|101	|
|18	|93	|
|11	|90	|
|12	|89	|
|14	|83	|
|16	|77	|
|20	|75	|
|17	|74	|

* Number of customers by customer type and gender
````sql
select CustomerType, Gender, count(distinct InvoiceID) as CountCustomer
from project1.dbo.supermarket_sales
group by CustomerType, Gender;
````
*Answer:*

|CustomerType	|Gender	|CountCustomer|
|---------|---------------|---------|
|Member	|Female	|261|
|Normal	|Female	|240|
|Member	|Male	|240|
|Normal	|Male	|259|

## D. Analysis Branch
* Average rating among branchs?
````sql
select Branch,
	avg(Rating) as AvgRating
from project1.dbo.supermarket_sales
group by Branch
order by AvgRating
````
*Answer:*

|Branch	|AvgRating|
|-------|-------|
|B	|6.81807228915663|
|A	|7.02705882352941|
|C	|7.07286585365854|

* Which branch is the busiest?
````sql
select Branch, count(Branch) as CountBranch
from project1.dbo.supermarket_sales
group by Branch
order by CountBranch desc
````
*Answer:*

|Branch	|CountBranch|
|-------|-------|
|A	|340|
|B	|332|
|C	|328|

* Which payment method is used in each branch?
````sql
select Branch, 
    Payment, 
    count(*) as CountPayment
from project1.dbo.supermarket_sales
group by Branch, Payment
order by Branch, CountPayment desc
````
*Answer:*

|Branch	|Payment|CountPayment
|-------|------|---------|
|A	|Ewallet|	126|
|A	|Cash|	110|
|A	|Credit card|	104|
|B	|Ewallet|	113|
|B	|Cash|	110|
|B	|Credit card|	109|
|C	|Cash|	124|
|C	|Ewallet|	106|
|C	|Credit card|	98|

* Sales growth rate
````sql
select Branch, 
	datepart(month, Date) as Month,
	((sum(Total) - lag(sum(Total)) over (partition by Branch order by datepart(month, Date))) / lag(sum(Total))  over (partition by Branch order by datepart(month, Date)))*100 as SalesGrowthRate
from project1.dbo.supermarket_sales
group by Branch,datepart(month, Date)
````
*Answer:*

|Branch	|Month |SalesGrowthRate
|-------|------|---------|
|A	|1	|NULL|
|A	|2	|-22.80442257521|
|A	|3	|26.1184511964713|
|B	|1	|NULL|
|B	|2	|-7.40204209652839|
|B	|3	|0.50276010202222|
|C	|1	|NULL|
|C	|2	|-18.5476880601581|
|C	|3	|12.9469037975047|










