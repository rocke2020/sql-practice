# https://dev.mysql.com/doc/refman/8.4/en/example-maximum-row.html
SELECT article, dealer, price
FROM   shop
WHERE  price=(SELECT MAX(price) FROM shop);

# If there were several most expensive articles, each with a price of 19.95, the LIMIT solution
# would show only one of them.
## order by has its highlight: to simplify the logic, not use nested select.
SELECT article, dealer, price
FROM shop
ORDER BY price DESC
LIMIT 1;