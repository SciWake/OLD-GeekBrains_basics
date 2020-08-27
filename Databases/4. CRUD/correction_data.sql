-- Дорабатываем тестовые данные
USE vk;

-- Смотрим все таблицы
SHOW TABLES;


-- users
-- Анализируем данные пользователей
SELECT * FROM users LIMIT 10;

-- Смотрим структуру таблицы пользователей
DESC users;

-- Приводим в порядок временные метки
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;

-- Выполняем проверку
SELECT * FROM users WHERE updated_at < created_at;


-- messages
-- Анализируем данные
SELECT * FROM messages LIMIT 10;

-- Смотрим структуру таблицы сообщений
DESC messages;

-- Проверяем сколько сообщений отправлено самому себе
SELECT COUNT(*) FROM messages WHERE from_user_id = to_user_id;
-- 9
-- Так как 9 сообщений отправлены самому себе, такое может быть VK, оставим без изменеий

-- Проверим стобцы created_at and updated_at
SELECT COUNT(*) FROM messages WHERE updated_at < created_at;
-- 998

-- Выводим ошибочные данные
SELECT * FROM messages WHERE updated_at < created_at;

-- Заменяем стоблцы местами, где updated_at больше чем created_at
INSERT INTO `messages` SELECT * FROM `messages` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверим стобцы created_at and updated_at
SELECT COUNT(*) FROM messages WHERE updated_at < created_at;
-- 0


-- media_types
-- Анализируем типы медиаконтента
SELECT * FROM media_types;

-- Смотрим структуру таблицы медиаконтента 
DESC media_types;

-- Заменяем стоблцы местами, где updated_at больше чем created_at
INSERT INTO `media_types` SELECT * FROM `media_types` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;
    
-- Исправим значения name в таблице
UPDATE media_types SET name = 'photo' WHERE id = 1; 
UPDATE media_types SET name = 'video' WHERE id = 2; 
UPDATE media_types SET name = 'text' WHERE id = 3; 
UPDATE media_types SET name = 'audio' WHERE id = 4; 

-- Выполняем проверку
SELECT * FROM media_types;


-- media
-- Анализируем данные
SELECT * FROM media LIMIT 10;

-- Переименуем столбец пути к файлу 
ALTER TABLE media RENAME COLUMN filename TO filepath;

-- Создаём временную таблицу форматов медиафайлов
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- Заполняем значениями
INSERT INTO extensions VALUES ('jpeg'), ('MP3'), ('txt'), ('MP4');

-- Проверяем
SELECT * FROM extensions;

-- Обновляем ссылку на файл
UPDATE media SET filepath = CONCAT(
  'https://',
  filepath,
  (SELECT last_name FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- Проверяем замену
SELECT * FROM media;

-- Обновляем размер файлов
UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');

-- Возвращаем столбцу метеданных правильный тип
ALTER TABLE media MODIFY COLUMN metadata JSON;

