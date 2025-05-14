SELECT
    {{ dbt_utils.generate_surrogate_key(['event_id']) }} AS event_id,
    page_url,
    {{ dbt_utils.generate_surrogate_key(['event_type']) }} AS event_type_id,
    INITCAP(REGEXP_REPLACE(event_type, '[^a-zA-Z0-9]+', ' ')) as event_type,
    user_id,
    product_id,
    order_id,
    session_id,
    created_at,
    {{ format_fivetran_fields('_fivetran_deleted', '_fivetran_synced') }}
FROM {{ source('sql_server_dbo', 'events') }}
ORDER BY created_at