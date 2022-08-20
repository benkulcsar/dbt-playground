{% snapshot spies_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='spy',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ source('raw', 'spies') }}

{% endsnapshot %}