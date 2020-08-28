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

-- Смотрим структуру таблицы медиаконтента 
DESC media_types;

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

-- Проверяем замену
SELECT * FROM media;

-- Исправим значения в столбце media_type_id, установим соответствие jpeg - photo, txt - text...
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'photo') WHERE filepath LIKE '%jpeg';
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'video') WHERE filepath LIKE '%MP4';
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'text') WHERE filepath LIKE '%txt';
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'audio') WHERE filepath LIKE '%MP3';

-- Проверяем замену
SELECT * FROM media;


-- profiles
-- Анализируем данные
SELECT * FROM profiles LIMIT 10;

-- Смотрим структуру профилей
DESC profiles;

-- Вывод id, где медиафайлы являются фотографиями
SELECT id FROM media 
  WHERE media_type_id = (SELECT id FROM media_types WHERE name = 'photo');

-- Профили где стобце photo_id ссылается на фотографию
SELECT * FROM profiles 
  WHERE photo_id IN
    (SELECT id FROM media 
       WHERE media_type_id = (SELECT id FROM media_types WHERE name = 'photo'));

-- Запрос возвращает id из таблицы media где media_type_id = photo (1), котоыре не используются пользователями в качестве фотографии
SELECT * FROM 
  (SELECT id AS all_photo_id FROM media 
    WHERE media_type_id = (SELECT id FROM media_types WHERE name = 'photo')) AS tab1 
  WHERE all_photo_id NOT IN
  -- id фотографий которые используются пользователями
  (SELECT photo_id FROM profiles 
  WHERE photo_id IN
    (SELECT id FROM media 
       WHERE media_type_id = (SELECT id FROM media_types WHERE name = 'photo')));

-- Профили где стобце photo_id не ссылается на фотографию
SELECT * FROM profiles
  WHERE photo_id NOT IN
    (SELECT id FROM media 
       WHERE media_type_id = (SELECT id FROM media_types WHERE name = 'photo'));

-- Теперь можно воспользоваться данными id медиафайлов для заполнения ошибочных значений в таблице profiles в столбце photo_id
-- Данная задача остаётся на доработку в будущем

-- Заменяем стоблцы местами, где updated_at больше чем created_at
INSERT INTO `profiles` SELECT * FROM `profiles` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Выполняем проверку
SELECT COUNT(*) FROM profiles WHERE updated_at < created_at;
-- 0

-- friendship_statuses
-- Анализируем данные 
SELECT * FROM friendship_statuses;

-- Исправим значения name в таблице
UPDATE friendship_statuses SET name = 'Requested' WHERE id = 1; 
UPDATE friendship_statuses SET name = 'Confirmed' WHERE id = 2; 
UPDATE friendship_statuses SET name = 'Rejected' WHERE id = 3;

-- Проверяем данные 
SELECT * FROM friendship_statuses;


