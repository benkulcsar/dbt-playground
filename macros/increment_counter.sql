{% macro increment_counter(inc=1) %}

{% set create %}
    create table if not exists public.runcounter (spy_runs INTEGER);
{% endset %}

{% set increment %}
    insert into public.runcounter values (1);
{% endset %}

{% do run_query(create) %}

{% for _ in range(inc) %}
{% do run_query(increment) %}
{% endfor %}

{% endmacro %}
