-- Create the payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    payment_method VARCHAR(30),
    amount DECIMAL(10,2),
    status VARCHAR(20),
    payment_date DATE
);

-- Insert sample transaction data
INSERT INTO payments
    (payment_id, customer_name, payment_method, amount, status, payment_date)
VALUES
    (1, 'Ananya', 'UPI', 500, 'Success', '2026-10-01'),
    (2, 'Rahul', 'Card', 1200, 'Failed', '2026-10-01'),
    (3, 'Priya', 'UPI', 800, 'Success', '2026-10-02'),
    (4, 'Arjun', 'Net Banking', 1500, 'Pending', '2026-10-02'),
    (5, 'Sneha', 'Card', 700, 'Failed', '2026-10-03'),
    (6, 'Ananya', 'UPI', 900, 'Success', '2026-10-03'),
    (7, 'Rahul', 'Card', 400, 'Success', '2026-10-04'),
    (8, 'Priya', 'UPI', 2000, 'Failed', '2026-10-04'),
    (9, 'Arjun', 'Net Banking', 600, 'Success', '2026-10-05'),
    (10, 'Sneha', 'Card', 1100, 'Success', '2026-10-05');

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
