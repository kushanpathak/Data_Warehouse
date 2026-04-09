# Data_Warehouse
Build a data warehouse with Medallion Architecture including ETL process

# 📊 Data Warehouse Project (PostgreSQL + Power BI)

## 🚀 Overview

This project demonstrates an end-to-end **Data Warehouse solution** built using a **layered architecture (Bronze → Silver → Gold)**.

It covers:

* Data ingestion from CSV files
* Data cleaning and transformation
* Dimensional modeling (Star Schema)
* Analytics-ready views for reporting
* Integration with Power BI

---

## 🏗️ Architecture

### 🔹 Bronze Layer (Raw Data)

* Raw data ingested from CSV files
* Minimal transformation
* Tables:

  * crm_cust_info
  * crm_prd_info
  * crm_sales_details
  * erp_cust_az12
  * erp_loc_a101
  * erp_px_cat_g1v2

---

### 🔹 Silver Layer (Cleaned Data)

* Data cleansing and standardization
* Handling nulls, duplicates, and invalid values
* Business rules applied:

  * Standardized gender & marital status
  * Fixed invalid dates
  * Recalculated sales & price
* Tables:

  * crm_cust_info
  * crm_prd_info
  * crm_sales_details
  * erp_cust_az12
  * erp_loc_a101
  * erp_px_cat_g1v2

---

### 🔹 Gold Layer (Analytics / Star Schema)

* Business-ready data model
* Created as **views**

#### Dimensions:

* `dim_customers`
* `dim_products`

#### Fact Table:

* `fact_sales`

---

## 🧠 Data Model

Star Schema:

* **fact_sales**

  * order_number
  * product_key
  * customer_key
  * sales_amount
  * quantity

* **dim_customers**

  * customer_key
  * customer_id
  * name, gender, country

* **dim_products**

  * product_key
  * product_name
  * category, subcategory

---

## ⚙️ Tech Stack

* PostgreSQL
* SQL (ETL + Transformations)
* Power BI (Visualization)
* CSV (Data Source)

---

## 🔄 ETL Process

1. **Extract**

   * Load CSV files into Bronze layer

2. **Transform**

   * Clean and standardize data in Silver layer
   * Apply business rules

3. **Load**

   * Create Gold layer views for reporting

---

## 📊 Power BI Integration

* Connected directly to Gold layer views:

  * dim_customers
  * dim_products
  * fact_sales

* Built relationships:

  * fact_sales → dim_customers
  * fact_sales → dim_products

* Example dashboards:

  * Sales by Country
  * Top Products
  * Customer Analysis

---

## 🧪 Key Features

✔ Layered data architecture
✔ Data cleaning & validation
✔ Deduplication using window functions
✔ Surrogate key generation
✔ Star schema modeling
✔ Ready for BI tools

---

## 📂 Project Structure

```
project/
│
├── datasets/
│   ├── source_crm/
│   └── source_erp/
│
├── sql/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── powerbi/
│   └── dashboard.pbix
│
└── README.md
```

---

## 🚀 How to Run

1. Create schemas:

```sql
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
```

2. Load data into Bronze layer (CSV → tables)

3. Run Silver layer transformations

4. Create Gold layer views

5. Connect Power BI to PostgreSQL

---

## 📈 Future Improvements

* Add indexes for performance
* Convert views to materialized views
* Add incremental load logic
* Implement scheduling (Airflow / cron)

---

## 🙌 Author

**Kushan Pathak**

---

## ⭐ If you found this useful

Give this repo a ⭐ and feel free to connect!
