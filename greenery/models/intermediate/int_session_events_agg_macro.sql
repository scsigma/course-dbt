{{
    config(
        materialized = 'view'
    )
}}

{%- set event_types = dbt_utils.get_column_values(
    table = ref('stg_postgres_events')
    , column = 'event_type'
    ) 
%}

select 
    event_user_guid
    , event_session_guid
    {%- for event_type in event_types %}
    , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
    {%- endfor %}
    , min(event_created_at) as first_session_event_at_utc
    , max(event_created_at) as last_session_event_at_utc
from {{ ref('stg_postgres_events') }}

group by 1,2