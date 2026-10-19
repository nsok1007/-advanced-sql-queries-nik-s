-- Task 1: GROUP BY SUM
SELECT order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY order_date;

-- Task 2: GROUP BY COUNT
SELECT order_date, COUNT(customer_id) AS order_totals
FROM orders
GROUP BY order_date; -- filter results to show how many orders were placed by customers on each date

-- Task 3: GROUP BY AVG
SELECT customer_id, AVG(total_amount) AS avg_spent
FROM orders
GROUP BY customer_id; -- filter results to show the average $ spent per customer_id

-- Task 4: FILTER with WHERE (before grouping)
SELECT order_date, COUNT(customer_id) AS order_spending
FROM orders
WHERE total_amount > 200
GROUP BY order_date; -- filter results to show only dates with with orders over $200

-- Task 5: FILTER with HAVING (after grouping)
SELECT customer_id, AVG(total_amount) AS avg_spent
FROM orders
GROUP BY customer_id
HAVING AVG(total_amount) > 200; -- filter results to show only orders where an avg > $200 was spent

-- Task 6: JOIN Statement 1
SELECT orders.order_date,
       count(orders.id) AS orders_made
FROM orders
LEFT JOIN customers
  ON orders.customer_id = customers.id
GROUP BY orders.order_date; -- Filter results to show how many orders were placed whether they're a customer OR guest

-- Task 7: JOIN Statement 2
SELECT orders.order_date,
       SUM(orders.total_amount) AS total_spent
FROM customers
RIGHT JOIN orders
  ON customers.id = orders.customer_id
GROUP BY orders.order_date; -- Filter results to show how much was earned from orders on each date

-- Task 8: JOIN Statement 3
SELECT orders.id,
       orders.order_date,
       orders.total_amount
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.id
WHERE total_amount < 150; -- Filter results to show only orders less than $150 (not-nullable)

-- Task 9: Subquery 1 
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount > (SELECT MIN(total_amount) from orders); -- Find orders that are above the minimum total_amount

-- Task 10: Subquery 2 (multi-row/column)
SELECT first_name, last_name
FROM customers
WHERE id IN(SELECT customer_id FROM orders); -- Find customers who placed an order 

-- Task 11: Subquery 3 (derived table)
SELECT customer_id, total_amount
FROM (
    SELECT order_date, total_amount, customer_id
    FROM orders
    WHERE total_amount < 200
) AS customer_filter; -- Find customer(s) who spent < $200
