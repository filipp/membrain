Membrain is an app for remembering things. The idea is very simple - you enter data by defining both the name and value of the data that is being saved.

## DB Schema

```
create table objects (id integer primary key autoincrement, title text, icon text, updated datetime);
create table properties (id integer primary key autoincrement, object_id integer, key text, value text);
```
