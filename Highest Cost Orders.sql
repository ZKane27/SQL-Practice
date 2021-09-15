-- Find the customer with the highest total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output their first name, total cost of their items, and the date.
 
-- For simplicity, you can assume that every first name in the dataset is unique.

-- sum total orders group by customer id and first name and order date
-- WHERE dates restricted between 2019-02-01 and 2019-05-01
-- output max date

SELECT
    c.first_name,
    sum(o.total_order_cost),
    o.order_date
FROM orders o
JOIN customers c
    ON o.cust_id=c.id
WHERE o.order_date BETWEEN '2019-02-01' AND '2019-05-01'
GROUP BY
    o.order_date,
    c.first_name
ORDER BY 2 desc
LIMIT 1
