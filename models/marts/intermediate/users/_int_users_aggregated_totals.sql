/* 
Modelo intermedio para sacar 3 metricas de orders agregadas por usuario.
En el mart final, quiero unir orders con order_items, asi que hago los calculos en este paso,
que es mas barato. Y luego los agregare a la dimension usuario. 
*/
WITH stg_orders AS (
    SELECT 
        user_id,
        order_total
    FROM {{ ref('stg_sql_server_dbo__orders') }}
),

aggregated_users AS (
    SELECT
        user_id,
        COUNT(order_id) AS total_orders, -- Cantidad de pedidos por usuario
        SUM(order_total) AS total_spent, -- Gasto total por usuario
        AVG(order_total) AS avg_spent_per_order -- Gasto promedio por pedido
    FROM stg_orders
    GROUP BY user_id
)

SELECT * FROM aggregated_users
