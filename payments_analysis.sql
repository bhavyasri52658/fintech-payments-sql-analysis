
-- FinTech Payments & Transaction Analysis
-- Database: PostgreSQL

-- 1. View all transactions
SELECT *
FROM payments;

-- 2. Display successful transactions
SELECT *
FROM payments
WHERE status = 'Success';

-- 3. Total transaction amount by payment method
SELECT
    payment_method,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_method
ORDER BY total_amount DESC;

-- 4. Count transactions by status
SELECT
    status,
    COUNT(*) AS transaction_count
FROM payments
GROUP BY status;

-- 5. Calculate the overall failure rate
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END)
        AS failed_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS failure_rate_percent
FROM payments;

-- 6. Categorise transactions by amount
SELECT
    payment_id,
    amount,
    CASE
        WHEN amount >= 1000 THEN 'High Value'
        ELSE 'Regular'
    END AS payment_category
FROM payments;

-- 7. Failure rate by payment method
SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END)
        AS failed_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS failure_rate_percent
FROM payments
GROUP BY payment_method
ORDER BY failure_rate_percent DESC;

-- 8. Daily transaction analysis
SELECT
    payment_date,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_amount,
    SUM(CASE WHEN status = 'Success' THEN amount ELSE 0 END)
        AS successful_amount
FROM payments
GROUP BY payment_date
ORDER BY payment_date;

-- 9. Success and failure rates by payment method
SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END)
        AS successful_transactions,
    SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END)
        AS failed_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS success_rate_percent,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS failure_rate_percent
FROM payments
GROUP BY payment_method
ORDER BY success_rate_percent DESC;

-- 10. Transaction status summary
SELECT
    status,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM payments),
        2
    ) AS percentage_of_transactions
FROM payments
GROUP BY status
ORDER BY transaction_count DESC;
