select 
platform_id,
platform,
from {{ ref('dim_platform') }}
where valid_to is null