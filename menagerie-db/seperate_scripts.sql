show variables like '%version%';

use menagerie;

SELECT name, birth FROM pet WHERE MONTH(birth) = MOD(MONTH(CURDATE()), 12) - 1;

INSERT INTO pet (phone) VALUES ('');

SELECT * FROM pet WHERE REGEXP_LIKE(name, 'w');
SELECT * FROM pet WHERE name RLIKE 'w';
SELECT * FROM pet WHERE name REGEXP 'w';
SELECT * FROM pet WHERE name LIKE '%w%';

SELECT name, birth FROM pet ORDER BY birth DESC;
SELECT name, birth FROM pet ORDER BY birth ASC;
SELECT name, birth FROM pet ORDER BY birth;

SELECT owner, COUNT(*) FROM pet GROUP BY owner;
SELECT species, sex, COUNT(*) FROM pet GROUP BY species, sex;

-- error: 
SELECT DISTINCT species, name, birth FROM pet WHERE species = 'dog' OR species = 'cat';

SELECT species, name, birth FROM pet WHERE species = 'dog' OR species = 'cat';
SELECT DISTINCT species FROM pet WHERE species = 'dog' OR species = 'cat';

-- wrong, because sql mode is "ONLY_FULL_GROUP_BY"
SELECT owner, COUNT(*) FROM pet;

SELECT owner, COUNT(*) FROM pet GROUP BY owner;

load data local infile 'D:\\sql\\mysql\\data\\demo\\pet.txt' into table pet;
LOAD DATA LOCAL INFILE 'D:\\codes\\sql-practice\\menagerie-db\\event.txt' INTO TABLE event;


CREATE DATABASE if not exists testdb;

CREATE TABLE shop (
    article INT UNSIGNED  DEFAULT '0000' NOT NULL,
    dealer  CHAR(20)      DEFAULT ''     NOT NULL,
    price   DECIMAL(16,2) DEFAULT '0.00' NOT NULL,
    PRIMARY KEY(article, dealer));
INSERT INTO shop VALUES
    (1,'A',3.45),(1,'B',3.99),(2,'A',10.99),(3,'B',1.45),
    (3,'C',1.69),(3,'D',1.25),(4,'D',19.95);

SELECT MAX(article) AS article FROM shop;


CREATE TABLE parent (
    id INT NOT NULL,
    PRIMARY KEY (id)
) ENGINE=INNODB;

CREATE TABLE child (
    id INT,
    parent_id INT,
    INDEX par_ind (parent_id),
    FOREIGN KEY (parent_id)
        REFERENCES parent(id)
) ENGINE=INNODB;


--  2 line works, it needs '' around row_number as it is the internal func name, and needs order by
SELECT dealer, ROW_NUMBER() OVER (ORDER BY article) 'row_number' FROM shop;
SELECT dealer, ROW_NUMBER() OVER (ORDER BY article) as 'row_number' FROM shop;
SELECT dealer, price, SUM(price) OVER (PARTITION BY dealer) as total_price FROM shop;
select count(*) as total_rows from shop;
select dealer, count(*) over() as total_rows from shop;

INSERT INTO child (id,parent_id) VALUES ROW(1,1);
INSERT INTO child (id,parent_id) VALUES (1,1);