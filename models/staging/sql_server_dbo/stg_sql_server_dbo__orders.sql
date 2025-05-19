 -- CTE rara antes de los casteos, para poder acceder a los datos de las fuentes
WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }} -- Codigo JINJA(TAKATAKA)
),

renamed_casted AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
        , shipping_service::VARCHAR AS shipping_service
        , shipping_cost::NUMERIC(38,2) AS shipping_cost
        , {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id
        , {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id
        , created_at::DATE AS created_at -- Nuevo campo para created_at, que es solo de tipo date
        , {{ format_dates('created_at', var('timezone')) }} AS created_at_timestamp
        , estimated_delivery_at::DATE AS estimated_delivery_at -- Nuevo campo para estimated_delivery, que es solo de tipo date
        , {{ format_dates('estimated_delivery_at', var('timezone')) }} AS estimated_delivery_at_timestamp
        , order_cost::NUMERIC(38,2) AS order_cost
        , {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
        , order_total::NUMERIC(38,2) AS order_total
        , delivered_at::DATE AS delivered_at
        , {{ format_dates('delivered_at', var('timezone')) }} AS delivered_at_timestamp
        , tracking_id::VARCHAR AS tracking_id
        , status::VARCHAR AS status
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_orders
)

SELECT * FROM renamed_casted