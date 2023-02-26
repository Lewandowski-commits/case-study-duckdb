select
product_type,
round(sum(price), 2) total_amount_sold
from {{ ref('challenge_a2') }}
where status_id = 15
group by product_type