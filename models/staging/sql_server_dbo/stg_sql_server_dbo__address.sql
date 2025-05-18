WITH src_address AS (

    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}

),

renamed_casted as (

    SELECT
        {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id
        , zipcode::NUMERIC AS zipcode
        , country::VARCHAR AS country
        , address::VARCHAR AS address
        , state::VARCHAR AS state
        , {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}

    FROM src_address
)

SELECT * FROM renamed_casted