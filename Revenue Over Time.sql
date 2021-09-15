
-- Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. Do not include returns which are represented by negative purchase values. Output the month and 3-month rolling average of revenue, sorted from earliest month to latest month.

-- A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. The first two months will not be a true 3-month rolling average since we are not given data from last year.

-- Remove negatives, group by month
-- Calculate monthly average and two previous months
-- Aggregate total revenue for each month by adding all positive values (ignore negative values), output should be month (YYYY-MM) and total revenue and sort by date in ascending order using ORDER BY
-- Use a window frame of 3 months -- the current month and the previous 2 months as ROWS BETWEEN 2 PRECEDING AND CURRENT ROW -- and using an OVER() function
-- Use an AVG() function to calculate average revenue over the defined window frame


SELECT
    t.month,
    AVG(t.monthly_revenue) OVER(
        ORDER BY t.month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as avg_revenue
FROM (SELECT
    to_char(created_at::date, 'YYYY-MM') as month,
    sum(purchase_amt) as monthly_revenue
FROM amazon_purchases
WHERE purchase_amt > 0
GROUP BY month
ORDER BY month) t
GROUP BY t.month,
    t.monthly_revenue
ORDER BY t.month ASC
