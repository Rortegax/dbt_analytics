WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

renamed_casted AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id
        , price::numeric(38,2) AS price
        , name::VARCHAR AS name
        , inventory::INT AS inventory
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_products
    )

SELECT * FROM renamed_casted