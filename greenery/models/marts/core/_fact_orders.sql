{{
    config(
        materialized='table'
    )
}}

WITH orders AS (
    SELECT * FROM {{ ref('_int_orders') }}
),
orders_products AS(
    SELECT * FROM {{ ref('_int_orders_products') }}
)

SELECT  orders.ORDER_ID

FROM orders