## Diff on two tables

Source: [Stackoverflow @@Stackoverflow_icon@@](https://stackoverflow.com/a/25302498/7485823)

```sql
SELECT "-",* FROM (SELECT * FROM A
               EXCEPT
               SELECT * FROM B)
UNION ALL
SELECT "+",* FROM (SELECT * FROM B
               EXCEPT
               SELECT * FROM A)
;
```
> [!NOTICE]
> Added '-' and '+' for enhancing view

### Example
```
CREATE TABLE A 
    (
     id int auto_increment primary key, 
     contact_id int(20),
      name varchar(20)
    );

CREATE TABLE B 
    (
     id int auto_increment primary key, 
     contact_id int(20),
      name varchar(20)
    );

INSERT INTO A
(contact_id,name)
VALUES
('1','test1'),
('2','test2');

INSERT INTO B
(contact_id,name)
VALUES
('1','test1'),
('3','test3');

---

SELECT "-",* FROM (SELECT * FROM A
               EXCEPT
               SELECT * FROM B)
UNION ALL
SELECT "+",* FROM (SELECT * FROM B
               EXCEPT
               SELECT * FROM A)
;

---

-               2       test2
+               3       test3
```
