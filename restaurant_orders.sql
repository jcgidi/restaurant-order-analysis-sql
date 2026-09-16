-- 0.- Use restaurant database
USE restaurant_db;

-- 1.-View the menu_items table 
SELECT * 
FROM menu_items;

-- 1.1- Find the number of items on the menu
SELECT COUNT(price)
FROM menu_items;

-- 2.- What are the least and most expensive items on the menu?
SELECT MAX(price) as MAX, MIN(price) as MIN
FROM menu_items;

-- 2.1- What are the least and most expensive items on the menu?
SELECT item_name, price
FROM menu_items
ORDER BY (price) desc;

-- 2.2- What are the least and most expensive items on the menu?
SELECT item_name, price
FROM menu_items
ORDER BY (price) asc;

-- 3.- How many Italian dishes are on the menu? 
SELECT count(*)
FROM menu_items
WHERE category ="Italian";

-- 3.1-  What are the least and most expensive Italian dishes on the menu?
SELECT *
FROM menu_items
WHERE category =("Italian")
ORDER BY price;

-- 4.- How many dishes are in each category? What is the average dish price within each category?
SELECT category, count(category) AS_num_dishes, AVG(price) as avg_price
FROM menu_items
GROUP BY (category);

-- 5.-View the order_details table. What is the date range of the table?
SELECT datediff(MAX(order_date), MIN(order_date))
FROM order_details;

-- 6.-How many orders were made within this date range? 
SELECT COUNT(DISTINCT(order_id))
FROM order_details;

-- 6.1.-How many items were ordered within this date range?
SELECT COUNT(*)
FROM order_details;

-- 7.- Which orders had the most number of items?
SELECT COUNT(item_id) AS items_per_order, order_id as order_number
FROM order_details
GROUP BY(order_id)
ORDER BY items_per_order desc;

-- 8.- How many orders had more than 12 items?
SELECT count(*)
FROM (SELECT COUNT(item_id) AS items_per_order, order_id as order_number
FROM order_details
GROUP BY(order_id)
HAVING (items_per_order>12)) AS filtered_orders;

-- 9.-Combine the menu_items and order_details tables into a single table 
SELECT *
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id;

-- 10.-What were the least and most ordered items? What categories were they in?
SELECT COUNT(order_id) as num_purchases, item_name
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_id
ORDER BY num_purchases DESC;

-- 11.-What were the top 5 orders that spent the most money?
SELECT SUM(price) as money_spent ,order_id
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY money_spent desc
LIMIT 5;

-- 12.-View the details of the highest spend order. Which specific items were purchased?
SELECT *
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id= 440;

-- 12.1.- Hoy many item pers category were purchased?
SELECT category, count(item_id)
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id= 440
GROUP BY category;

-- 13.-BONUS: View the details of the top 5 highest spend orders
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY order_id, category;

