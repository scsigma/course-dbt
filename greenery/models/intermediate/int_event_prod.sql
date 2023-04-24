{{ 
    config(
        materialized = 'table'
    )
}}

with events as (
    select * from {{ ref('stg_postgres_events') }}
) 

, products as (
    select * from {{ ref('stg_postgres_products') }}
) 


select
    events.created_at as date
    , products.product_id_guid as product_id
    , products.name as product_name
    , products.price as price
    , events.event_type as event_type
from events
left join products
on events.product_id_guid = products.product_id_guid
