with preliminary_data
as
(
    select 
    case when valid_to is null
    then current_date
    else valid_to
    end valid_to,
    listing_id,
    platform,
    from {{ ref('challenge_a2') }}
)
select 
platform,
date_part('year', valid_to),
date_part('month', valid_to),
listing_id
from preliminary_data
group by platform, date_part('year', valid_to), date_part('month', valid_to), listing_id
having count(*) > 1