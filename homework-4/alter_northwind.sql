-- Подключиться к БД Northwind и сделать следующие изменения:

--1. Добавить ограничение на поле unit_price таблицы products
--(цена должна быть больше 0)
ALTER TABLE products
ADD CHECK (unit_price > 0);

-- 2. Добавить ограничение, что поле discontinued таблицы products может
-- содержать только значения 0 или 1
ALTER TABLE products
ADD CHECK (discontinued IN (0, 1));

-- 3. Создать новую таблицу, содержащую все продукты,
-- снятые с продажи (discontinued = 1)
SELECT * INTO discounted_products
FROM products WHERE discontinued = 1;

SELECT * FROM discounted_products;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения,
-- связанного с foreign_key. Подумайте, как это можно решить,
-- чтобы связь с таблицей order_details все же осталась.

SELECT * FROM order_details;

-- Для удаления ограничения вы должны знать его имя.
-- Если вы не присваивали ему имя, это неявно сделала система,
-- и вы должны выяснить его.
-- Здесь может быть полезна команда psql \d имя_таблицы
-- (или другие программы,
-- показывающие подробную информацию о таблицах).

-- удаление связи во избежании ошибки
ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products;

-- Удаляем продукты, снятые с продажи:
DELETE FROM products
WHERE discontinued = 1;

-- удаление несуществующих значений в orders
DELETE  FROM order_details
WHERE product_id NOT IN
(
	SELECT product_id FROM products
)

-- возврат связи:
ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);
