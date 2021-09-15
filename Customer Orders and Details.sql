-- Find the number of orders, the number of customers, and the total cost of orders for each city. Only include cities that have made at least 5 orders and count all customers in each city even if they did not place an order.

-- Output each calculation along with the corresponding city name.

-- Count order, customers, and sum costs by city
-- LEFT JOIN on customer id to combine records of both tables
-- GROUP BY city
-- HAVING to find count(city's orders) >= 5

SELECT 
    c.city,
    count(o.id) as orders_per_city,
    count(DISTINCT c.id) as customers_per_city,
    sum(o.total_order_cost) as orders_cost_per_city
FROM customers c 
LEFT JOIN orders o
    ON c.id = o.cust_id
GROUP BY c.city
HAVING count(c.id) > 5
