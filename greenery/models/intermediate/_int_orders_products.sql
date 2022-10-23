{{
    config(
        materialized='table'
    )
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg_postgres__orders') }}
),
order_items AS (
    SELECT * FROM {{ ref('stg_postgres__order_items') }}
),
products AS (
    SELECT * FROM {{ ref('stg_postgres__products') }}
)

SELECT  orders.ORDER_ID
FROM orders
LEFT JOIN order_items ON orders.ORDER_ID = order_items.ORDER_ID
LEFT JOIN products ON order_items.PRODUCT_ID = products.PRODUCT_ID