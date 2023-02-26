with grouped_data
as
(
    select 
    platform,
    product_type,
    count(distinct listing_id) listing_count,
    rank() over (partition by platform order by listing_count asc) as rank_id
    from {{ ref('challenge_a2') }}
    group by platform, product_type
)

select
platform,
product_type,
rank_id
from grouped_data
where rank_id < 4