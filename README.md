# SQL-Data-Warehouse-Project
# 🏢 End-to-End SQL Data Warehouse & ETL Pipeline

## 📝 Project Overview
This project is a comprehensive Data Warehouse built from scratch using SQL Server. It demonstrates a complete ETL (Extract, Transform, Load) pipeline that ingests raw operational data (CRM and ERP systems) and processes it through a multi-layered architecture to create a presentation-ready Star Schema for business intelligence and analytics.

The architecture follows the industry-standard Medallion structure:
*   **🥉 Bronze Layer:** Raw, unprocessed data ingested directly from source systems.
*   **🥈 Silver Layer:** Cleansed, normalized, and transformed data. This layer includes rigorous data quality checks, standardization of formats (e.g., dates and strings), and business logic calculations using stored procedures.
*   **🥇 Gold Layer:** The analytical presentation layer. Data is modeled into a Star Schema containing **Fact** and **Dimension** views (`fact_sales`, `dim_customers`, `dim_products`), optimized for reporting, aggregation, and statistical analysis.

## 🛠️ Tech Stack & Skills Demonstrated
*   **Database:** Microsoft SQL Server (T-SQL)
*   **Architecture:** Medallion Architecture (Bronze, Silver, Gold), Star Schema (Fact & Dimension modeling)
*   **Data Engineering:** Stored Procedures, Error Handling (`TRY...CATCH`), Window Functions (`ROW_NUMBER`, `LEAD`), and dynamic ETL loading scripts.
*   **Data Quality:** Automated Data Quality (DQ) checks for referential integrity, uniqueness, and business logic validation.

## 👨‍💻 About Me
Hi, I'm **Hassan Raiss**. 

I am an independent data analyst with a strong focus on advanced SQL, statistical thinking, and understanding the underlying business logic of data. I believe in practical, hands-on learning over pure theory. Instead of just reading textbooks, I focus my time on configuring local server environments, designing rigorous test cases, and solving complex business scenarios using real-world datasets. 

I built this project to demonstrate my ability to take raw, messy data and engineer it into a reliable, structured format that drives true analytical value.

## 🙌 Acknowledgments
A special and massive thank you to **Baraa Khatib Silkini** for the incredible guidance, knowledge, and inspiration. Your teachings have been instrumental in shaping my understanding of data engineering and architecture!
