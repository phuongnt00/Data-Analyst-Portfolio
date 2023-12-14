# Airline Passenger Satisfaction Report
## Introduction
The Airline Passenger Satisfaction Report provides an overview of the satisfaction levels of airline passengers based on various factors. The report is generated using Power BI, aims to analyze the satisfaction ratings across different aspects of the passenger experience, offering insights into areas of strength and opportunities for improvement.
## Data Description
The data for this report was collected through surveys administered to airline passengers. The survey included questions related to gender, customer type, age, type of travel, class, flight distance, time of departure/arrival delay, and satisfaction levels for various aspects of the airline experience. The satisfaction levels were measured on a scale of 1 to 5, with 1 representing low satisfaction and 5 representing high satisfaction.
### Source: [Airline Passenger Satisfaction](https://www.kaggle.com/datasets/teejmahal20/airline-passenger-satisfaction)
## Data Exploration and Visualization
### 1. Data Cleaning and Preprocessing
To prepare the data for analysis, I used Power Query to clean, create table and eliminate unnecessary columns. This streamlined the dataset and made it more manageable for analysis in Power BI.
### 2. Creating Calculated Fields and Measures
- Calculating total passengers by using COUNTROWS function `Passengers = COUNTROWS(train)`
- Calculating the count of Male: `Male = CALCULATE(COUNT(train[id]), train[Gender] = "Male")`
- Calculating the count of Female: `Female = CALCULATE(COUNT(train[id]), train[Gender] = "Female")`
- Calculating the percentage of Neutral of Disatisfied: `Neutral or Dissatisfied = DIVIDE(CALCULATE(COUNTROWS(train),(train[id]), train[satisfaction] = "neutral or dissatisfied"), COUNTROWS(train))`
- Calculating the percentage of Satisfied: `Satisfied = DIVIDE(CALCULATE(COUNTROWS(train),(train[id]), train[satisfaction] = "satisfied"), COUNTROWS(train))`
-  Calculating the count of Eco Class: `Eco = CALCULATE(COUNT(train[id]), train[Class] = "Eco")`
-  Calculating the count of Eco Plus Class: `Eco Plus = CALCULATE(COUNT(train[id]), train[Class] = "Eco Plus"))`
-  Calculating the count of Business Class: `Business = CALCULATE(COUNT(train[id]), train[Class] = "Business")`
-  Calculating the average Arrival Delay with unit "mins": `Arrival Delay = FORMAT(AVERAGE(train[Arrival Delay]), "0.00" & " mins")`
-  Calculating the average Departure Delay with unit "mins": `Departure Delay = FORMAT(AVERAGE(train[Departure Delay]), "0.00" & " mins")`
### 3. Visualizations and Dashboards
![image](https://user-images.githubusercontent.com/134161283/255385841-1f736bc8-a319-4ecb-827b-877492cb6ca4.png)
## Key Findings
- Overall Satisfaction: The average satisfaction level across all respondents was calculated to be 3.24/5.00. This indicates a moderate level of satisfaction among airline passengers.
- The Ease of Online booking, Inflight wifi service, and Gate location are three categories that scored below 3 and require improvement.
- The majority of neutral or dissatisfied responses came from loyal customers and personal travel type.
- Eco and Eco Plus class users need more attention as compared to Business class.
- Departure and Arrival Delay are also factors that affect passengers' satisfaction level.
- The majority of satisfied is in the 40s, while neutral or dissatisfied is in the 0s.
## Recommendations
- Enhance Online Booking Experience: Improving the ease of online booking should be a priority. Implement user-friendly interfaces, streamline the booking process, and provide clear instructions to enhance the overall online booking experience.
- Upgrade Inflight Wifi Service: Address the shortcomings in the inflight wifi service to meet passenger expectations. Invest in better technology, increase bandwidth, and ensure reliable connectivity throughout the flight to provide a seamless and satisfactory wifi experience.
- Improve Gate Location Information: Enhance the signage and communication regarding gate locations to minimize confusion and inconvenience for passengers. Provide clear and timely information about gate changes and ensure easy navigation within the airport terminals.
- Focus on Loyal Customers: Pay special attention to loyal customers who have expressed neutral or dissatisfied feedback. Implement loyalty programs, personalized offers, and attentive customer service to retain their loyalty and improve their overall satisfaction.
- Address Needs of Personal Travelers: Recognize the specific requirements and preferences of passengers traveling for personal reasons. Offer tailored services, flexible options, and amenities that cater to their individual needs to enhance their satisfaction and overall travel experience.
- Prioritize Eco and Eco Plus Class: Allocate resources to improve the satisfaction levels of passengers traveling in Eco and Eco Plus class. Enhance wifi service, foods and drinks, onboard services, and amenities to provide a more enjoyable experience for these passengers.
- Minimize Departure and Arrival Delays: Implement strategies to minimize departure and arrival delays. Streamline operational processes, improve scheduling, and optimize resource allocation to ensure timely departures and arrivals, which are key factors affecting passenger satisfaction.
## Conclusion
In summary, data-driven approach successfully identified key factors contributing to airline passenger satisfaction. Through advanced analytics, I pinpointed areas for improvement, such as ease of online booking, inflight wifi service, and gate location. I also recognized the importance of addressing the needs of loyal customers and passengers traveling for personal reasons. By focusing on areas such as Eco and Eco Plus class experience and minimizing departure and arrival delays, they can enhance overall passenger satisfaction. This data-driven approach allows airlines to make informed decisions and deliver an improved customer experience.
