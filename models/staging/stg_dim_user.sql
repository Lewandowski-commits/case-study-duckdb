select 
user_id,
location,
"location.city",
"location.country"
from {{ ref('dim_user') }}
where valid_to is null