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

-- Создаём временную таблицу для сохранения некорректной даты
CREATE TEMPORARY TABLE updated_date (
  created_at DATETIME,
  updated_at DATETIME
);

-- Заполняем временную таблицу необходимыми данными
INSERT INTO updated_date (created_at, updated_at) SELECT created_at, updated_at FROM messages WHERE updated_at < created_at;

-- Выполняем проверку, что заполнение произошло успешно
SELECT * FROM updated_date;

-- Проверяем количестно новых дат, их должно быть 998
SELECT COUNT(*) FROM updated_date;
-- 998

UPDATE messages SET 
  updated_at = (SELECT created_at FROM updated_date),
  created_at = (SELECT updated_at FROM updated_date)
  WHERE updated_at < created_at;

SELECT * FROM profiles;
