{{ config(
    post_hook=[
        "create table if not exists public.runcounter (spy_runs INTEGER)",
        "insert into public.runcounter values (1)",
    ]
) }}

select 
    spy, 
    skill, 
    {{ is_pro('skill') }} as is_pro 
from {{ source('raw', 'spies') }}