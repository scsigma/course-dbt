{{
    config(
        materialized = 'table'
    )
}}

with source as (
    select * from {{ ref('int_event_prod') }}
) 

, page_views as (
    select 
        date
        , product_id
        , product_name
        , price
        , count(distinct case when event_type = 'page_view' then event_type end) as page_views
        , count(distinct case when event_type = 'added_to_cart' then event_type end) as added_to_carts
        , count(distinct case when event_type = 'checkout' then event_type end) as checkouts
    from source
    where event_type in ('page_view','added_to_cart','checkout')
    and date is not null
    and product_id is not null
    and product_name is not null
    and price is not null
    group by 1,2,3,4
)

select * from page_views
