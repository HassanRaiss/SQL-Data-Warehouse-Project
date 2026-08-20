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
