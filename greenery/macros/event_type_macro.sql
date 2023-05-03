{% macro event_type_macro(event_type) %} 
    sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as total_{{ event_type }}s
{% endmacro %} 