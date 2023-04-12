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
        event_id as event_id_guid
        , session_id as session_id_guid
        , user_id as user_id_guid
        , page_url
        , created_at
        , event_type
        , order_id as order_id_guid
        , product_id as product_id_guid
    from source
)

select * from renamed_recast