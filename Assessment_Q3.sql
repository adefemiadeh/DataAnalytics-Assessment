-- Assessment_Q3.sql
-- Account Inactivity Alert

/*
    This query identifies active accounts (savings or investments) with no
    transactions in the last year. It joins plans and savings accounts.
    It calculates the last transaction date for each account and then
    filters for accounts where the last transaction was more than 365 days ago.
*/


SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_fixed_investment = 1 THEN 'Investment'
    END AS type,
    MAX(p.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(p.created_on)) AS inactivity_days
    
FROM
    plans_plan p
    
JOIN
    savings_savingsaccount s ON p.id = s.plan_id
    
WHERE s.created_on IS NOT NULL

GROUP BY p.id, p.owner_id, type

HAVING DATEDIFF(CURDATE(), MAX(s.created_on)) > 365

ORDER BY p.id;