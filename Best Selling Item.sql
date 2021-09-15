-- Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. The best selling item is calculated using the formula (unitprice * quantity). Output the description of the item along with the amount paid.

-- Create a unitprice*quantity value, Group by stockcode and month
-- max for each item

(mine, worked, ugly tho)
SELECT 
    DISTINCT month,
    o.description,
    sale
FROM
(SELECT
    stockcode,
    sale,
    month,
    RANK() OVER(PARTITION BY month ORDER BY sale desc) as rnk
FROM (SELECT 
    stockcode,
    sum(quantity*unitprice) as sale,
    to_char(invoicedate, 'MM') as month
FROM online_retail
GROUP BY stockcode,
    month
ORDER BY month) i) ii
LEFT JOIN online_retail o ON ii.stockcode=o.stockcode
WHERE ii.rnk = 1
ORDER BY month

-- (CLEAN)
SELECT 
    month,
    description,
    total_paid
FROM
  (SELECT date_part('month', invoicedate) AS month,
          description,
          sum(unitprice * quantity) AS total_paid,
          rank() OVER (PARTITION BY date_part('month', invoicedate)
                       ORDER BY sum(unitprice * quantity) DESC) AS rnk
   FROM online_retail
   GROUP BY MONTH,
            description) tmp
WHERE rnk = 1
