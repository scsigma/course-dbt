with source as (
    select * from {{ source('postgres', 'events')}}
)

