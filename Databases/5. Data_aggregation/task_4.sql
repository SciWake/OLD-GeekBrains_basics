/* Подсчитайте средний возраст пользователей в таблице users. */

-- Используем таблицу shop
USE shop;

-- Создаём таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Заполняем таблицу данными
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

-- Подсчитываем средний возраст всех пользователей  
SELECT AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25) AS mean_age FROM users;
-- 30.7


/*
Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/

-- Получаем месяцы и дни рождения
SELECT *, MONTH(birthday_at), DAY(birthday_at) FROM users;

-- Получаем текущий год
SELECT YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at) FROM users;

-- Получаем дату из данных значений
SELECT DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))) AS date FROM users;

-- Получаем день недели, когда день у пользователей дни рождения
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS weak FROM users;

-- Группируем по дням недели и считаем количество дней рождения
SELECT 
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS weak, COUNT(*) AS count 
FROM 
  users
GROUP BY
  weak
ORDER BY
  count DESC;
