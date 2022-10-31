/*
NOTE: 
conversion rate is defined as 
the # of unique sessions with a purchase event / 
    -
total number of unique sessions.
    -
 Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product

 Enrich
*/
{{
    config(
        materialized='table'
    )
}}

-- WITH orders_source AS (
--     SELECT * FROM {{ ref('stg_postgres__products') }}
-- ),
-- order_items AS (
--     SELECT * FROM {{ ref('_int_orders') }}
-- --),

select 
    count(distinct order_id) AS orders,
    count(distinct session_id) AS unique_sessions,
    orders/unique_sessions AS conversion_rate

    -- order info

from
    STG_POSTGRES__EVENTS AS events
  