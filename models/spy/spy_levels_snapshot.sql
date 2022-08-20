select 
    *, 
    {{ is_pro('skill') }} as is_pro 
from {{ ref('spies_snapshot') }}