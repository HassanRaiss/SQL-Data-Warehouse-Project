/*
===============================================================================
Script Purpose: Initialize DataWarehouse Database
Description: 
    This script sets up the 'DataWarehouse' database environment for a multi-layered 
    data architecture (Bronze, Silver, Gold).
    
    Key Actions:
    1. Checks if the database already exists and drops it to allow a fresh setup.
    2. Creates the 'DataWarehouse' database.
    3. Sets up three key schemas representing the data warehouse layers:
       - bronze: Raw, unprocessed source data
       - silver: Cleaned, transformed, and normalized data
       - gold:  Aggregated business-ready data for reporting/analytics

WARNING:
    Executing this script will drop the existing 'DataWarehouse' database 
    and permanently delete all stored data.
===============================================================================
*/


-- Check if the 'DataWarehouse' database already exists before creating it.
-- If it exists, drop it to ensure a clean setup (remove this section if you wish to keep existing data).
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END
GO

-- Create Database 'DataWarehouse'
USE master;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create target schemas for data warehousing layers
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
