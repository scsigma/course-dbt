{{
    config(
        materialized = 'table'
    )
}}


with source as (
    select * from {{ source('postgres', 'orders') }}
)

, renamed_recast as (
    select 
        order_id as order_guid
        , user_id as order_user_guid
        , promo_id as order_promo_guid
        , address_id as order_address_guid
        , created_at as order_created_at
        , order_cost
        , shipping_cost as order_shipping_cost
        , order_total
        , tracking_id as order_tracking_guid
        , shipping_service as order_shipping_service
        , estimated_delivery_at as order_estimated_delivery_at
        , delivered_at as order_delivered_at
        , status as order_status
    from source
)

select * from renamed_recast