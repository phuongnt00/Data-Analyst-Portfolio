# Online Retail Cohort Analysis
<p align="center">
<img src="https://assets.toptal.io/images?url=https%3A%2F%2Fbs-uploads.toptal.io%2Fblackfish-uploads%2Fcomponents%2Fblog_post_page%2Fcontent%2Fcover_image_file%2Fcover_image%2F685873%2Fretina_500x200_1203_Growing-Growth--Perform-Your-Own-Cohort-Analysis-with-This-Open-Source-Code_Newsletter-aac8aa0b429c29dd9b4dc0336c5eecd6.png" alt="cohort" width="600" />
</p>

## Overview
In the dynamic landscape of e-commerce, understanding customer behavior is crucial for business success. This project aims to provide a detailed analysis of customer cohorts in the online retail domain, offering valuable insights into user retention, spending patterns, and overall customer engagement.

The project leverages SQL Server for data processing and Power BI for intuitive data visualizations.

### Key Features
- **Cohort Creation:** Explore customer behavior over time by grouping them into cohorts based on their sign-up date.
- **Metric Calculation:** Calculate essential metrics such as retention rates, average revenue per user, and other key performance indicators for each cohort.
- **Data Processing with SQL Server:** Utilize SQL Server for efficient data cleaning, transformation, and cohort analysis.
- **Interactive Visualizations with Power BI:** Visualize and interact with the cohort analysis results using Power BI for meaningful insights.

## Project
Configure SQL Server using the provided scripts in [here](https://github.com/phuongnt00/Data-Analyst-Portfolio/blob/main/Online%20Retail%20Cohort%20Analysis/Online%20Retail.sql) and explore the Power BI reports in the [file](https://github.com/phuongnt00/Data-Analyst-Portfolio/blob/main/Online%20Retail%20Cohort%20Analysis/Online%20Retail%20Cohort%20Analysis.pbix) directory to gain a comprehensive understanding of the cohort analysis results.

### Power BI Visualization Preview
![image](https://github.com/phuongnt00/Data-Analyst-Portfolio/assets/134161283/fe7888ef-128e-41d1-948e-f96f29fd7c97)

## About the Dataset
The dataset used for this project is obtained from Kaggle's [Online Retail dataset](https://www.kaggle.com/datasets/tunguz/online-retail/data). This is a transnational data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail.The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers.

Download dataset [here](https://github.com/phuongnt00/Data-Analyst-Portfolio/blob/main/Online%20Retail%20Cohort%20Analysis/Online_Retail.csv)

#### Attribute Information:
- InvoiceNo: Invoice number. Nominal, a 6-digit integral number uniquely assigned to each transaction. If this code starts with letter 'c', it indicates a cancellation.
- StockCode: Product (item) code. Nominal, a 5-digit integral number uniquely assigned to each distinct product.
- Description: Product (item) name. Nominal.
- Quantity: The quantities of each product (item) per transaction. Numeric.
- InvoiceDate: Invoice Date and time. Numeric, the day and time when each transaction was generated.
- UnitPrice: Unit price. Numeric, Product price per unit in sterling.
- CustomerID: Customer number. Nominal, a 5-digit integral number uniquely assigned to each customer.
- Country: Country name. Nominal, the name of the country where each customer resides.

