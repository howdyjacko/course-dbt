{{
  config(
    materialized='table'
  )
}}

SELECT 
    *
FROM {{ ref('_stg_superheros') }}