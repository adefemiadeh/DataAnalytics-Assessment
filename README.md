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
* Approach: The query joins the plans_plan and savings_savingsaccount tables to link plans with their associated transactions.  It determines the type of plan (Savings or Investment) using a CASE statement.  It calculates the last transaction date for each plan using MAX(sa.created_on).  It then calculates the number of days since the last transaction using DATEDIFF.  Finally, it filters for plans where the last transaction was more than 365 days ago.

* Key Tables: plans_plan, savings_savingsaccount
* Key Concepts: Joins, Conditional Logic, Date Calculations, Grouping, Filtering

Q4: Customer Lifetime Value (CLV) Estimation
* Approach: The query joins users_customuser and savings_savingsaccount. It calculates the account tenure in months using DATEDIFF and CURDATE.  It counts the total number of transactions for each customer.  It then calculates the estimated CLV using the provided formula.  The results are ordered by CLV in descending order.

* Key Tables: users_customuser, savings_savingsaccount
* Key Concepts: Joins, Date Calculations, Aggregation, CLV Calculation, Ordering

## Challenges

* Q1: Counting Savings and Investment Plans
The challenge was counting both savings and investment plans per user, even when users had multiple of each. I solved this by using COUNT(DISTINCT ...) with a CASE statement, and I combined first_name and last_name to get a proper display name.

* Q2: Average Transactions Per Month
Figuring out monthly averages was tricky at first. I used a subquery to count transactions per month, then took the average—getting the date functions and grouping right was key.

* Q3: Inactivity Period in Days
Calculating how long a user was inactive required using DATEDIFF. It was straightforward once I figured out the correct dates to compare.

* Q4: Customer Lifetime Value (CLV)
CLV was the toughest. I had to be careful with the math and data types—especially converting tenure to a float to avoid rounding issues in the final result.
