-- Fails if any sale has zero or negative tickets sold
select
    sale_id,
    quantity_sold
from {{ ref('stg_tickit__sales') }}
where quantity_sold <= 0