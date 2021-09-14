-- Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.

-- match names to all the people that bought things
-- sum orders distinctly by person
-- Use the SUM() function to find the total cost.
-- Use JOIN on customer id to combine records from both tables.
-- Group records by the customer's first name.

SELECT
    customers.id,
    customers.first_name,
    sum(total_order_cost)
FROM orders
JOIN customers ON customers.id=orders.cust_id
GROUP BY customers.id,
    customers.first_name
ORDER BY customers.first_name ASC;
