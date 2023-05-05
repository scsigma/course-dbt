# Part 1

### Which products had their inventory changed from week 3 to week 4?
```
with updated_snapshot as (
    select 
        max(dbt_valid_to) as max_date 
    from inventory_snapshot
) 

select * from inventory_snapshot
join updated_snapshot
on inventory_snapshot.dbt_valid_from = updated_snapshot.max_date;
```

- ZZ Plant
- Monstera
- Bamboo
- Philodendron


### Which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks?
```
select
    name
    , count(*) as inventory_changes
from inventory_snapshot
group by 1
order by inventory_changes desc limit 10;
```
| NAME              | INVENTORY_CHANGES |
| ----------------- | ----------------- |
| Monstera          | 3                 |
| Philodendron      | 3                 |
| Bamboo            | 2                 |
| Pothos            | 2                 |
| ZZ Plant          | 2                 |
| String of pearls  | 2                 |
| Orchid            | 1                 |
| Snake Plant       | 1                 |
| Peace Lily        | 1                 |
| Calathea Makoyana | 1                 |


```
select case when exists (
    select * from inventory_snapshot
    where inventory = 0
) then 'True' else 'False' end as inventory_reached_zero;
```

| INVENTORY_REACHED_ZERO |
| ---------------------- |
| FALSE                  |





# Part 2

### How are our users moving through the product funnel?
We are seeing that roughly 54% of users are adding a product to their cart when they view it and 43% will purchase that product when they view it. If a user adds a product to their cart, there is an 80% chance they purchase it. 

### Which steps in the funnel have largest drop off points?
The largest drop off is from viewed to added to cart.


# Part 3

### 3a
I can't speak to what our organization should be doing differently bc i'm at sigma computing with Jake. However, one of the intersections i would like to explore more is between Snowflake's Snowpark and dbt. It is really easy to write python udfs with snowpark and then reference them in dbt. This feels easier than macros to me, personally. 

### 3b
I haven't really explored the different orchestration tools out there, so dbt cloud probably. i would be interested to know how many rows are being added or rmemoved over time. Ths would show higher periods of activity, in terms of altering the size of table.