select 
    *, 
    skill > 10 as is_pro 
from {{ ref('spies_snapshot') }}