WITH src_users AS (

    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    SELECT
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS user_id::,
        CONVERT_TIMEZONE('{{var('timezone')}}', updated_at)::TIMESTAMP AS updated_at,
        address_id::VARCHAR AS address_id,
        last_name::VARCHAR AS last_name,
        CONVERT_TIMEZONE('{{var('timezone')}}', created_at)::TIMESTAMP AS created_at,
        phone_number::VARCHAR, -- Test telefono (regex)
        -- total_orders::INT AS total_orders, TODOS LOS REGISTROS SON NULOS, ASI QUE NO LA LLEVAMOS A STAGING
        first_name::VARCHAR,
        email::VARCHAR,
        {{ format_fivetran_columns('_fivetran_deleted','_fivetran_synced') }}

    FROM source
    
)

SELECT * FROM renamed
