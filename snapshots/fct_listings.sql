{% snapshot fct_listings %}

{{
    config(
        unique_key = 'listing_id',
        target_database = 'jaffle_shop',
        target_schema='snapshots',
        strategy = 'timestamp',
        updated_at = 'last_update_date',
    )

}}

select * from {{ ref('stg_cln_listings') }}

{% endsnapshot %}