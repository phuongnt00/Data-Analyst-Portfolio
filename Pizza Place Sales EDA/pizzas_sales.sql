USE pizza_sales;
ALTER TABLE orders
MODIFY COLUMN date DATE;
ALTER TABLE orders
MODIFY COLUMN time TIME;

-- What days and times do we tend to be most engrossed?
SELECT 
	DAYNAME(date) AS weekday_name,
	COUNT(*) AS order_per_weekday
FROM orders
GROUP BY weekday_name
ORDER BY order_per_weekday DESC;

-- What is the busiest time in the day?
SELECT 
	EXTRACT(HOUR FROM time) AS hour,
    COUNT(*) AS order_per_hour
FROM orders
GROUP BY hour
ORDER BY order_per_hour DESC;

-- How many orders are we expecting each day, each month?
SELECT AVG(no_order) 
FROM (
    SELECT
		date,
		COUNT(*) AS no_order
	FROM orders
	GROUP BY date
    ) AS no_order_date;

SELECT AVG(no_order) 
FROM (
    SELECT
		EXTRACT(MONTH FROM date) AS month,
		COUNT(*) AS no_order
	FROM orders
	GROUP BY month
    ) AS no_order_date;
    
-- What are our best and worst selling pizzas?
SELECT 
	pt.name,
    ROUND(SUM(quantity*price),2) AS revenue
FROM order_details o
LEFT JOIN pizzas p
USING (pizza_id)
LEFT JOIN pizza_types pt
USING (pizza_type_id)
GROUP BY pt.name
ORDER BY revenue DESC;

-- No of pizzas sold as per category
SELECT 
	category,
    SUM(quantity) AS sold
FROM order_details o
LEFT JOIN pizzas p
USING (pizza_id)
LEFT JOIN pizza_types pt
USING (pizza_type_id)
GROUP BY category
ORDER BY sold DESC;

-- Number of pizzas sold as per size in year
SELECT 
	size,
    SUM(quantity) AS sold
FROM order_details o
LEFT JOIN pizzas p
USING (pizza_id)
GROUP BY size
ORDER BY sold DESC;

-- Can we identify any seasonality in the sales? 
SELECT 
    DATE_FORMAT(date, '%Y-%m') AS month,
    ROUND(SUM(quantity * price),2) AS total_sales
FROM orders
JOIN order_details 
USING (order_id)
JOIN pizzas 
USING (pizza_id)
GROUP BY month
ORDER BY total_sales DESC;

-- How much money did we make this year?
SELECT ROUND(SUM(quantity * price),2) AS order_value
FROM order_details od
JOIN pizzas p 
USING (pizza_id);

-- What is the average order value?
SELECT AVG(order_value) AS average_order_value
FROM (
    SELECT SUM(quantity * price) AS order_value
    FROM order_details od
    JOIN pizzas p 
    USING (pizza_id)
    GROUP BY od.order_id
) AS order_values;

-- Type of pizzas is best seller in each month
SELECT 
    month,
    pizza_type,
    total_sales
FROM (
    SELECT 
        DATE_FORMAT(date, '%Y-%m') AS month,
        name AS pizza_type,
        SUM(quantity * price) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(date, '%Y-%m') ORDER BY SUM(quantity * price) DESC) AS row_num
    FROM orders o
    JOIN order_details od 
    USING (order_id)
    JOIN pizzas p 
    USING (pizza_id)
    JOIN pizza_types pt 
    USING (pizza_type_id)
    GROUP BY 
        month, 
        pizza_type
	) AS ranked_pizzas
WHERE row_num = 1
ORDER BY month;
