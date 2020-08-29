-- SERIAL == BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
USE shop;

-- Создаём таблицу каталог
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

-- Заполняем данными
INSERT INTO catalogs VALUES
  (DEFAULT, 'Процессоры'),
  (DEFAULT, 'Мат.платы'),
  (DEFAULT, 'Видеокарты'),
  (DEFAULT, NULL),
  (DEFAULT, NULL);

-- Проверим содержание таблицы
SELECT * FROM catalogs;

-- Запрос для обновления пустых значений на empty
UPDATE catalogs SET name = 'empty' WHERE name IS NUll;
/*
В ответ получем:
Error Code: 1062. Duplicate entry 'empty' for key 'catalogs.unique_name'
Сработало ограниечение уникального ключа, оно не допускает нарушения целостности
базы данных. Избежать такое поведение можно с помощью ключевого слова IGNORE
*/
-- Проверим содержимое таблицы
SELECT * FROM catalogs;
-- Содержание таблицы не изменилось

-- Добавим ключевое слово IGNORE в запрос
UPDATE IGNORE catalogs SET name = 'empty' WHERE name IS NUll;

-- Проверим содержимое таблицы
SELECT * FROM catalogs;
-- Содержание таблицы изменилось в 4 строке, значение NULL заменилось на empty, но 5 строка осталась NULL