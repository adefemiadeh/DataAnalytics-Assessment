-- Assessment_Q4.sql
-- Customer Lifetime Value (CLV) Estimation

/*
    This query estimates the Customer Lifetime Value (CLV) for each customer
    based on their account tenure and transaction volume. It calculates the
    account tenure in months, the total number of transactions, and then
    estimates the CLV using the provided formula.  The results are ordered by CLV in descending order.
*/


SELECT
    u.id AS customer_id,
    CONCAT(first_name, ' ', last_name) AS name,
    FLOOR(DATEDIFF(CURDATE(), u.created_on) / 30) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    (COUNT(s.id) / (DATEDIFF(CURDATE(), u.created_on) / 30)) * 12 * (0.001 * SUM(s.confirmed_amount / 100)) AS estimated_clv

FROM
    users_customuser u

LEFT JOIN
    savings_savingsaccount s ON u.id = s.owner_id

GROUP BY
    CONCAT(first_name, ' ', last_name), u.id,  u.created_on

ORDER BY
    estimated_clv DESC;