{{
    config(
        materialized = 'table'
    )
}}

with events as (
    select * from {{ ref('stg_postgres_events') }}
)

, final as (
    select 
        user_id_guid as event_user_guid
        , session_id_guid as event_session_guid
        , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts
        , sum(case when event_type = 'checkouts' then 1 else 0 end) as checkouts
        , sum(case when event_type = 'package_shippeds' then 1 else 0 end) as package_shippeds
        , sum(case when event_type = 'page_views' then 1 else 0 end) as page_views
        , min(created_at) as first_session_event_at_utc
        , max(created_at) as last_session_event_at_utc
    from events
    group by 1,2
)

select * from final