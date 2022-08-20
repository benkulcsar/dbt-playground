{% macro spy_load_one() %}

{% set sql %}
    insert into raw.spies values('Alice', 5);
    insert into raw.spies values('Bob', 7);
    insert into raw.spies values('Cecil', 11);
{% endset %}

{% do run_query(sql) %}

{% endmacro %}