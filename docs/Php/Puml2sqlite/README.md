## PUML class diagram to SQLite database schema

Converting a database description from UML Class Scheme:
```puml
@startuml

class dummy {
  Sample table.
  ==
  #id int(10) -- A comment
  field1 int(10)
  .. Comment line, ignored ..
  +field2 varchar(128)
}

@enduml
```

to SQLite database schema:

```sql
-- # Database created on 2024-11-08T16:45:40+00:00 from default
-- # Created by: Bruger Navn.

/**************************************************
* Table: dummy
* Desc:  Sample table.
**************************************************/
CREATE TABLE IF NOT EXISTS 'dummy'
(
   id                   , -- A comment,
   field1               ,
-- .. Comment line, ignored ..
   field2               ,
  PRIMARY KEY (id)
);
CREATE UNIQUE INDEX 'index_field2' ON 'dummy' ( field2 );
```

using [puml2sqlite.php](puml2sqlite.php)
