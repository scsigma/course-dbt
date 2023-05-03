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

#### Explain the product mart models you added. Why did you organize the models in the way you did?
I created a fact_page_views model which describes each page view event and the product that was viewed. I used an intermediate table to join the events and products table together before creating this fact table. 

<img width="1042" alt="Screenshot 2023-04-23 at 9 02 51 PM" src="https://user-images.githubusercontent.com/120054623/233899700-2958bd4d-e44a-4004-a524-72ee08f3e525.png">



## Part 2. Tests

#### What assumptions are you making about each model? (i.e. why are you adding each test?)
for the fact_page_views model, i am making sure that the values from the product and event table aren't null

#### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
Yes, there was null values for product_name, product_id, and price. I discovered this in snowsight. In my intermediate model, i made sure to only select rows that did not contain these null values and that made the fix. However, in my tests, i made sure that those values weren't null.


#### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

To be honest, I'm not entirely sure. My first guess would be to set up a cron job so that there is a scheduled interval for running these tests. I'm sure there is some sort of alerting feature to let me know if the data is all of a sudden not passing. The default suggestion, like Jake Hannan suggested, is to use stale data that is passing the tests versus allowing this data to make its way into the production models.

## Part 3. dbt Snapshots

#### Which products had their inventory change from week 1 to week 2? 
Pothos, Philodendron, Monstera, String of pearls
```
select name from inventory_snapshot where dbt_valid_to is not null;
```


