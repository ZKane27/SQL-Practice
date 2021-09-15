-- Find the second highest salary of employees.

-- Use DISTINCT to filter out duplicate values.
-- Use ORDER BY to order salaries in descending order.
-- Use LIMIT followed by OFFSET to find the desired record.

select
    DISTINCT salary
from employee
ORDER BY salary DESC
LIMIT 1
OFFSET 1

-- OR

select distinct salary 
from (
select salary, dense_rank() over(order by salary desc) as rk 
from employee
) as a 
where a.rk=2

-- OR

--window function to grab second highest
with salary_rank as (
select
    salary,
    dense_rank() over(order by salary desc) as salary_rank
from
    employee
)
select
    salary
from
    salary_rank
where
    salary_rank = 2



