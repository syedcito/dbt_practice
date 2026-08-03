-- Fails if commission ever exceeds the price paid (sanity check)
select
    sale_id,
    price_paid,
    commission
from {{ ref('stg_tickit__sales') }}
where commission > price_paid