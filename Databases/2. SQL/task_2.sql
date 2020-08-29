/*
1. Пусть в таблице catalogs базы данных shop в строке name могут находиться пустые строки и поля, 
принимающие значение NULL. Напишите запрос, который заменяет все такие поля на строку ‘empty’. 
Помните, что на уроке мы установили уникальность на поле name. Возможно ли оставить это условие? Почему?
*/

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
базы данных. Избежать такое поведение можно с помощью ключевого слова IGNORE.
*/

-- Проверим содержимое таблицы
SELECT * FROM catalogs;
-- Содержание таблицы не изменилось

-- Добавим ключевое слово IGNORE в запрос
UPDATE IGNORE catalogs SET name = 'empty' WHERE name IS NUll;

-- Проверим содержимое таблицы
SELECT * FROM catalogs;
-- Содержание таблицы изменилось в 4 строке, значение NULL заменилось на empty, но 5 строка осталась NULL

-- Вывод: Данное задание выполнить не получится, иначе будет нарушена целостность данных.

/*
2. Спроектируйте базу данных, которая позволяла бы организовать хранение медиафайлов, загружаемых пользователем (фото, аудио, видео). 
Сами файлы будут храниться в файловой системе, а база данных будет содержать только пути к файлам, названия, 
описание ключевых слов и принадлежности пользователю.
*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя пользователя',
  brithday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователь';

--  brithday_at DATE COMMENT 'Дата рождения', - данный столбец можно было опустить

DROP TABLE IF EXISTS media;
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";
  