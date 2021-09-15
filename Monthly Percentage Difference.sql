
-- Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
-- The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.

-- calculate month-over-month percentage -- YYYY-MM and percentage change as output -- rounded tot 2nd decimal point -- sorted from the beginning of the year

-- approach: -- group by month -- lag function to get previous year

-- 1. Formate date to YYYY-MM
	-- cast column to date dtype
	-- formate date using to_char()
-- 2. Calculate month-over-month percentage change in revenue
	-- formula: % change
	-- 2a. calculate the total revenue of the current onth (or day's value)
	-- 2b. Calculate last month's revenue
	-- 2c. Aggregate the dates to year-month

-- (WITHOUT THE % change formula)
SELECT 
    to_char(created_at::date, 'YYYY-MM') as year_month,
    sum(value),
    lag(sum(value), 1) OVER (ORDER BY to_char(created_at::date, 'YYYY-MM'))
FROM sf_transactions
GROUP BY year_month

-- (FINAL)
SELECT 
    to_char(created_at::date, 'YYYY-MM') as year_month,
    round((sum(value) - lag(sum(value),1) OVER (ORDER BY to_char(created_at::date, 'YYYY-MM'))) / lag(sum(value), 1) OVER (ORDER BY to_char(created_at::date, 'YYYY-MM'))*100, 2) as percent_change
FROM sf_transactions
GROUP BY year_month

-- (CLEANED UP, ALIASED)
SELECT 
    to_char(created_at::date, 'YYYY-MM') as year_month,
    round((sum(value) - lag(sum(value),1) OVER w) / lag(sum(value), 1) OVER w*100,2) as percent_change
FROM sf_transactions
GROUP BY year_month
WINDOW w as (ORDER BY to_char(created_at::date, 'YYYY-MM'))
