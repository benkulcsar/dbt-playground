{{
    config(
        materialized='incremental'
    )
}}

select 
    spy, 
    skill, 
    {{ is_pro('skill') }} as is_pro,
    updated_at
from {{ source('raw', 'spies') }}
{% if is_incremental() %}
where updated_at > (select max(updated_at) from {{ this }})
{% endif %}
