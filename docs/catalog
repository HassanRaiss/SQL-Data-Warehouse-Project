# 🪙 Gold Layer Data Catalog

The Gold Layer represents the final, presentation-ready stage of the Data Warehouse. Structured as a **Star Schema**, it is optimized for business intelligence, reporting, and analytical queries.

---

## 📐 Schema Overview

* **Dimension Tables (`dim_`):** Descriptive business context (attributes for slicing/filtering).
* **Fact Tables (`fact_`):** Quantitative metrics and business transactions linked via surrogate keys.

---

## 📑 Data Dictionary

### 1. Customer Dimension (`gold.dim_customers`)

> **Purpose:** Holds cleansed and integrated customer profile data combining CRM and ERP systems.

| Column Name | Data Type | Key Type | Description |
| :--- | :--- | :--- | :--- |
| `customer_key` | `INT` | **PK** | Surrogate key generated via `ROW_NUMBER()` |
| `customer_id` | `INT` | — | Original CRM identifier |
| `customer_number` | `NVARCHAR(50)` | **BK** | Alternate business key (`cst_key`) from CRM |
| `first_name` | `NVARCHAR(50)` | — | Customer first name (standardized) |
| `last_name` | `NVARCHAR(50)` | — | Customer last name (standardized) |
| `country` | `NVARCHAR(50)` | — | Country of residence (ERP) |
| `marital_status` | `NVARCHAR(50)` | — | Marital status ('Single', 'Married', 'n/a') |
| `gender` | `NVARCHAR(50)` | — | Gender (CRM primary, ERP fallback) |
| `birthdate` | `DATE` | — | Date of birth (ERP) |
| `create_date` | `DATE` | — | Original account creation date |

---

### 2. Product Dimension (`gold.dim_products`)

> **Purpose:** Tracks active product attributes, categories, and hierarchies.

| Column Name | Data Type | Key Type | Description |
| :--- | :--- | :--- | :--- |
| `product_key` | `INT` | **PK** | Surrogate key generated via `ROW_NUMBER()` |
| `product_id` | `INT` | — | Original CRM product identifier |
| `product_number` | `NVARCHAR(50)` | **BK** | Alternate business key (`prd_key`) from CRM |
| `product_name` | `NVARCHAR(50)` | — | Descriptive name of the product |
| `category_id` | `NVARCHAR(50)` | — | Category ID extracted from product key |
| `category` | `NVARCHAR(50)` | — | Main category (ERP) |
| `subcategory` | `NVARCHAR(50)` | — | Subcategory (ERP) |
| `maintenance` | `NVARCHAR(50)` | — | Maintenance flag/schedule (ERP) |
| `cost` | `INT` | — | Standard unit cost |
| `product_line` | `NVARCHAR(50)` | — | Product line (e.g., 'Mountain', 'Road') |
| `start_date` | `DATE` | — | Effective start date of current record |

---

### 3. Sales Fact Table (`gold.fact_sales`)

> **Purpose:** Stores sales transactions and key business measures for reporting.

| Column Name | Data Type | Key Type | Description |
| :--- | :--- | :--- | :--- |
| `order_number` | `NVARCHAR(50)` | — | Transaction/Order identifier |
| `product_key` | `INT` | **FK** | Links to `gold.dim_products` |
| `customer_key` | `INT` | **FK** | Links to `gold.dim_customers` |
| `order_date` | `DATE` | — | Date order was placed |
| `shipping_date` | `DATE` | — | Date product was shipped |
| `due_date` | `DATE` | — | Date payment/delivery is due |
| `sales_amount` | `INT` | — | Total sale value (`quantity * price`) |
| `quantity` | `INT` | — | Number of units purchased |
| `price` | `INT` | — | Unit price at time of sale |
