/* Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем. */

-- Выбираем базу данных shop
USE shop;

-- Cоздаём таблицу пользователй
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Заполняем таблицу данными
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', DEFAULT, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', DEFAULT, DEFAULT),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '1992-08-29', NULL, DEFAULT);

-- Проверяем данные
SELECT * FROM users;

-- Заполняем пустые значения. Разделим один запрос на два, чтоб исключить все ситуации:
UPDATE users SET created_at = NOW() WHERE created_at IS NULL;
UPDATE users SET updated_at = NOW() WHERE updated_at IS NULL;

-- Проверяем данные
SELECT * FROM users;


/*
Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время 
помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
*/

-- Cоздаём таблицу пользователй
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

-- Заполняем таблицу данными
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '21.1.2017 12:14', '12.8.2016 19:54'),
  ('Наталья', '1984-11-12', '11.11.2020 6:12', '14.4.2014 17:55'),
  ('Александр', '1985-05-20', '04.5.2023 4:22', '02.7.2011 7:28');
  
-- Проверяем данные
SELECT * FROM users;

-- Преобразуем значения
SELECT STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') AS DATE FROM users;

UPDATE users SET 
  created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
  updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

-- Проверяем данные
SELECT * FROM users;

-- Исправим тип данных в полях created_at and updated_at
ALTER TABLE users 
  CHANGE  created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
  CHANGE updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
  
-- Проверяем данные
SELECT * FROM users;

-- Проверим структуру
DESC users;