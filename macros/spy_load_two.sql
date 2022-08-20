{% macro spy_load_two() %}

{% set sql %}
    update raw.spies set skill=15, updated_at=now() where spy='Bob';
    insert into raw.spies values('Dan', 8);
    insert into raw.spies values('Eve', 9);
    update raw.spies set skill=19, updated_at=now() where spy='Eve';
    delete from raw.spies where spy='Alice'
{% endset %}

{% do run_query(sql) %}

{% endmacro %}