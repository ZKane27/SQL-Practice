-- Find the details of each customer regardless of whether the customer made an order. 
-- Output the customer's first name, last name, and the city along with the order details.
-- Your output should be listing the customer's orders not necessarily listing the customers. 
-- This means that you may have duplicate rows in your results due to a customer ordering several of the same items. 
-- Sort records based on the customer's first name and the order details in ascending order.

-- Used the LEFT JOIN on customer id to combine records of both tables.


SELECT 
    c.first_name,
    c.last_name,
    c.city,
    o.order_details
FROM customers c
LEFT JOIN orders o 
    ON o.cust_id = c.id
ORDER BY
    c.first_name asc,
    o.order_details asc;
