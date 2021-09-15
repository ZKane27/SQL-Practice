-- Find order details made by Jill and Eva.
-- Consider the Jill and Eva as first names of customers.
-- Output the order date, details and cost along with the first name.
-- Order records based on the customer id in ascending order

-- Inner Join on customer id to combine the customer info with order info
-- Grab order first name, date, details, cost using a where and in statements

SELECT
    c.first_name,
    o.order_date,
    o.order_details,
    o.total_order_cost
FROM orders o
JOIN customers c
ON o.cust_id=c.id
WHERE c.first_name IN ('Jill', 'Eva')
ORDER BY o.cust_id
