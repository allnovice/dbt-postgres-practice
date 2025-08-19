-- models/marts/daily_sales.sql

select
    order_date,
    sum(amount) as total_sales,
    count(*) as num_orders
from {{ ref('stg_orders') }}   -- 👈 points to staging
group by order_date
order by order_date
