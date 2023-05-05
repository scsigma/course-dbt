{{
    config(
        materialized = 'table'
    )
}}

with session_events as (
    select * from {{ ref('int_session_events_agg')}}
)

, products as (
    select * from {{ ref('stg_postgres_products') }}
)

, checkouts as (
    select * from {{ ref('int_checkout_orders') }}
)


, joined as (
    select session_events.*, products.*, checkouts.event_session_guid as event_session_checkout
    from session_events
    left join products
    on session_events.event_product_guid = products.product_guid
    left join checkouts
    on  session_events.event_product_guid = checkouts.order_item_product_guid
)

, purchase_sessions as (
    select event_session_guid from joined
    where product_name is null
)

, final as (
    select 
        joined.*
        , case when purchase_sessions.event_session_guid is not null and joined.total_add_to_carts > 0 then 1 else 0 end as purchased
    from joined
    left join purchase_sessions 
    on joined.event_session_guid = purchase_sessions.event_session_guid
)


select * from final