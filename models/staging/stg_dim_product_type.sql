select 
product_type_id,
product_type,
product_type_tags,
"product_type_tags.weight_kg",
"product_type_tags.color",
from {{ ref('dim_product_type') }}
where valid_to is null