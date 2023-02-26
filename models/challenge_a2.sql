select 
f.listing_date_key,
f.valid_from,
f.valid_to,
d.weekday,
f.listing_id,
f.price,
f.platform_id,
plat.platform,
f.product_type_id,
prod.product_type,
f.status_id,
s.status,
f.user_id,
u."location.city"
 from {{ ref('fct_listings') }} as f
 left join {{ ref('dim_date') }} as d 
    on f.listing_date_key = d.date_key
 left join {{ ref('stg_dim_platform') }} as plat
    on f.platform_id = plat.platform_id
 left join {{ ref('stg_dim_product_type') }} as prod
    on f.product_type_id = prod.product_type_id
 left join {{ ref('stg_dim_status') }} as s
    on f.status_id = s.status_id
 left join {{ ref('stg_dim_user') }} as u
    on f.user_id = u.user_id