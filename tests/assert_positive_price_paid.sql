-- Fails if any sale has a price_paid of zero or negative
select
    sale_id,
    price_paid
from {{ ref('stg_tickit__sales') }}
where price_paid <= 0