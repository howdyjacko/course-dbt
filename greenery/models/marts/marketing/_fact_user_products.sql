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
),
users AS(
    SELECT * FROM {{ ref('stg_postgres__users') }}
)

SELECT  orders.USER_ID
        ,users.FIRST_NAME
        ,users.EMAIL
        ,users.LAST_NAME
        ,orders.ORDER_ID
        ,orders.CREATED_AT
FROM orders
LEFT JOIN orders_products ON orders.ORDER_ID = orders_products.ORDER_ID
LEFT JOIN users ON orders.USER_ID = users.USER_ID

/*        ,orders_products.QUANTITY_ORDERED
        ,orders_products.PRODUCT_NAME
        ,orders_products.PRODUCT_PRICE
        ,orders_products.PRODUCT_SUBTOTAL 
If you want to add these order columns, add them under SELECT section in _int_orders_products.sql with correct names

        */