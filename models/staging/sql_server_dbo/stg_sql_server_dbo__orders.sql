/* No establecemos una configuracion de base, ya que va a ser una vista y esa viene por defecto 
{{
  config(
    materialized='table'
  )
}}
*/

-- CTE rara antes de los casteos, por si tenemos que referenciar varias veces los datos
WITH stg_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }} -- Codigo JINJA(TAKATAKA)
),

renamed_casted AS (
    SELECT
        order_id, 
        shipping_service,
        shipping_cost_usd,
        address_id,
        created_at_utc,
        promo_id,
        estimated_delivery_at_utc,
        item_order_cost_usd,
        user_id,
        total_order_cost_usd,
        delivered_at_utc,
        tracking_id,
        status_order,
        DATEDIFF(day, created_at_utc, delivered_at_utc) AS days_to_deliver,
        date_load
    FROM stg_orders
    )

SELECT * FROM renamed_casted