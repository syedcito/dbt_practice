-- Fails if a user somehow bought their own ticket listing
{{ config(severity = 'warn') }}

select
    sale_id,
    buyer_id,
    seller_id
from {{ ref('stg_tickit__sales') }}
where buyer_id = seller_id