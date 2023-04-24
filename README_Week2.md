## Part 1. Models

#### What is our repeat rate? => 0.79
```
select count(distinct case when order_count > 1 then user_id_guid end) / count(distinct user_id_guid) as repeat_user_rate
from (
    select user_id_guid, count(*) as order_count
    from stg_postgres_orders
    group by user_id_guid
);
```

#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
Good indicators - a lot of time spent on the page, multiple orders in the past, responding to promos by using the code or following an affiliate link
Bad indicators - little time spent on the page, not clicking on promos

Order information - how soon after the order was the delivery made? were there issues with the delivery? were the contents of the package damaged?
Customer satisfaction information - did they leave a review? if they did, was it good or bad? any constructive feedback provided would be useful. 



