select 
    spy, 
    skill, 
    {{ is_pro('skill') }} as is_pro 
from {{ source('raw', 'spies') }}