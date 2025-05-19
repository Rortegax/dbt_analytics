WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'order_items') }}
),

renamed_casted AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
        , {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id
        , quantity::NUMERIC AS quantity
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_order_items
)

SELECT * FROM renamed_casted
