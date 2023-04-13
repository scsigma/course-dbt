{{ 
    config(
        materialized = 'table'
    )
}}

with source as (
    select * from {{ source('postgres', 'users') }}
)

, renamed_recast as (
    select
        user_id as user_id_guid
        , first_name
        , last_name
        , email
        , phone_number
        , created_at
        , updated_at
        , address_id as address_id_guid
    from source
)

select * from renamed_recast