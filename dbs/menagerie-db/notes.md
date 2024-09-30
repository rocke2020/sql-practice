# My tips
windows start mysql, need to add this mysql dir into system Path
"C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe" "--defaults-file=C:\ProgramData\MySQL\MySQL Server 8.4\my.ini" "-uroot" "-p" "--local-infile=1" "--default-character-set=utf8mb4"

## load data local infile
client: add "--local-infile=1" into windows client connector start scripts
after connect to server: SET GLOBAL local_infile=1;

## sql mod func! This mod logic is different with that in normal math and python
Task: Find pets born in the next month of the current date.  
A way to accomplish the same task is to add 1 to get the next month after the current one after using the modulo function (MOD) to wrap the month value to 0 if it is currently 12:
```sql
mysql> SELECT name, birth FROM pet
       WHERE MONTH(birth) = MOD(MONTH(CURDATE()), 12) + 1;
```
MONTH() returns a number between 1 and 12. And MOD(something,12) returns a number between 0 and 11 and the input range is 1-12. So the addition has to be after the MOD(), otherwise we would go from November (11) to January (1).

```sql
mysql> SELECT name, birth FROM pet
       WHERE MONTH(birth) = MONTH(DATE_ADD(CURDATE(),INTERVAL 1 MONTH));
```

## multiple-tables
There is not pk-fk, but direct inner join. I see the a little complex and magic select
https://dev.mysql.com/doc/refman/8.4/en/multiple-tables.html


## DESC is a short form of DESCRIBE. See Section 15.8.1, “DESCRIBE Statement”, for more information.
desc event;
**But DESC is also used as order by argument!**
```sql
SELECT name, birth FROM pet ORDER BY birth DESC;
SELECT name, birth FROM pet ORDER BY birth ASC;
```

## Using mysql in Batch Mode
https://dev.mysql.com/doc/refman/8.4/en/batch-mode.html  
mysql -u root -p 
source D:/codes/sql-practice/menagerie-db/simple_select.sql  
source D:\codes\sql-practice\menagerie-db\simple_select.sql  

# the nested query is best to understand the logic
```sql
SELECT article, dealer, price
FROM   shop
WHERE  price=(SELECT MAX(price) FROM shop);
```
https://dev.mysql.com/doc/refman/8.4/en/example-maximum-row.html

SELECT s1.article, s1.dealer, s1.price
FROM shop s1
LEFT JOIN shop s2 ON s1.article = s2.article AND s1.price < s2.price
WHERE s2.article IS NULL
ORDER BY s1.article;