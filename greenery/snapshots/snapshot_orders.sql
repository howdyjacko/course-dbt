{% snapshot snapshot_orders %}

  {{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='order_id',
    check_cols=['status'],
    updated_at = 'created_at'
   )
}}

  SELECT * FROM {{ source('postgres','orders') }}

{% endsnapshot %}