/* 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */
USE shop;

DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
  SET @now_hour = HOUR(NOW());
  
  IF @now_hour BETWEEN 0 AND 5 THEN
    RETURN 'Доброй ночи';
  ELSEIF @now_hour BETWEEN 6 AND 11 THEN
    RETURN 'Доброе утро';
  ELSEIF NOT @now_hour BETWEEN 12 AND 18 THEN
    RETURN 'Добрый день';
  ELSE
    RETURN 'Доброй вечер';
  END IF;
END//

SELECT HOUR(NOW()) AS Now_hour//
-- 18

SELECT hello()//
-- 'Доброй вечер'


/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию. */


-- Создаём таблицу
DROP TABLE IF EXISTS products//
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции'//

-- Тригер для генерации ошибки в случае, когда оба поля принимаю неопределенное значение NULL (INSERT)
DROP TRIGGER IF EXISTS insert_products//
CREATE TRIGGER insert_products BEFORE INSERT ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Name and description is NULL';
  END IF;
END//

-- Тригер для генерации ошибки в случае, когда оба поля принимаю неопределенное значение NULL (UPDATE)
DROP TRIGGER IF EXISTS update_products//
CREATE TRIGGER update_products BEFORE UPDATE ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Name and description is NULL';
  END IF;
END//


-- Проверяем работу тригера
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, NULL, 7890.00, 1);