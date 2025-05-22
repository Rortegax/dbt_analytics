-- DIM ADDRESSES
WITH stg_addresses AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__address') }}
),

dim_address AS (
    SELECT
        address_id
        , address
        , zipcode
        , country
        , state
    FROM stg_addresses
)

SELECT * FROM dim_address