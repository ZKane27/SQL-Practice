
-- Find employees from Arizona, California, and Hawaii while making sure to output all employees from each city. Output column headers should be Arizona, California, and Hawaii.
-- Assume unequal number of employees per city.

-- Where function
-- selection for each city
-- 

with t1 as (select
first_name as arizona,
row_number() over (order by first_name) as rnk
from employee
where city = 'Arizona'),

t2 as (select
first_name as california,
row_number() over (order by first_name) as rnk
from employee
where city = 'California'),

t3 as (select
first_name as hawaii,
row_number() over (order by first_name) as rnk
from employee
where city = 'Hawaii')

select arizona, california, hawaii
from t1
join t2
on t1.rnk = t2.rnk
join t3
on t2.rnk = t3.rnk

-- OR 

WITH arizona AS
  (SELECT first_name AS aname,
          ROW_NUMBER() OVER (
                             ORDER BY first_name) AS arn
   FROM employee
   WHERE city='Arizona' ),
     california AS
  (SELECT first_name AS cname,
          ROW_NUMBER() OVER (
                             ORDER BY first_name) AS crn
   FROM employee
   WHERE city='California' ),
     hawaii AS
  (SELECT first_name AS hname,
          ROW_NUMBER() OVER (
                             ORDER BY first_name) AS hrn
   FROM employee
   WHERE city='Hawaii' )
SELECT aname AS arizona,
       cname AS california,
       hname AS hawaii
FROM hawaii
FULL OUTER JOIN california ON hrn=crn
FULL OUTER JOIN arizona ON COALESCE(hrn, crn) =arn;
