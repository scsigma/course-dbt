{{
    config(
        materialized = 'table'
    )
}}

with source as (
    select * from {{ source('postgres', 'events')}}
)

, renamed_recast as (
    select
        event_id as event_guid
        , session_id as event_session_guid
        , user_id as event_user_guid
        , page_url as event_page_url
        , created_at as event_created_at
        , event_type
        , order_id as event_order_guid
        , product_id as event_product_guid
    from source
)

select * from renamed_recast