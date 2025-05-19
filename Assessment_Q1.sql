-- Assessment_Q1.sql
-- High-Value Customers with Multiple Products

/*
    This query identifies customers who have both savings and investment plans.
    It joins the users, savings accounts, and plans tables to link customer information
    with their financial products.  It then filters for customers who have at least
    one savings account and one investment plan. The results are grouped by customer
    and ordered by total deposits in descending order.
*/

SELECT 
    u.id AS owner_id,
    CONCAT(first_name, ' ', last_name) AS name,
    
    COUNT(DISTINCT CASE
            WHEN pl.is_regular_savings = 1 THEN pl.id
        END) AS savings_count,
        
    COUNT(DISTINCT CASE
            WHEN pl.is_fixed_investment = 1 THEN pl.id
        END) AS investment_count,
    SUM(sa.confirmed_amount / 100) AS total_deposits
    
FROM
    users_customuser u
        JOIN
    savings_savingsaccount sa ON u.id = sa.owner_id
        JOIN
    plans_plan pl ON sa.plan_id = pl.id
    
WHERE
    pl.is_regular_savings = 1
        OR pl.is_fixed_investment = 1
        
GROUP BY u.id , u.name

HAVING COUNT(DISTINCT CASE
        WHEN pl.is_regular_savings = 1 THEN pl.id
    END) >= 1
    AND COUNT(DISTINCT CASE
        WHEN pl.is_fixed_investment = 1 THEN pl.id
    END) >= 1
    
ORDER BY total_deposits DESC;