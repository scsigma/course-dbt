{{ 
    config(
        materialized='table'
    )
}}

{%- set event_types = dbt_utils.get_column_values(
    table = ref('stg_postgres_events'),
    column = 'event_type'
    )
%}

select
    event_user_guid
    , event_session_guid
    , event_order_guid
    , event_product_guid
    {%- for event_type in event_types %}
        , {{ event_type_macro(event_type) }} 
    {%- endfor %}
from {{ ref ('stg_postgres_events') }}
group by 1,2,3,4