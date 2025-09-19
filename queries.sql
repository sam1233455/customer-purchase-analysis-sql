-- =====================================================
-- Query 1: Top 3 outlets by cuisine type 
-- Requirement: Without using TOP or LIMIT
-- =====================================================

WITH cte AS (
    SELECT 
        restaurant_id AS outlet,
        cuisine,
        COUNT(*) AS no_of_orders 
    FROM book.orders
    GROUP BY outlet, cuisine
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY cuisine ORDER BY no_of_orders DESC) AS rn 
    FROM cte
    ORDER BY cuisine, outlet
) AS n
WHERE rn <= 3;



-- =====================================================
-- Query 2: Daily customer count from launch date
-- Requirement: Everyday how many customers we are acquiring
-- =====================================================

WITH cte AS (
    SELECT 
        customer_code,
        MIN(DATE_FORMAT(placed_at, '%Y-%m')) AS launch_month
    FROM book.orders
    GROUP BY customer_code
)
SELECT 
    launch_month,
    COUNT(*) AS no_of_customers
FROM cte 
GROUP BY launch_month;



-- =====================================================
-- Query 3: Customers acquired in Jan 2025 
-- Requirement: Only placed orders in Jan, and no other month
-- =====================================================

SELECT 
    customer_code,
    COUNT(*) AS total_number_of_customer
FROM book.orders
WHERE MONTH(placed_at) = 1
  AND customer_code NOT IN (
        SELECT customer_code 
        FROM book.orders
        WHERE MONTH(placed_at) <> 1
  )
GROUP BY customer_code;



-- =====================================================
-- Query 4: Customers acquired one month ago with first order promo
-- Requirement: Did not place order in last 7 days
-- =====================================================

WITH cte AS (
    SELECT 
        customer_code,
        MIN(placed_at) AS earlier_date,
        MAX(placed_at) AS latest_date
    FROM book.orders
    GROUP BY customer_code
)
SELECT
    C.customer_code,
    C.earlier_date,
    b.promo_code
FROM cte C
JOIN book.orders b 
  ON C.customer_code = b.customer_code
 AND C.earlier_date = b.placed_at
WHERE C.latest_date < (NOW() - INTERVAL 7 DAY)    -- Condition 1
  AND DATE(C.earlier_date) BETWEEN (CURRENT_DATE() - INTERVAL 1 MONTH) AND CURRENT_DATE()  -- Condition 2
  AND b.promo_code IS NOT NULL;   -- Condition 3



-- =====================================================
-- Query 5: Target customers after every 3rd order
-- Requirement: Growth team trigger for personalized ads
-- =====================================================

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_code ORDER BY placed_at) AS rn
    FROM book.orders
) AS p
WHERE rn % 3 = 0
  AND DATE(placed_at) = CURDATE();



-- =====================================================
-- Query 6: Customers with more than 1 order and all orders on promo
-- =====================================================

SELECT 
    customer_code,
    COUNT(promo_code) AS no_of_promo,
    COUNT(*) AS no_of_orders
FROM book.orders
GROUP BY customer_code
HAVING COUNT(*) > 1 
   AND COUNT(*) = COUNT(promo_code);
