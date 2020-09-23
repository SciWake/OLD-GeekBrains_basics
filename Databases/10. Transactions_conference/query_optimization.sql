/* 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name. */

USE shop;

-- Создание таблицы logs
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  table_name VARCHAR(255),
  table_id INT,
  name VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
) ENGINE=Archive;

-- Создание тригера для таблицы пользователей
DELIMITER //

DROP TRIGGER IF EXISTS log_insert_users//
CREATE TRIGGER log_insert_users AFTER INSERT ON users
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, table_id, name) VALUES ('users', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS log_insert_catalogs//
CREATE TRIGGER log_insert_catalogs AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, table_id, name) VALUES ('catalogs', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS log_insert_products//
CREATE TRIGGER log_insert_products AFTER INSERT ON products
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, table_id, name) VALUES ('products', NEW.id, NEW.name);
END//
DELIMITER ;


-- Выполняем вставку в таблицу users
SELECT * FROM users;

INSERT INTO users (name) VALUES ('Андрей');

-- Проверяем содержимое таблицы logs
SELECT * FROM logs;
-- 'users', '22', 'Андрей', '2020-09-23 18:24:03'


-- Выполняем вставку в таблицу catalogs
SELECT * FROM catalogs;

INSERT INTO catalogs (name) VALUES ('Клавиатура');

-- Проверяем содержимое таблицы logs
SELECT * FROM logs;
-- 'catalogs', '10', 'Клавиатура', '2020-09-23 18:28:32'


-- Выполняем вставку в таблицу products
SELECT * FROM products;

INSERT INTO products (name, description, price, catalog_id) VALUES ('Asus 7xkjl 98', 'lable in lable', 1800, 1);

-- Проверяем содержимое таблицы logs
SELECT * FROM logs;
-- 'products', '1', 'Asus 7xkjl 98', '2020-09-23 18:30:07'