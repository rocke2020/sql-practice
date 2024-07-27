SELECT SUM(LENGTH(unique_values)), COUNT(unique_values)
FROM (SELECT DISTINCT name AS unique_values
      FROM items
      WHERE name IS NOT NULL) AS subquery;

SELECT DISTINCT name AS unique_values
      FROM items
      WHERE name IS NOT NULL;