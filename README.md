# FinTech Payments & Transaction Analysis Using SQL

## Project Overview
This project analyses payment transaction data using PostgreSQL to understand transaction outcomes, payment method performance, daily trends, and failed payments.

## Tools Used
- PostgreSQL
- SQL
- Aggregate functions: COUNT(), SUM()
- CASE WHEN
- GROUP BY and ORDER BY
- Subqueries
- Percentage calculations

## Dataset
The dataset contains 10 synthetic transactions with the following columns:
- payment_id
- customer_name
- payment_method
- amount
- status
- payment_date

## Business Questions
1. How many transactions succeeded, failed, or remained pending?
2. Which payment methods had the highest transaction amounts?
3. What was the overall failure rate?
4. Which payment method had the highest observed failure rate?
5. How did transaction amounts vary by date?
6. What percentage of transactions belonged to each status?

## Key Findings
- Total transactions analysed: 10
- Successful transactions: 6 (60%)
- Failed transactions: 3 (30%)
- Pending transactions: 1 (10%)
- UPI success rate: 75%
- Card failure rate: 50%
- Highest daily attempted transaction amount: ₹2,400 on October 4
- Total attempted amount associated with failed transactions: ₹3,900

## Business Recommendations
- Investigate reasons behind failed Card transactions.
- Monitor pending transactions and their final outcomes.
- Track daily transaction volumes and success rates.
- Analyse a larger dataset before making business decisions.

## Limitations
This is a small synthetic practice dataset. Its findings demonstrate SQL skills and should not be treated as representative of real payment systems.

## Skills Demonstrated
SQL querying, filtering, aggregation, conditional logic, subqueries, KPI calculations, and business insight generation.
