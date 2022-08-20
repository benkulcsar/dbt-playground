{% macro spy_db_init() %}

{% set sql %}
    drop schema if exists raw cascade;

    create schema raw;

    create table raw.spies (
        spy     	varchar(50),
        skill   	integer,
        updated_at  timestamp NOT NULL DEFAULT NOW()
    );
{% endset %}

{% do run_query(sql) %}

{% endmacro %}