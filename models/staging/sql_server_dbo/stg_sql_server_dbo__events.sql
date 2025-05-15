WITH base AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__events') }}
)

SELECT
    event_id,
    event_type_id,
    event_type,
    page_url,
    user_id,
    session_id,
    CONVERT_TIMEZONE('{{var('timezone')}}', created_at::TIMESTAMP) AS created_at, -- Pensar si hacer un macro
    is_deleted,
    date_loaded
FROM base