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




