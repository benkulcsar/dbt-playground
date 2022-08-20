select 
    spy, 
    skill, 
    skill > 10 as is_pro 
from {{ source('raw', 'spies') }}