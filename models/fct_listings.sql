select 
listing_id,
price,
dbt_valid_from valid_from,
dbt_valid_to valid_to,
listing_date_key,
platform_id,
product_type_id,
status_id,
user_id
 from {{ ref('snapshot_fct_listings') }}