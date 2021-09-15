
-- You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. Find the number of users that made additional in-app purchases due to the success of the marketing campaign.

-- The marketing campaign doesn't start until one day after the initial in-app purchase so users that make multiple purchases on the same day do not count, nor do we count users that make only the same purchases over time.

-- Different dates, different products purchased
-- Count of users


-- find first purschase by user
-- find the purchases after the first purchase
-- filter through the conditions
    --no multiple same day purchases | distinct days
    -- no same purches | it can be a pair or we can create a new column column using concat
    
WITH 
first_purchase AS (
SELECT 
      user_id
    , MIN(created_at) AS first_purchase
    , MAX(product_id) AS product_id
FROM marketing_campaign
GROUP BY user_id
)

SELECT
     count(DISTINCT user_id) AS user_count
FROM
(SELECT 
       a.user_id
FROM marketing_campaign a
JOIN first_purchase b
ON a.created_at > b.first_purchase
AND a.product_id != b.product_id
GROUP BY a.user_id
HAVING COUNT(DISTINCT a.product_id)>1
AND COUNT(DISTINCT created_at)> 1) a

-- ANOTHER WAY (CLEANER)
with a AS (
    SELECT 
        user_id ,
        created_at,
        product_id, 
        rank() over (partition by user_id order by created_at) as rnk 
    FROM marketing_campaign),
    
b AS (
    SELECT user_id, created_at, product_id
    FROM a
    WHERE rnk > 1 
    AND
    (user_id, product_id) NOT IN  (select user_id, product_id From a where rnk=1))
    
select count(DISTINCT user_id) from b
