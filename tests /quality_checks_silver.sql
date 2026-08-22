-- ============================================================================
-- 1. CRM SYSTEM - DATA QUALITY CHECKS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Table: silver.crm_cust_info
-- ----------------------------------------------------------------------------
-- Check 1: Deduplication (Should return 0 rows)
SELECT cst_id, COUNT(*) AS duplicate_count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

-- Check 2: Whitespace Cleansing (Should return 0 rows)
SELECT cst_firstname, cst_lastname 
FROM silver.crm_cust_info 
WHERE cst_firstname != TRIM(cst_firstname) 
   OR cst_lastname != TRIM(cst_lastname);

-- Check 3: Data Standardization (Review outputs to ensure only allowed values exist)
SELECT DISTINCT cst_material_status FROM silver.crm_cust_info; -- Expect: Single, Married, n/a
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info;            -- Expect: Female, Male, n/a

-- ----------------------------------------------------------------------------
-- Table: silver.crm_prd_info
-- ----------------------------------------------------------------------------
-- Check 1: Null Replacement (Should return 0 rows)
SELECT COUNT(*) AS null_costs 
FROM silver.crm_prd_info 
WHERE prd_cost IS NULL;

-- Check 2: Date Logic (Should return 0 rows - End date shouldn't be before Start date)
SELECT * 
FROM silver.crm_prd_info 
WHERE prd_end_dt < prd_start_dt;

-- Check 3: Data Standardization (Review outputs to ensure only allowed values exist)
SELECT DISTINCT prd_line FROM silver.crm_prd_info; -- Expect: Mountain, Road, Other Sales, Touring, n/a

-- ----------------------------------------------------------------------------
-- Table: silver.crm_sales_details
-- ----------------------------------------------------------------------------
-- Check 1: Math/Business Logic (Should return 0 rows - Ensures sales = qty * price)
SELECT * 
FROM silver.crm_sales_details 
WHERE sls_sales != (sls_quantity * sls_price)
   OR sls_sales <= 0 
   OR sls_price <= 0 
   OR sls_quantity <= 0;

-- Check 2: Date Logic (Should return 0 rows - Order date shouldn't be after Ship date)
SELECT sls_order_dt, sls_ship_dt 
FROM silver.crm_sales_details 
WHERE sls_order_dt > sls_ship_dt;


-- ============================================================================
-- 2. ERP SYSTEM - DATA QUALITY CHECKS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Table: silver.erp_cust_az12
-- ----------------------------------------------------------------------------
-- Check 1: Prefix Removal (Should return 0 rows)
SELECT cid 
FROM silver.erp_cust_az12 
WHERE cid LIKE 'NAS%';

-- Check 2: Date Cleansing (Should return 0 rows - No future birthdays)
SELECT bdate 
FROM silver.erp_cust_az12 
WHERE bdate > GETDATE();

-- Check 3: Data Standardization (Review outputs to ensure only allowed values exist)
SELECT DISTINCT gen FROM silver.erp_cust_az12; -- Expect: Female, Male, n/a

-- ----------------------------------------------------------------------------
-- Table: silver.erp_loc_a101
-- ----------------------------------------------------------------------------
-- Check 1: Character Removal (Should return 0 rows - No hyphens)
SELECT cid 
FROM silver.erp_loc_a101 
WHERE cid LIKE '%-%';

-- Check 2: Data Standardization (Review outputs to ensure only allowed values exist)
SELECT DISTINCT cntry FROM silver.erp_loc_a101; -- Expect: Germany, United States, n/a

-- ----------------------------------------------------------------------------
-- Table: silver.erp_px_cat_g1v2
-- ----------------------------------------------------------------------------
-- Check 1: Whitespace Cleansing (Should return 0 rows)
SELECT * 
FROM silver.erp_px_cat_g1v2 
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat);
