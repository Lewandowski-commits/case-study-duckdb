select 
status_id,
status
from {{ ref('dim_status') }}
where valid_to is null