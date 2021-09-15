-- Find "favorite" customers based on the order count and the total cost of orders.
-- A customer is considered as a favorite if he or she has placed more than 3 orders and with the total cost of orders more than $100.

-- Output the customer's first name, city, number of orders, and total cost of orders.

-- Count orders and sum orders groupped by customer
-- HAVING count(orders) > 3 AND sum(tot_costs) > 100
-- Group by id, city and first name


SELECT
    c.first_name as name,
    c.city,
    count(o.id) as order_count,
    sum(o.total_order_cost) as total_cost
FROM customers c
LEFT JOIN orders o
    ON c.id = o.cust_id
GROUP BY c.first_name,
    c.id,
    c.city
HAVING count(o.id) > 3 
    AND sum(o.total_order_cost) > 100
ORDER BY total_cost desc;

