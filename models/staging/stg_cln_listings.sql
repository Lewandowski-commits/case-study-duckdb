select 
listing_id,
price,
listing_date_key,
platform_id,
product_type_id,
status_id,
user_id,
creation_date,
CASE WHEN
last_update_date IS NULL
THEN creation_date
ELSE last_update_date
END as last_update_date
 from {{ ref('cln_listings') }}