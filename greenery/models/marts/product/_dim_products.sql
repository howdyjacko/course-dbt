{{
    config(
        materialized='table'
    )
}}

WITH products AS (
    SELECT * FROM {{ ref('stg_postgres__products') }}
),
orders AS (
    SELECT * FROM {{ ref('_int_orders') }}
),
order_items AS (
    SELECT * FROM {{ ref('stg_postgres__order_items') }}
)

SELECT  products.PRODUCT_ID
        ,products.NAME
        ,products.PRICE
        ,IFNULL(products.INVENTORY,0) AS CURRENT_PRODUCT_INVENTORY
        ,IFNULL(COUNT(DISTINCT orders.ORDER_ID),0) AS DISTINCT_ORDERS
        ,IFNULL(SUM(orders.ORDER_TOTAL),0) AS PRODUCT_REVENUE
FROM products
LEFT JOIN order_items ON order_items.PRODUCT_ID = products.PRODUCT_ID
LEFT JOIN orders ON orders.ORDER_ID = order_items.ORDER_ID

GROUP BY    products.PRODUCT_ID
            ,products.NAME
            ,products.PRICE
            ,CURRENT_PRODUCT_INVENTORY

/*        ,IFNULL(SUM(orders.QUANTITY_ORDERED),0) AS QUANTITY_SOLD */
/*       No direct realtionship between orders and products */