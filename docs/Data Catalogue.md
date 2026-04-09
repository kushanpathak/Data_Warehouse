
# 📚 Data Catalog – Data Warehouse Project

## 🏗️ Overview

This data catalog documents all tables and views across the **Bronze, Silver, and Gold layers** of the data warehouse.

---

# 🥉 Bronze Layer (Raw Data)

## 1. bronze.crm_cust_info

| Column Name        | Data Type | Description           |
| ------------------ | --------- | --------------------- |
| cst_id             | INT       | Unique customer ID    |
| cst_key            | VARCHAR   | Customer business key |
| cst_firstname      | VARCHAR   | First name            |
| cst_lastname       | VARCHAR   | Last name             |
| cst_marital_status | VARCHAR   | Marital status (raw)  |
| cst_gndr           | VARCHAR   | Gender (raw)          |
| cst_create_date    | DATE      | Record creation date  |

---

## 2. bronze.crm_prd_info

| Column Name  | Data Type | Description  |
| ------------ | --------- | ------------ |
| prd_id       | INT       | Product ID   |
| prd_key      | VARCHAR   | Product key  |
| prd_nm       | VARCHAR   | Product name |
| prd_cost     | INT       | Product cost |
| prd_line     | VARCHAR   | Product line |
| prd_start_dt | DATE      | Start date   |

---

## 3. bronze.crm_sales_details

| Column Name  | Data Type | Description                  |
| ------------ | --------- | ---------------------------- |
| sls_ord_num  | VARCHAR   | Order number                 |
| sls_prd_key  | VARCHAR   | Product key                  |
| sls_cust_id  | INT       | Customer ID                  |
| sls_order_dt | INT       | Order date (YYYYMMDD format) |
| sls_ship_dt  | INT       | Ship date                    |
| sls_due_dt   | INT       | Due date                     |
| sls_sales    | INT       | Sales amount                 |
| sls_quantity | INT       | Quantity                     |
| sls_price    | INT       | Price                        |

---

## 4. bronze.erp_cust_az12

| Column Name | Data Type | Description |
| ----------- | --------- | ----------- |
| cid         | VARCHAR   | Customer ID |
| bdate       | DATE      | Birthdate   |
| gen         | VARCHAR   | Gender      |

---

## 5. bronze.erp_loc_a101

| Column Name | Data Type | Description  |
| ----------- | --------- | ------------ |
| cid         | VARCHAR   | Customer ID  |
| cntry       | VARCHAR   | Country code |

---

## 6. bronze.erp_px_cat_g1v2

| Column Name | Data Type | Description      |
| ----------- | --------- | ---------------- |
| id          | VARCHAR   | Category ID      |
| cat         | VARCHAR   | Category         |
| subcat      | VARCHAR   | Subcategory      |
| maintenance | VARCHAR   | Maintenance flag |

---

# 🥈 Silver Layer (Cleaned Data)

## 1. silver.crm_cust_info

| Column Name        | Description                       |
| ------------------ | --------------------------------- |
| cst_id             | Unique customer ID                |
| cst_key            | Customer key                      |
| cst_firstname      | Trimmed first name                |
| cst_lastname       | Trimmed last name                 |
| cst_marital_status | Standardized (Single/Married/n/a) |
| cst_gndr           | Standardized (Male/Female/n/a)    |
| cst_create_date    | Creation date                     |
| dwh_create_date    | Load timestamp                    |

---

## 2. silver.crm_prd_info

| Column Name  | Description               |
| ------------ | ------------------------- |
| prd_id       | Product ID                |
| cat_id       | Extracted category ID     |
| prd_key      | Product key               |
| prd_nm       | Product name              |
| prd_cost     | Cost (null handled)       |
| prd_line     | Standardized product line |
| prd_start_dt | Start date                |
| prd_end_dt   | Derived end date          |

---

## 3. silver.crm_sales_details

| Column Name  | Description            |
| ------------ | ---------------------- |
| sls_ord_num  | Order number           |
| sls_prd_key  | Product key            |
| sls_cust_id  | Customer ID            |
| sls_order_dt | Cleaned date           |
| sls_ship_dt  | Cleaned date           |
| sls_due_dt   | Cleaned date           |
| sls_sales    | Validated sales amount |
| sls_quantity | Quantity               |
| sls_price    | Derived price          |

---

## 4. silver.erp_cust_az12

| Column Name | Description         |
| ----------- | ------------------- |
| cid         | Cleaned customer ID |
| bdate       | Valid birthdate     |
| gen         | Standardized gender |

---

## 5. silver.erp_loc_a101

| Column Name | Description          |
| ----------- | -------------------- |
| cid         | Cleaned customer ID  |
| cntry       | Standardized country |

---

## 6. silver.erp_px_cat_g1v2

| Column Name | Description |
| ----------- | ----------- |
| id          | Category ID |
| cat         | Category    |
| subcat      | Subcategory |
| maintenance | Maintenance |

---

# 🥇 Gold Layer (Business Layer)

## 1. gold.dim_customers

| Column Name     | Description     |
| --------------- | --------------- |
| customer_key    | Surrogate key   |
| customer_id     | Customer ID     |
| customer_number | Business key    |
| first_name      | First name      |
| last_name       | Last name       |
| country         | Country         |
| marital_status  | Marital status  |
| gender          | Final gender    |
| birthdate       | Birthdate       |
| create_date     | Record creation |

---

## 2. gold.dim_products

| Column Name    | Description   |
| -------------- | ------------- |
| product_key    | Surrogate key |
| product_id     | Product ID    |
| product_number | Product key   |
| product_name   | Product name  |
| category_id    | Category ID   |
| category       | Category      |
| subcategory    | Subcategory   |
| maintenance    | Maintenance   |
| cost           | Product cost  |
| product_line   | Product line  |
| start_date     | Start date    |

---

## 3. gold.fact_sales

| Column Name   | Description         |
| ------------- | ------------------- |
| order_number  | Order ID            |
| product_key   | FK to dim_products  |
| customer_key  | FK to dim_customers |
| order_date    | Order date          |
| shipping_date | Ship date           |
| due_date      | Due date            |
| sales_amount  | Sales               |
| quantity      | Quantity            |
| price         | Price               |

---

# 🔗 Relationships

* fact_sales.customer_key → dim_customers.customer_key
* fact_sales.product_key → dim_products.product_key

---

# 📊 Business Usage

* Customer segmentation
* Sales trend analysis
* Product performance
* Country-level insights

---

# 🚀 Notes

* Bronze = Raw ingestion
* Silver = Cleaned & standardized
* Gold = Analytics-ready
