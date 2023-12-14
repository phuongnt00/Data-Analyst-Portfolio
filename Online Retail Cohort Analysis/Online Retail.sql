SELECT TOP (1000) [InvoiceNo]
      ,[StockCode]
      ,[Description]
      ,[Quantity]
      ,[InvoiceDate]
      ,[UnitPrice]
      ,[CustomerID]
      ,[Country]
  FROM [RetailOnline].[dbo].[Online_Retail]

USE RetailOnline
GO
--- view whole dataset
SELECT *
FROM Online_Retail

--- cleaning dataset
DELETE FROM Online_Retail
WHERE CustomerID IS NULL

DELETE FROM Online_Retail
--SELECT *
--FROM Online_Retail
WHERE 
    Quantity < 0 OR
    UnitPrice < 0

--- COHORT ANALYSIS ---
-- create cohort date
SELECT 
    CustomerID,
    MIN(InvoiceDate) first_order_date,
    DATEFROMPARTS(year(min(InvoiceDate)), month(min(InvoiceDate)), 1) cohort_date
INTO #cohort_date
FROM Online_Retail
GROUP BY CustomerID

SELECT * 
FROM #cohort_date
--- create cohort index
SELECT 
    m.*,
    cohort_index=(order_year-cohort_year)*12 + (order_month-cohort_month) + 1
INTO #cohort_retention 
FROM   
    (
    SELECT
        o.*,
        c.cohort_date,
        month(c.cohort_date) cohort_month,
        year(c.cohort_date) cohort_year,
        month(o.InvoiceDate) order_month,
        year(o.InvoiceDate) order_year
    FROM Online_Retail o
    LEFT JOIN #cohort_date c
        ON o.CustomerID=c.CustomerID
    )m

SELECT * 
FROM #cohort_retention

--- Cohort retention by customer ---
SELECT
    cohort_date,
    cohort_index,
    COUNT (DISTINCT CustomerID) Count_customer
INTO #cohort_customer
FROM #cohort_retention
GROUP BY
    cohort_date,
    cohort_index
ORDER BY cohort_date

SELECT * 
FROM #cohort_customer

--pivot to see table
SELECT *
--INTO #piv_cohort_customer
FROM #cohort_customer
PIVOT
    (
    SUM(Count_customer)
    FOR cohort_index IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13])
    ) piv_cus

--- Cohort Retention Rate ---
SELECT 
    cohort_date,
    round(1.0 * [1]/[1] *100, 2) AS [1],
    round(1.0 * [2]/[1] *100, 2) AS [2],
    round(1.0 * [3]/[1] *100, 2) AS [3],
    round(1.0 * [4]/[1] *100, 2) AS [4],
    round(1.0 * [5]/[1] *100, 2) AS [5],
    round(1.0 * [6]/[1] *100, 2) AS [6],
    round(1.0 * [7]/[1] *100, 2) AS [7],
    round(1.0 * [8]/[1] *100, 2) AS [8],
    round(1.0 * [9]/[1] *100, 2) AS [9],
    round(1.0 * [10]/[1] *100, 2) AS [10],
    round(1.0 * [11]/[1] *100, 2) AS [11],
    round(1.0 * [12]/[1] *100, 2) AS [12],
    round(1.0 * [13]/[1] *100, 2) AS [13]
FROM #piv_cohort_customer

--- Cohort retention by sales ---
SELECT
    cohort_date,
    cohort_index,
    round(sum(Quantity*UnitPrice), 2) Total_Sales
--into #cohort_sales
FROM #cohort_retention
GROUP BY
    cohort_date,
    cohort_index
ORDER BY cohort_date
--pivot to see table
SELECT *
FROM #cohort_sales
PIVOT
    (
    sum(Total_Sales)
    FOR cohort_index IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13])
    ) piv_sales
