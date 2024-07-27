create database mytest;
CREATE TABLE categories (
  id int PRIMARY KEY AUTO_INCREMENT,
  name varchar(250) NOT NULL
);
CREATE TABLE items (
  id int PRIMARY KEY AUTO_INCREMENT,
  name varchar(512),
  category_id int NULL
);
insert into items values (1, 'Apples', 1), (2, 'Cheese', 2);
insert into categories values (1, 'Produce'), (2, 'Deli');
insert into items values (3, 'Orange', 3), (4, 'Milk', 2);
insert into items values (5, 'Bread', NULL);
insert into categories values (3, 'Dairy');
delete
from items
where items.name = 'Orange';