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

SELECT  orders.ORDER_GUID
        ,order_items.PRODUCT_GUID
        ,order_items.QUANTITY_ORDERED
        ,products.PRODUCT_NAME
        ,products.PRODUCT_PRICE
        ,order_items.QUANTITY_ORDERED
FROM orders
LEFT JOIN order_items ON orders.ORDER_GUID = order_items.ORDER_GUID
LEFT JOIN products ON order_items.PRODUCT_GUID = products.PRODUCT_GUID