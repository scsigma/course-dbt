# Part 1:


### Question 1: What is our overall conversion rate?

```
select 
    count(distinct event_session_checkout) as total_checkouts
    , count(distinct event_session_guid) as total_unique_sessions
    , total_checkouts / total_unique_sessions as overall_conversion_rate 
from fact_conversion_rate;
```

| TOTAL_CHECKOUTS | TOTAL_UNIQUE_SESSIONS | OVERALL_CONVERSION_RATE |
| --- | ----------- | --- |
| 361 | 578 | 0.624567 |



### Question 2: What is our conversion rate by product?
```
select
    product_name
    , count(distinct event_session_checkout) as total_checkouts
    , count(distinct event_session_guid) as total_unique_sessions
    , total_checkouts / total_unique_sessions as conversion_rate
from fact_conversion_rate
where product_name is not null
group by 1;
```

| PRODUCT_NAME        | TOTAL_CHECKOUTS | TOTAL_UNIQUE_SESSIONS | CONVERSION_RATE |
| ------------------- | --------------- | --------------------- | --------------- |
| Arrow Head          | 35              | 63                    | 0.555556        |
| Pilea Peperomioides | 28              | 59                    | 0.474576        |
| Rubber Plant        | 28              | 54                    | 0.518519        |
| Jade Plant          | 22              | 46                    | 0.478261        |
| Orchid              | 34              | 75                    | 0.453333        |
| Cactus              | 30              | 55                    | 0.545455        |
| Money Tree          | 26              | 56                    | 0.464286        |
| Aloe Vera           | 32              | 65                    | 0.492308        |
| Fiddle Leaf Fig     | 28              | 56                    | 0.5             |
| Alocasia Polly      | 21              | 51                    | 0.411765        |
| Pink Anthurium      | 31              | 74                    | 0.418919        |
| String of pearls    | 39              | 64                    | 0.609375        |
| Pothos              | 21              | 61                    | 0.344262        |
| Angel Wings Begonia | 24              | 61                    | 0.393443        |
| Monstera            | 25              | 49                    | 0.510204        |
| ZZ Plant            | 34              | 63                    | 0.539683        |
| Dragon Tree         | 29              | 62                    | 0.467742        |
| Snake Plant         | 29              | 73                    | 0.39726         |
| Bird of Paradise    | 27              | 60                    | 0.45            |
| Birds Nest Fern     | 33              | 78                    | 0.423077        |
| Bamboo              | 36              | 67                    | 0.537313        |
| Ficus               | 29              | 68                    | 0.426471        |
| Peace Lily          | 27              | 66                    | 0.409091        |
| Spider Plant        | 28              | 59                    | 0.474576        |
| Devil's Ivy         | 22              | 45                    | 0.488889        |
| Philodendron        | 30              | 62                    | 0.483871        |
| Boston Fern         | 26              | 63                    | 0.412698        |
| Majesty Palm        | 33              | 67                    | 0.492537        |
| Ponytail Palm       | 28              | 70                    | 0.4             |
| Calathea Makoyana   | 27              | 53                    | 0.509434 |




# Part 2

I created a macro for the event type count calculation used in the int_session_events_agg model. It simplifies the rewriting of multiple lines by event type.
```
{% macro event_type_macro(event_type) %} 
    sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as total_{{ event_type }}s
{% endmacro %} 
```



# Part 6
```
with dbt_update as (
    select max(dbt_valid_to) as max_date 
    from inventory_snapshot where dbt_valid_to < '2023-05-03'
)


select * from inventory_snapshot 
join dbt_update
on
inventory_snapshot.dbt_valid_from = dbt_update.max_date;
```

NAME
- String of pearls
- Pothos
- Philodendron
- Monstera