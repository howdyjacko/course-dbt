{{
    config(
        materialized='table'
    )
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg_postgres__orders') }}
),
users AS (
    SELECT * FROM {{ ref('stg_postgres__users') }}
),
addresses AS (
    SELECT * FROM {{ ref('stg_postgres__addresses') }}
),
promos AS (
    SELECT * FROM {{ ref('stg_postgres__promos') }}
)

SELECT  orders.ORDER_ID
        ,orders.USER_ID
        ,orders.CREATED_AT
        ,users.PHONE_NUMBER
        ,promos.PROMO_ID
        ,COALESCE(promos.DISCOUNT,0) AS PROMO_DISCOUNT
        ,addresses.ADDRESS AS SHIPPING_STREET_ADDRESS
        ,addresses.ZIPCODE AS SHIPPING_ZIPCODE
        ,addresses.STATE AS SHIPPING_STATE
        ,addresses.COUNTRY AS SHIPPING_COUNTRY
        ,orders.ORDER_COST
        ,orders.SHIPPING_COST
        ,orders.ORDER_TOTAL
        ,orders.SHIPPING_SERVICE

FROM orders
LEFT JOIN users ON orders.USER_ID = users.USER_ID
LEFT JOIN addresses ON addresses.ADDRESS_ID = users.ADDRESS_ID
LEFT JOIN promos ON orders.PROMO_ID = promos.PROMO_ID

/*        ,TIMESTAMPDIFF('day',orders.ORDER_CREATED_AT_UTC,orders.ORDER_ESTIMATED_DELIVERY_AT_UTC) AS ESTIMATED_DAYS_FOR_DELIVERY
        ,orders.ORDER_STATUS
        ,orders.ORDER_DELIVERED_AT_UTC
        ,TIMESTAMPDIFF('day',orders.ORDER_CREATED_AT_UTC,orders.ORDER_DELIVERED_AT_UTC) AS ACTUAL_DAYS_FOR_DELIVERY

*/