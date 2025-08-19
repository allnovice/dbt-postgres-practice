{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

with base as (

    -- existing seed
    select
        order_id,
        upper(customer_name) as customer_name,
        order_date::date as order_date,
        amount::numeric(10,2) as amount,
        status
    from {{ ref('orders') }}

    union all

    -- new seed with additional rows
    select
        order_id,
        upper(customer_name) as customer_name,
        order_date::date as order_date,
        amount::numeric(10,2) as amount,
        status
    from {{ ref('new_orders') }}

)

select * from base
