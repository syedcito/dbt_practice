with sales as (

    select * from {{ ref('stg_tickit__sales') }}

),

users as (

    select * from {{ ref('stg_tickit__users') }}

),

sales_as_buyer as (

    select
        buyer_id as user_id,
        count(sale_id) as tickets_bought,
        sum(quantity_sold) as total_quantity_bought,
        sum(price_paid) as total_spent
    from sales
    group by buyer_id

),

sales_as_seller as (

    select
        seller_id as user_id,
        count(sale_id) as tickets_sold,
        sum(quantity_sold) as total_quantity_sold,
        sum(price_paid) as total_revenue,
        sum(commission) as total_commission_paid
    from sales
    group by seller_id

),

final as (

    select
        u.user_id,
        u.username,
        u.first_name,
        u.last_name,
        u.city,
        u.state,
        coalesce(b.tickets_bought, 0) as tickets_bought,
        coalesce(b.total_quantity_bought, 0) as total_quantity_bought,
        coalesce(b.total_spent, 0) as total_spent,
        coalesce(s.tickets_sold, 0) as tickets_sold,
        coalesce(s.total_quantity_sold, 0) as total_quantity_sold,
        coalesce(s.total_revenue, 0) as total_revenue,
        coalesce(s.total_commission_paid, 0) as total_commission_paid
    from users u
    left join sales_as_buyer b on u.user_id = b.user_id
    left join sales_as_seller s on u.user_id = s.user_id

)

select * from final