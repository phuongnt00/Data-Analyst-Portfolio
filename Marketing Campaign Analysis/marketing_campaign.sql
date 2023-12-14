create database projects;
use projects;
select * from marketing_campaign;

-- Rename error column
alter table marketing_campaign 
rename column ï»¿ID to ID;
-- check
describe marketing_campaign;

-- A.Customer Segmentation
-- Generation
select 
	min(Year_Birth),
	max(Year_Birth)
from marketing_campaign;

select
	case
		when Year_Birth >= 1928 and Year_Birth < 1946 then 'Greatest Generation'
		when Year_Birth >= 1946 and Year_Birth < 1965 then 'Baby Boomers'
		when Year_Birth >= 1965 and Year_Birth < 1981 then 'Generation X'
		else 'Millennials'
	end as Generation,
    count(*) as Num_customer
from marketing_campaign
group by Generation;
-- Income Range
select
	case 
		when Income < 25000 then 'Under 25K'
		when Income >= 25000 and Income < 50000 then '25K-50K'
		when Income >= 50000 and Income < 75000 then '50K-75K'
		when Income >= 75000 and Income < 100000 then '75K-100K'
    	else 'Over 100K'
	end as Income_Range,
    count(*) as Num_Customer
from marketing_campaign
group by Income_Range;
-- Number of customers by education
select 
	Education,
	count(*) as Num_customer
from marketing_campaign
group by Education;
-- Number of customers by marital status
select
	Marital_Status,
	count(*) as Num_customer
from marketing_campaign
group by Marital_Status;
-- Number of customers by kidhome and Teenhome
select 
	case
		when Kidhome >= 1 and Teenhome >= 1 then 'Both'
		when Kidhome >= 1 then 'Kidhome'
		when Teenhome >= 1 then 'Teenhome'
		else 'None'
	end as HouseholdType,
	count(*) as Num_customer
from marketing_campaign
group by HouseholdType;
-- Average income 
select avg(Income) as AvgIncome
from marketing_campaign;

-- B.Customer Behavior
-- Customer Recency Range
select
   case
      when Recency >= 0 and Recency < 30 then '0-30 days'
      when Recency >= 30 and Recency < 60 then '31-60 days'
      when Recency >= 60 and Recency < 90 then '61-90 days'
      else 'Over 90 days'
   end as Recency_Range,
   avg(Recency) as Avg_Recency
from marketing_campaign
group by Recency_Range;
-- Analysis of product consumption
select 
    avg(MntFishProducts) as Fish,
    avg(MntFruits) as Fruits,
    avg(MntGoldProds) as Gold,
    avg(MntMeatProducts) as Meat,
    avg(MntWines) as Wines,
    avg(MntSweetProducts) as Sweet
from marketing_campaign;
-- Number of purchases by channel
select
    sum(NumCatalogPurchases) as Catalog,
    sum(NumStorePurchases) as Store,
    sum(NumWebPurchases) as Web
from marketing_campaign;
-- Number of purchase with discount by channel
select
    'Web' as Channel,
    sum(NumDealsPurchases) as TotalDealsPurchases
from marketing_campaign
where NumWebPurchases > 0
union
select
    'Catalog' as Channel,
    sum(NumDealsPurchases) as TotalDealsPurchases
from marketing_campaign
where NumCatalogPurchases > 0
union
select
    'Store' as Channel,
    SUM(NumDealsPurchases) as TotalDealsPurchases
from marketing_campaign
where NumStorePurchases > 0;
-- Number of website visits in the month
select 
    NumWebVisitsMonth, 
    COUNT(*) as Count 
from marketing_campaign 
group by NumWebVisitsMonth;

-- C.Campaign Analysis
-- Acceptance rate per campaign
select
   'Campaign 1' as Campaign,
   sum(AcceptedCmp1) as Acceptance_Rate
from marketing_campaign
union
select
   'Campaign 2' as Campaign,
   sum(AcceptedCmp2) as Acceptance_Rate
from marketing_campaign
union
select
   'Campaign 3' as Campaign,
   sum(AcceptedCmp3) as Acceptance_Rate
from marketing_campaign
union
select
   'Campaign 4' as Campaign,
   sum(AcceptedCmp4) as Acceptance_Rate
from marketing_campaign
union
select
   'Campaign 5' as Campaign,
   sum(AcceptedCmp5) as Acceptance_Rate
from marketing_campaign;
-- Number of customer accepted the offer in the last campaign
select count(*) as Count
from marketing_campaign
where Response =1;
-- Relationship between income and acceptance
select
	case 
		when Income < 25000 then 'Under 25K'
		when Income >= 25000 and Income < 50000 then '25K-50K'
    		when Income >= 50000 and Income < 75000 then '50K-75K'
    		when Income >= 75000 and Income < 100000 then '75K-100K'
		else 'Over 100K'
	end as Income_Range,
	sum(AcceptedCmp1) as Campaign1,
	sum(AcceptedCmp2) as Campaign2,
	sum(AcceptedCmp3) as Campaign3,
	sum(AcceptedCmp4) as Campaign4,
	sum(AcceptedCmp5) as Campaign5
from marketing_campaign
group by Income_Range;
-- Customer complained in the last 2 years
select 
    sum(Complain) as TotalComplains,
    count(*) as TotalCustomers,
    sum(Complain) / count(ID) as ComplaintRate
from marketing_campaign;
-- Total revenue after client accepting campaign
select sum(Z_Revenue) as TotalRevenue
from marketing_campaign;
-- Total revenue by Accepted Campaign
select 
	'Campaign 1' as Campaign,
	sum(Z_Revenue) as TotalRevenue
from marketing_campaign
where AcceptedCmp1 = 1
union
select 
	'Campaign 2' as Campaign,
	sum(Z_Revenue) as TotalRevenue
from marketing_campaign
where AcceptedCmp2 = 1
union
select 
	'Campaign 3' as Campaign,
	sum(Z_Revenue) as TotalRevenue
from marketing_campaign
where AcceptedCmp3 = 1
union
select 
	'Campaign 4' as Campaign,
	sum(Z_Revenue) as TotalRevenue
from marketing_campaign
where AcceptedCmp4 = 1
union
select 
	'Campaign 5' as Campaign,
	sum(Z_Revenue) as TotalRevenue
from marketing_campaign
where AcceptedCmp5 = 1;
