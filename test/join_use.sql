-- Don’t do this unless you know what you are doing:
SELECT *
FROM items
         JOIN categories; -- No ON columns specified!

SELECT *
FROM items
         join categories on items.category_id = categories.id
where items.id = 1;