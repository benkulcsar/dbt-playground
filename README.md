Create schema and table

```
create schema raw;

create table raw.spies (
    spy     	varchar(50),
    skill   	integer,
    updated_at  timestamp NOT NULL DEFAULT NOW()
);
```

Insert 1
```
insert into raw.spies values('Alice', 5);
insert into raw.spies values('Bob', 7);
insert into raw.spies values('Cecil', 11);
```


Insert 2
