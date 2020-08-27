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


-- profiles
-- Смотрим структуру профилей
DESC profiles;

-- Анализируем данные
SELECT * FROM profiles LIMIT 10;

SELECT * FROM media;


-- messages
-- Смотрим структуру таблицы сообщений
DESC messages;

-- Анализируем данные
SELECT * FROM messages LIMIT 10;

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
-- Смотрим структуру таблицы медиаконтента 
DESC media_types;

-- Анализируем типы медиаконтента
SELECT * FROM media_types;

