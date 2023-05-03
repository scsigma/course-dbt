{{
    config(
        materialized='table'
    )
}}

with users as (
    select * from {{ ref('stg_postgres_users')}}
)
, addresses as (
    select 
        address_guid as address_guid_join
        , address
        , state
        , zip_code
        , country
    from {{ ref('stg_postgres_addresses') }}

)

, final as (
    select * from users
    left join addresses
    on users.user_address_guid = addresses.address_guid_join
)

select * from final