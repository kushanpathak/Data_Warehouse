/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
BEGIN
    batch_start_time := NOW();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '================================================';

    ------------------------------------------------
    -- CRM TABLES
    ------------------------------------------------
    RAISE NOTICE 'Loading CRM Tables';

    -- =========================
    start_time := NOW();
    RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;

    RAISE NOTICE '>> Inserting Data Into: bronze.crm_cust_info';
    EXECUTE format($f$
        COPY bronze.crm_cust_info
        FROM 'C:\Program Files\PostgreSQL\15\data\datasets\source_crm\cust_info.csv'
        DELIMITER ','
        CSV HEADER
    $f$);

    end_time := NOW();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time));

    -- =========================
    start_time := NOW();
    RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;

    RAISE NOTICE '>> Inserting Data Into: bronze.crm_prd_info';
    EXECUTE format($f$
        COPY bronze.crm_prd_info
        FROM 'C:\Program Files\PostgreSQL\15\data\datasets\source_crm\prd_info.csv'
        DELIMITER ','
        CSV HEADER
    $f$);

    end_time := NOW();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time));

    -- =========================
    start_time := NOW();
    RAISE NOTICE '>> Truncating Table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;

    RAISE NOTICE '>> Inserting Data Into: bronze.crm_sales_details';
    EXECUTE format($f$
        COPY bronze.crm_sales_details
        FROM 'C:\Program Files\PostgreSQL\15\data\datasets\source_crm\sales_details.csv'
        DELIMITER ','
        CSV HEADER
    $f$);

    end_time := NOW();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time));

    ------------------------------------------------
    -- ERP TABLES
    ------------------------------------------------
    RAISE NOTICE 'Loading ERP Tables';

    -- =========================
    start_time := NOW();
    TRUNCATE TABLE bronze.erp_loc_a101;

    EXECUTE format($f$
        COPY bronze.erp_loc_a101
        FROM 'C:\Program Files\PostgreSQL\15\data\datasets\source_erp\LOC_A101.csv'
        DELIMITER ','
        CSV HEADER
    $f$);

    end_time := NOW();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time));

    -- =========================
    start_time := NOW();
    TRUNCATE TABLE bronze.erp_cust_az12;

    EXECUTE format($f$
        COPY bronze.erp_cust_az12
        FROM 'C:\Program Files\PostgreSQL\15\data\datasets\source_erp\CUST_AZ12.csv'
        DELIMITER ','
        CSV HEADER
    $f$);

    end_time := NOW();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time));

    -- =========================
    start_time := NOW();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    EXECUTE format($f$
        COPY bronze.erp_px_cat_g1v2
        FROM 'C:\Program Files\PostgreSQL\15\data\datasets\source_erp\PX_CAT_G1V2.csv'
        DELIMITER ','
        CSV HEADER
    $f$);

    end_time := NOW();
    RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time));

    ------------------------------------------------
    -- FINAL LOG
    ------------------------------------------------
    batch_end_time := NOW();

    RAISE NOTICE '==========================================';
    RAISE NOTICE 'Loading Bronze Layer is Completed';
    RAISE NOTICE 'Total Load Duration: % seconds',
        EXTRACT(EPOCH FROM (batch_end_time - batch_start_time));
    RAISE NOTICE '==========================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '==========================================';
        RAISE NOTICE 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        RAISE NOTICE 'Error Message: %', SQLERRM;
        RAISE NOTICE '==========================================';
END;
$$;
