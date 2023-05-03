{{
    config(
        materialized = 'table'
    )
}}

with source as (
    select * from {{ source('postgres', 'order_items')}}
)

, renamed_recast as (
    select
        order_id as order_item_order_guid
        , product_id as order_item_product_guid
        , quantity as order_item_quantity
    from source
)

select * from renamed_recast