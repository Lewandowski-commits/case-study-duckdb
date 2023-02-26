{% snapshot snapshot_fct_listings %}

{{
    config(
        unique_key = 'listing_id',
        target_database = 'jaffle_shop',
        target_schema='snapshots',
        strategy = 'timestamp',
        updated_at = 'last_update_date',
    )

}}

select listing_id,
price,
listing_date_key,
platform_id,
product_type_id,
status_id,
user_id,
creation_date,
case when
last_update_date is null
then creation_date
else last_update_date
end as last_update_date
from {{ ref('stg_cln_listings') }}

{% endsnapshot %}