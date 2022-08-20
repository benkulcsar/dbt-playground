# dbt playground

Testing different dbt features. Using Postgres 12.8 on RDS.

##  Snapshots and incremental tables

### DDL, DML and dbt commands

**DDL**
```
create schema raw;

create table raw.spies (
    spy     	varchar(50),
    skill   	integer,
    updated_at  timestamp NOT NULL DEFAULT NOW()
);
```

`dbt run-operation spy_db_init()`

**Load 1**
```
insert into raw.spies values('Alice', 5);
insert into raw.spies values('Bob', 7);
insert into raw.spies values('Cecil', 11);
```
`dbt snapshot && dbt run`

**Load 2**
```
update raw.spies set skill=15 where spy='Bob';
insert into raw.spies values('Dan', 8);
insert into raw.spies values('Eve', 9);
update raw.spies set skill=19 where spy='Eve';
delete from raw.spies where spy='Alice'
```
`dbt snapshot && dbt run`

### Result

`select * from dbt_bkulcsar.spy_levels`

| spy   | skill | is_pro |
|-------|-------|--------|
| Bob   | 15    | True   |
| Cecil | 11    | True   |
| Dan   | 8     | False  |
| Eve   | 19    | True   |

`select * from dbt_bkulcsar.spy_levels_incremental order by spy, updated_at`

| spy   | skill | is_pro | updated_at                 |
|-------|-------|--------|----------------------------|
| Alice | 5     | false  | 2022-08-20T08:24:46.766852 |
| Bob   | 7     | false  | 2022-08-20T08:24:46.766852 |
| Bob   | 15    | true   | 2022-08-20T08:27:55.577373 |
| Cecil | 11    | true   | 2022-08-20T08:24:46.766852 |
| Dan   | 8     | false  | 2022-08-20T08:27:55.577373 |
| Eve   | 19    | true   | 2022-08-20T08:27:55.577373 |

`select * from dbt_bkulcsar.spy_levels_incremental order by spy, updated_at`

| spy   | skill | updated_at | dbt_scd_id | dbt_updated_at | dbt_valid_from             | dbt_valid_to               | is_pro |
|-------|-------|------------|------------|----------------|----------------------------|----------------------------|--------|
| Alice | 5     | …          | …          | …              | 2022-08-20T08:24:46.766852 | 2022-08-20T08:28:13.578279 | false  |
| Bob   | 7     | …          | …          | …              | 2022-08-20T08:24:46.766852 | 2022-08-20T08:27:55.577373 | false  |
| Bob   | 15    | …          | …          | …              | 2022-08-20T08:27:55.577373 | NULL                       | true   |
| Cecil | 11    | …          | …          | …              | 2022-08-20T08:24:46.766852 | NULL                       | true   |
| Dan   | 8     | …          | …          | …              | 2022-08-20T08:27:55.577373 | NULL                       | false  |
| Eve   | 19    | …          | …          | …              | 2022-08-20T08:27:55.577373 | NULL                       | true   |