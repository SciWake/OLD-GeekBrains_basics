/* В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции. */

--  Создание структуры и заполнение таблиц в БД sample
USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');


--  Создание структуры и заполнение таблиц в БД shop
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Виталий', '2001-10-05'),
  ('Андрей', '2012-11-12'),
  ('Алексей', '1999-05-20'),
  ('Елена', '2008-02-14'),
  ('Валентин', '2006-01-12'),
  ('Мария', '2014-08-29');

START TRANSACTION;

UPDATE sample.users SET name = (SELECT name FROM shop.users WHERE id = 1) WHERE id = 1;
UPDATE sample.users SET birthday_at = (SELECT birthday_at FROM shop.users WHERE id = 1) WHERE id = 1;
UPDATE sample.users SET created_at = (SELECT created_at FROM shop.users WHERE id = 1) WHERE id = 1;
UPDATE sample.users SET updated_at = (SELECT updated_at FROM shop.users WHERE id = 1) WHERE id = 1;

COMMIT;

-- Проверка работы транзакции
SELECT * FROM sample.users;