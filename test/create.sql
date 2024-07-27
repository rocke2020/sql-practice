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