WITH src_users AS (

    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}

),

renamed_casted as (

    SELECT
        {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
        , first_name::VARCHAR AS first_name
        , last_name::VARCHAR AS last_name
        , {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id
        , phone_number::VARCHAR AS phone_number
        --, validate_phone('phone_number')
        , email::VARCHAR AS email
        --, validate_email('email')
        , created_at::DATE AS created_at
        , updated_at::DATE AS updated_at
        -- total_orders::INT AS total_orders, TODOS LOS REGISTROS SON NULOS, ASI QUE NO LA LLEVAMOS A STAGING
        , {{ format_fivetran_fields('_fivetran_synced','_fivetran_deleted') }}

    FROM src_users
    
)

SELECT * FROM renamed_casted
