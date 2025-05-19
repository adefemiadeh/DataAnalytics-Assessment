-- Assessment_Q2.sql 
-- Transaction Frequency Analysis

/*
    This query calculates the average number of transactions per customer per month
    and categorizes them based on their transaction frequency.  It joins the
    users and savings accounts tables, and calculates the average transactions
    per month.  It then uses a CASE statement to categorize customers into
    "High Frequency", "Medium Frequency", and "Low Frequency" categories.
*/

SELECT
    CASE
        WHEN avg_monthly_transactions >= 10 THEN 'High Frequency'
        WHEN avg_monthly_transactions >= 3 AND avg_monthly_transactions < 10 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(DISTINCT owner_id) AS customer_count,
    AVG(avg_monthly_transactions) AS avg_transactions_per_month
    
FROM (
    SELECT
        owner_id,
        AVG(monthly_transactions) AS avg_monthly_transactions
        
    FROM (
        SELECT
            owner_id,
            YEAR(transaction_date) AS transaction_year,
            MONTH(transaction_date) AS transaction_month,
            COUNT(DISTINCT transaction_reference) AS monthly_transactions
            
        FROM
            savings_savingsaccount
            
        WHERE
            transaction_status = 'success' -- Adjust if your success status is different
       
       GROUP BY
            owner_id, YEAR(transaction_date), MONTH(transaction_date)
    ) AS customer_monthly_transaction_counts
    
    GROUP BY
        owner_id
        
) AS customer_average_transactions

GROUP BY
    frequency_category
    
ORDER BY
    frequency_category;