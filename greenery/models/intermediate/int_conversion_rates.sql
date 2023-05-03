{{ 
    config(
        materialized = 'table'
    )
}}

with products as (
    select * from {{ ref('stg_postgres_products') }}
)

, events as (
    select * from {{ ref('stg_postgres_events') }}
)

, final as (
    select 
        p.product_guid
        , p.product_name
        , sum(case when e.event_type = 'page_view' then 1 else 0 end) as page_views
        , sum(case when e.event_type = 'checkout' then 1 else 0 end) as checkouts
        , sum(case when e.event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts
        , sum(case when e.event_type = 'package_shipped' then 1 else 0 end) as package_shippeds
    from 
        events e
        left join products p on e.event_product_guid = p.product_guid
    group by 1,2
) 

select * from final

