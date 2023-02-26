{% snapshot fct_listings %}

{{
    config(
        strategy = 'timestamp',
        updated_at = 'last_update_date',
    )

}}

select * from {{ source('jaffle_shop', 'stg_cln_listings') }}

{% endsnapshot %}