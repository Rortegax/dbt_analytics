-- DIM PRODUCTS
WITH stg_products AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
),

dim_products AS (
    SELECT
        product_id
        , product_name
        , product_in_inventory
    FROM stg_products
)

SELECT * FROM dim_products