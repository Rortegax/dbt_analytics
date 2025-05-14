WITH base AS (
  SELECT * FROM {{ ref('base_sql_server_dbo__events') }}
)

SELECT
    DISTINCT
    event_type_id,
    event_type,
FROM base