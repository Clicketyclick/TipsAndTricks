## Insert UUID as ID

Ref: https://stackoverflow.com/a/22725697/7485823

```sql
create table "table" (
  "id" char(36) default (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))), 
  "data" varchar(255), primary key ("id")
);

insert into "table" ("data") values ('foo');
insert into "table" ("data") values ('bar');
select * from "table";
```

> Note!
> 
> `substr('89ab',abs(random()) % 4 + 1, 1)`
> selects that next char to put is either '8', '9', 'a', or 'b'. It comes from UUID specs and tells that this is UUID variant 1 en.wikipedia.org/wiki/Universally_unique_identifier#Variants – 
> Mikael Lepistö
 
