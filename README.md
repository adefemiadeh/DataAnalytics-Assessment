# DataAnalytics-Assessment

## Per-Question Explanations

Q1: High-Value Customers with Multiple Products

* Approach: The query joins the users_customuser, savings_savingsaccount, and plans_plan tables to link customer data with their savings and investment plans.  It counts the number of distinct savings and investment plans for each customer using conditional counting with CASE statements within COUNT(DISTINCT ...) to ensure each plan is only counted once per customer.  It also calculates the total deposits for each customer.  Finally, it filters for customers with at least one savings and one investment plan, and orders the results by total deposits.

* Key Tables: users_customuser, savings_savingsaccount, plans_plan
* Key Concepts: Joins, Conditional Counting, Grouping, Filtering, Ordering

Q2: Transaction Frequency Analysis

* Approach: The query joins users_customuser and savings_savingsaccount. It calculates the number of transactions per customer per month using GROUP BY and COUNT.  A subquery calculates monthly transaction counts. The main query then categorizes customers into "High Frequency" (>=10 transactions/month), "Medium Frequency" (3-9 transactions/month), and "Low Frequency" (<=2 transactions/month) categories using a CASE statement.  It then calculates the count of customers in each category and the average transactions per month for each category.

* Key Tables: users_customuser, savings_savingsaccount
* Key Concepts: Joins, Grouping, Aggregation, Subqueries, Conditional Logic

Q3: Account Inactivity Alert
* Approach: The query joins the plans_plan and savings_savingsaccount tables to link plans with their associated transactions.  It determines the type of plan (Savings or Investment) using a CASE statement.  It calculates the last transaction date for each plan using MAX(sa.created_at).  It then calculates the number of days since the last transaction using JULIANDAY.  Finally, it filters for plans where the last transaction was more than 365 days ago.

* Key Tables: plans_plan, savings_savingsaccount
* Key Concepts: Joins, Conditional Logic, Date Calculations, Grouping, Filtering

Q4: Customer Lifetime Value (CLV) Estimation
* Approach: The query joins users_customuser and savings_savingsaccount. It calculates the account tenure in months using JULIANDAY and CAST.  It counts the total number of transactions for each customer.  It then calculates the estimated CLV using the provided formula.  The results are ordered by CLV in descending order.

* Key Tables: users_customuser, savings_savingsaccount
* Key Concepts: Joins, Date Calculations, Aggregation, CLV Calculation, Ordering

## Challenges

* Q1: Ensuring that both savings and investment plans were counted correctly for each user, even if they had multiple of either type.  The use of COUNT(DISTINCT ...) with a CASE statement was crucial here.

* Q2: Calculating the average transactions per month required careful handling of the date functions and grouping.  I needed to calculate monthly transactions in a subquery and then average those counts.

* Q3: Accurately calculating the inactivity period in days required using the JULIANDAY function.

* Q4: The CLV calculation required careful attention to the order of operations and data types to ensure the result was accurate.  Specifically, converting the tenure to a floating-point number was important.