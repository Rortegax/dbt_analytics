WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
          _row::INT AS id_budget
        , quantity::NUMERIC AS quantity
        , month::DATE AS date
        , YEAR(month)::INT AS year
        , MONTH(month)::INT AS month
        , TO_CHAR(month, 'Month')::VARCHAR AS month_name -- Poner macro si eso, que traduzca los nombres a cristiano.
        , {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id
        , {{ format_fivetran_fields('_fivetran_synced') }}
    FROM src_budget
    )

SELECT * FROM renamed_casted