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
Configure SQL Server using the provided scripts in [here](https://github.com/phuongnt00/Data-Analyst-Portfolio/blob/main/Online%20Retail%20Cohort%20Analysis/Online%20Retail.sql). The scripts use a combination of basic and advanced SQL functions to perform data cleaning, calculate cohort retention rates and sales, and finally present the results in a pivoted format for easier analysis.

Explore the Power BI reports in the [file](https://github.com/phuongnt00/Data-Analyst-Portfolio/blob/main/Online%20Retail%20Cohort%20Analysis/Online%20Retail%20Cohort%20Analysis.pbix) directory to gain a comprehensive understanding of the cohort analysis results.

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

## Result
- Customer retention rate tends to decrease over time. Customers who made purchases in December 2010 had a higher repurchase rate than those who made purchases in subsequent months. In particular, the retention rate in December 2011 was below 10%.
- The new customer acquisition is declining. In the first month, the new customer acquisition was 885 customers, but by the 12th month, it had fallen to 41 customers.
## Conclusion
- The number of new customers is decreasing over time. This shows that company is struggling to attract new customers.
- December 2011 was a concerning month for the company. Both the customer retention rate and the number of new customers decreased significantly. This indicates that the business is facing some serious issue.
- During 2011, the company's competitors may have released new, better products or services. This may cause customers to switch to purchasing from competitors.
## Recommendation
- Conduct market research and customer surveys to better understand customer needs and the causes of the decline.
- Analyze customer data to identify specific customer groups that are experiencing problems with retention and acquisition.
- Conduct customer surveys to better understand why customers do not continue to make purchases.
- Build an effective marketing strategy to reach lead customers.
