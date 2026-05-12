USE master;
GO
IF DB_ID('Amazon_DWH') IS NULL CREATE DATABASE Amazon_DWH;
GO
USE Amazon_DWH;
GO
CREATE SCHEMA dwh;
GO

-- 1) ÃœÊ· «· «—ÌŒ
CREATE TABLE dwh.dim_date (
    date_key INT PRIMARY KEY, -- YYYYMMDD
    full_date DATE,
    year_number INT,
    month_name NVARCHAR(20)
);

-- 2) ÃœÊ· «·⁄„·«¡
CREATE TABLE dwh.dim_customer (
    customer_key INT IDENTITY(1,1) PRIMARY KEY, -- «·—ﬁ„ «· ·ﬁ«∆Ì
    customer_id NVARCHAR(50), -- «·ﬂÊœ «··Ì Ã«Ì „‰ √„«“Ê‰
    customer_name NVARCHAR(255),
    city NVARCHAR(100),
    state_name NVARCHAR(100),
    country_name NVARCHAR(100)
);

-- 3) ÃœÊ· «·„‰ Ã« 
CREATE TABLE dwh.dim_product (
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id NVARCHAR(50),
    product_name NVARCHAR(255),
    category_name NVARCHAR(100),
    brand_name NVARCHAR(100)
);

-- 4) ÃœÊ· «·ÿ·»«  («·‹ Fact)
CREATE TABLE dwh.fact_orders (
    fact_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(50),
    customer_key INT, -- „—»Êÿ »«·‹ Key „‘ «·‹ ID
    product_key INT,
    date_key INT,
    quantity INT,
    total_amount DECIMAL(18,2),
    net_profit DECIMAL(18,2),
    
    CONSTRAINT FK_Customer FOREIGN KEY (customer_key) REFERENCES dwh.dim_customer(customer_key),
    CONSTRAINT FK_Product FOREIGN KEY (product_key) REFERENCES dwh.dim_product(product_key)
);
GO