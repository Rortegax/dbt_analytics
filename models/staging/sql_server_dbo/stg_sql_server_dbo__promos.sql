WITH src_promos AS (

    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}

    UNION ALL

    -- Insertamos una promo para cuando haya ordenes sin ella 'no_promo'
    SELECT 
        'no_promo' AS promo_id
        , 0 AS discount
        , 'inactive' AS status
        , null AS _fivetran_deleted
        ,  CURRENT_TIMESTAMP AS _fivetran_synced
    
),

promos_output AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id -- Generate a surrogate key (hash) to better identify PROMOS
        , promo_id::VARCHAR AS promo_desc
        , discount::NUMERIC(38,2) AS discounted_quantity
        , status::VARCHAR AS status
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}
    FROM src_promos
)

SELECT * FROM promos_output