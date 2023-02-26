select 
u.location.country,
count(distinct f.listing_id)
from general_marketplaces.fct_listings f
left join  dim_product_type  as p
    on f.product_type_id = p.product_type_id
left join  dim_user  as u
    on f.user_id = u.user_id
where exists(
    select * from unnest(p.product_type_tags) as tags
    where tags = 'black'
)
group by u.location.country
