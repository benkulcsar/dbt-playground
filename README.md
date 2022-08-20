# dbt playground

Testing different dbt features.

## DDL and DML for snapshots and incremental tables

```
create schema raw;

create table raw.spies (
    spy     	varchar(50),
    skill   	integer,
    updated_at  timestamp NOT NULL DEFAULT NOW()
);
```

Load 1
```
insert into raw.spies values('Alice', 5);
insert into raw.spies values('Bob', 7);
insert into raw.spies values('Cecil', 11);
```

Load 2
```
update raw.spies set skill=15 where spy='Bob';
insert into raw.spies values('Dan', 8);
insert into raw.spies values('Eve', 9);
update raw.spies set skill=19 where spy='Eve';
delete from raw.spies where spy='Alice'
```
