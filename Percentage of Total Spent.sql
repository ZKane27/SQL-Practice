
-- Calculate the percentage of the total a customer spends on each order. Output the customer’s first name, order details, and percentage of the order cost to their total spend across all orders. 

-- Assume each customer has a unique first name (i.e., there is only 1 customer named Karen in the dataset) and that customers place at most only 1 order a day.

-- Percentages should be represented as fractions

-- sum by customer and order by item / sum total order by total order cost
-- INNER JOIN customer and orders
-- Window function partitioned by customer first name to calculate the total amount across all orders for each customer

SELECT 
    c.first_name,
    o.order_details,
    o.total_order_cost / sum(o.total_order_cost) OVER (partition BY c.first_name)::float AS percent_tot_cost
FROM orders o
JOIN customers c ON c.id=o.cust_id

