with source as (
    {{ source('postgres', 'order_items')}}
)

, renamed_recast as (
    select
    
    from source
)

select * from renamed_recast