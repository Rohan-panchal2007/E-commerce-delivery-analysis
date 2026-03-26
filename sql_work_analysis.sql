-- Q1.What is the average delivery time for each platform 
-- and Which platform has the fastest delivery time?
SELECT platform,AVG(delivery_time) AS avg_delivery_time FROM ecommerce
GROUP BY platform
ORDER BY avg_delivery_time ASC;

-- Q2.What is the total number of orders per platform?
SELECT platform,count(*) AS total_order FROM ecommerce
GROUP BY platform
ORDER BY total_order DESC;

-- Q3.Which product category has the highest number of orders? 
SELECT product_category,count(*) AS total_order FROM ecommerce
GROUP BY product_category
ORDER BY total_order DESC;


-- Q4.What is the average order value for each platform? 
SELECT platform,round(AVG(order_value),2) AS avg_order_value FROM ecommerce
GROUP BY platform
ORDER BY avg_order_value DESC;


-- Q5.How many orders are delayed per platform?

 SELECT platform , count(*) AS total_delayed_order 
FROM ecommerce 
WHERE delivery_delay = "Yes"
GROUP BY platform
ORDER BY total_delayed_order DESC;

-- Q6.What is the average delivery time for delayed vs non-delayed orders? 
SELECT   
CASE 
    WHEN delivery_delay = 'Yes' THEN 'Delayed Orders'
    ELSE 'On-Time Orders'
  END AS order_status,
  round(AVG(delivery_time),2) AS avg_delivery_time
FROM ecommerce
GROUP BY delivery_delay
ORDER BY avg_delivery_time DESC;

-- Q7.Which platform has the highest percentage of delayed orders?
SELECT platform , 
ROUND(100.0 * SUM(CASE WHEN delivery_delay = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS delayed_percantage,
count(*) AS total_orders
FROM ecommerce
GROUP BY platform
ORDER BY delayed_percantage DESC;

-- Q8.What is the average service rating per platform?
SELECT platform ,
ROUND(AVG(service_rating),2) AS avg_rating ,
COUNT(*) AS total_orders
FROM ecommerce 
GROUP BY platform
ORDER BY avg_rating DESC;

-- Q9.How does delivery delay affect service rating?
SELECT delivery_delay,
       COUNT(*) AS total_orders,
       ROUND(AVG(service_rating),2) AS avg_rating
FROM ecommerce
GROUP BY delivery_delay
ORDER BY avg_rating DESC;

-- Q10.Which feedback type appears most frequently and the average rating for each feedback category?
SELECT customer_feedback , COUNT(*) AS total_orders,
ROUND(AVG(service_rating),2) AS avg_rating
FROM ecommerce 
GROUP BY customer_feedback 
ORDER BY total_orders DESC;

-- Q11.Do higher order values lead to better rating?
SELECT 
CASE 
WHEN order_value < 300 THEN "LOW"
WHEN order_value < 700 THEN "MEDIUM"
ELSE "HIGH"
END AS ORDER_VALUES 
, 
AVG(service_rating) AS avg_rating
FROM ecommerce 
GROUP BY ORDER_VALUES
ORDER BY avg_rating desc;

-- Q12. Which platform performs best overall based on multiple metrics?

SELECT platform , ROUND(AVG(delivery_time),2) AS avg_delivery_time ,
ROUND(AVG(service_rating),2) AS avg_service_rating,
ROUND(100.0 * SUM(CASE WHEN delivery_delay = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS delayed_percantage,
ROUND(100.0 * SUM(CASE WHEN refund_requested = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS refund_percantage
FROM ecommerce
GROUP BY platform
ORDER BY 
  avg_service_rating DESC,
  delayed_percantage ASC,
  refund_percantage ASC,
  avg_delivery_time ASC;


























