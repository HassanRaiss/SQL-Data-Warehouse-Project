/*
===============================================================================
Script Name: quality_checks_gold.sql
Purpose:     
    Performs Data Quality (DQ) checks on the Gold Layer (Star Schema).
    Validates surrogate key uniqueness, referential integrity (foreign keys), 
    and overall business logic for presentation-ready views.
===============================================================================
*/

-- ============================================================================
-- 1. DIMENSION: gold.dim_customers
-- ============================================================================

-- Check 1: Surrogate Key Uniqueness 
-- (Should return 0 rows. If > 0, the ROW_NUMBER() logic failed or data duplicated)
SELECT customer_key, COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Check 2: Business Key Uniqueness 
-- (Should return 0 rows. Ensures one active record per customer_id)
SELECT customer_id, COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check 3: Data Completeness 
-- (Should return 0 rows. We shouldn't have customers without a core ID)
SELECT * 
FROM gold.dim_customers 
WHERE customer_id IS NULL 
   OR customer_number IS NULL;


-- ============================================================================
-- 2. DIMENSION: gold.dim_products
-- ============================================================================

-- Check 1: Surrogate Key Uniqueness 
-- (Should return 0 rows)
SELECT product_key, COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Check 2: Business Key Uniqueness 
-- (Should return 0 rows. Since we filtered out historical records, each product_number should appear only once)
SELECT product_number, COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_number
HAVING COUNT(*) > 1;


-- ============================================================================
-- 3. FACT: gold.fact_sales
-- ============================================================================

-- Check 1: Referential Integrity - Orphaned Customers
-- (Should return 0 rows. If > 0, there are sales tied to a customer that doesn't exist in dim_customers)
SELECT COUNT(*) AS orphaned_sales_customers
FROM gold.fact_sales
WHERE customer_key IS NULL;

-- Check 2: Referential Integrity - Orphaned Products
-- (Should return 0 rows. If > 0, there are sales tied to a product that doesn't exist in dim_products)
SELECT COUNT(*) AS orphaned_sales_products
FROM gold.fact_sales
WHERE product_key IS NULL;

-- Check 3: Math & Business Logic 
-- (Should return 0 rows. Verifying that the joins didn't distort the cleansed Silver math)
SELECT * 
FROM gold.fact_sales 
WHERE sales_amount != (quantity * price)
   OR sales_amount <= 0 
   OR price <= 0 
   OR quantity <= 0;

-- Check 4: Date Logic
-- (Should return 0 rows. Order dates should not be in the future, and orders shouldn't ship before they are placed)
SELECT order_number, order_date, shipping_date 
FROM gold.fact_sales 
WHERE order_date > GETDATE() 
   OR order_date > shipping_date;
