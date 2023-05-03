{{ 
    config(
        materialized='table'
    )
}}


with session_events_agg as (
    select * from {{ ref('int_session_events_agg') }}
)

, final as (
    select 
        event_user_guid,
        event_session_guid,
        sum(total_page_views) as page_views
    from session_events_agg
    group by 1,2
)


select * from final
