-- Don’t do this unless you know what you are doing:
SELECT *
FROM items
         JOIN categories; -- No ON columns specified!

select * from items, categories;

SELECT *
FROM items
         join categories on items.category_id = categories.id;

SELECT
    i.id,
    i.name,
    i.category_id,
    c.name AS category_name
FROM items i
RIGHT JOIN categories c ON i.category_id = c.id
-- This prevents duplicate items from showing
-- as we only want categories with no items.
WHERE i.id IS NULL;

#
SELECT
    i.id,
    i.name,
    i.category_id,
    c.name AS category_name
FROM items i
LEFT JOIN categories c ON i.category_id = c.id
-- This prevents duplicate items from showing
-- as we only want categories with no items.
WHERE c.id IS NULL;

SELECT *
FROM items i
LEFT JOIN categories c ON i.category_id = c.id
-- This prevents duplicate items from showing
-- as we only want categories with no items.
WHERE c.id IS NULL;