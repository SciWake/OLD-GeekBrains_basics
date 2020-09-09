USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Заполняем таблицу тестовыми данными
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');


DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

-- Заполняем таблицу тестовыми данными
INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

-- Заполняем таблицу тестовыми данными
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

-- Заполняем таблицу тестовыми данными
INSERT INTO orders (user_id) VALUES (1), (2), (3), (4);


DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

-- Заполняем таблицу тестовыми данными
INSERT INTO orders_products (order_id, product_id, total) VALUES
  (1, 2, 4),
  (1, 1, 1),
  (3, 3, 1);
  

/* Составьте список пользователей users, которые осуществили хотя бы один заказ (orders) в интернет-магазине. */

-- C Использование вложенных запросов
-- Выводим id пользователей, которые сделали более 1 заказа
SELECT user_id FROM orders WHERE id IN (SELECT order_id FROM orders_products WHERE total > 0);

-- Улучшаем запрос, добавив имя пользователя
SELECT id, name FROM users WHERE 
  id IN (SELECT user_id FROM orders WHERE id IN (SELECT order_id FROM orders_products WHERE total > 0));
  

-- Аналогичный запрос с использование JOIN
SELECT DISTINCT user_id, name FROM
  orders 
JOIN 
  orders_products
  ON orders.id = orders_products.order_id AND total > 0 
JOIN
  users
  ON users.id = user_id;
  

/* Выведите список товаров products и разделов catalogs, который соответствует товару. */

SELECT 
  products.id, 
  products.name, 
  products.price, 
  catalogs.name AS catalog_name  
FROM 
  products
LEFT JOIN 
  catalogs
ON products.catalog_id = catalogs.id;

/* Есть таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов (flights) с русскими названиями городов. */

-- Создаём необходимую структуру для выполнения задания

-- Созадим таблицу flights
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  `id` SERIAL PRIMARY KEY,
  `from` VARCHAR(255),
  `to` VARCHAR(255)
);

-- Заполняем таблицу данными
INSERT INTO flights (`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan'),
  ('moscow', 'agadur');
  

-- Созадим таблицу cities
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  `id` SERIAL PRIMARY KEY,
  `label` VARCHAR(255),
  `name` VARCHAR(255)
);

-- Заполняем таблицу данными
INSERT INTO cities (`label`, `name`) VALUES
  ('moscow', 'Москва'),
  ('omsk', 'Омск'),
  ('kazan', 'Казань'),
  ('irkutsk', 'Иркутск');


-- Заменяем названия городов на русские с использованием JOIN запросов
SELECT 
  flights.id,
  cities_from.name AS `from`,
  cities_to.name AS `to`
FROM 
  flights
LEFT JOIN 
  cities AS cities_from
ON flights.from = cities_from.label
LEFT JOIN 
  cities AS cities_to
ON flights.to = cities_to.label;