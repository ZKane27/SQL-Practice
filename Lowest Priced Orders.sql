
-- Find the lowest order cost of each customer.
-- Output the customer id along with the first name and the lowest order price.

-- Min partitioned by user
-- first_value and min work the same
-- 

SELECT
    DISTINCT o.cust_id,
    c.first_name,
    min(o.total_order_cost) OVER (PARTITION BY o.cust_id)
FROM customers c
JOIN orders o ON c.id=o.cust_id

-- OR 

SELECT 
    DISTINCT (cust_id), 
    customers.first_name,
    first_value (total_order_cost) OVER (PARTITION BY cust_id ORDER BY total_order_cost) AS lowest_price_per_group
FROM orders
JOIN customers ON customers.id = orders.cust_id;
