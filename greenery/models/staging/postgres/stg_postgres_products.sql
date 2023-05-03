{{ 
    config(
        materialized = 'table'
    )
}}

with source as (
    select * from {{ source('postgres', 'products') }}
)

, renamed_recast as (
    select 
        product_id as product_guid
        , name as product_name
        , price as product_price
        , inventory as product_inventory
    from source
)

select * from renamed_recast