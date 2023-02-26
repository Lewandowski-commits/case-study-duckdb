with grouped_data
as
(
    with days_diff
        as
        (
            with prefiltered_data
            as
            (
                select 
                valid_from,
                case when valid_to is null
                then current_date
                else valid_to
                end valid_to,
                listing_id,
                product_type,
                from {{ ref('challenge_a2') }}
                where status_id = 10
            )
            select 
            listing_id,
            product_type,
            datediff('day', valid_from, valid_to) days_until_not_longer_active
            from prefiltered_data
        )
    select 
    product_type,
    median(days_until_not_longer_active) median_days_until_not_longer_active,
    rank() over (partition by product_type order by median(days_until_not_longer_active) desc) as rank_id
    from days_diff
    group by product_type
)

select *
from grouped_data
where rank_id < 4