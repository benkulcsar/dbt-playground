# dbt playground

Testing different dbt features. Using Postgres 12.8 on RDS.

##  Snapshots and incremental tables

### DDL, DML and dbt commands

`dbt run-operation spy_db_init`

`dbt run-operation spy_load_one`
`dbt snapshot` 
`dbt run`

`dbt run-operation spy_load_two`
`dbt snapshot` 
`dbt run`

### Result

`select * from dbt_bkulcsar.spy_levels order by spy`

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

`select * from dbt_bkulcsar.spy_levels_snapshot order by spy, updated_at`

| spy   | skill | updated_at | dbt_scd_id | dbt_updated_at | dbt_valid_from             | dbt_valid_to               | is_pro |
|-------|-------|------------|------------|----------------|----------------------------|----------------------------|--------|
| Alice | 5     | …          | …          | …              | 2022-08-20T08:24:46.766852 | 2022-08-20T08:28:13.578279 | false  |
| Bob   | 7     | …          | …          | …              | 2022-08-20T08:24:46.766852 | 2022-08-20T08:27:55.577373 | false  |
| Bob   | 15    | …          | …          | …              | 2022-08-20T08:27:55.577373 | NULL                       | true   |
| Cecil | 11    | …          | …          | …              | 2022-08-20T08:24:46.766852 | NULL                       | true   |
| Dan   | 8     | …          | …          | …              | 2022-08-20T08:27:55.577373 | NULL                       | false  |
| Eve   | 19    | …          | …          | …              | 2022-08-20T08:27:55.577373 | NULL                       | true   |