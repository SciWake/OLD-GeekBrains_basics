-- Дополнение по структуре БД vk

USE vk;

-- Таблица лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- Заполнение данных
-- Добавление типов, что можно лайкать
INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

-- Выбор id для медиофайлов медиафайлы
SELECT id FROM media;

-- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 300)), 
    FLOOR((SELECT id FROM media ORDER BY RAND() LIMIT 1)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;


-- Исправим лайки в типе media, которые стоят на аудиозаписи... а должы быть на фотографии пользователей

-- Выбираем лайки, где тип даныых media
SELECT * FROM likes WHERE target_type_id IN (SELECT id FROM target_types WHERE name = 'media');

-- Выбираем медиафайлы с типом фотография
SELECT id FROM media WHERE media_type_id IN (SELECT id FROM media_types WHERE name = 'photo');

-- Обновляем target_id с типом лайка на медиафайл, установив значение id на медиофалй type = 'photo'
UPDATE likes 
  SET target_id = (SELECT id FROM media WHERE media_type_id IN (SELECT id FROM media_types WHERE name = 'photo') ORDER BY RAND() LIMIT 1)
  WHERE target_type_id IN (SELECT id FROM target_types WHERE name = 'media');

-- Проверка данных
SELECT * FROM likes;


-- Создадим таблицу постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  views_counter INT UNSIGNED DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Заполняем таблицу через дамп и проверяем данные
SELECT * FROM posts LIMIT 10;

-- Устраняем неточности в данных

-- Удаление значений, где пост принадлежит сообществу с id 0
SELECT COUNT(*) FROM posts WHERE community_id = 0;
-- 35

-- Заполним их случайными значениями
UPDATE posts SET community_id = (SELECT id FROM communities ORDER BY RAND() LIMIT 1) WHERE community_id = 0;

-- Проверка данных
SELECT COUNT(*) FROM posts WHERE community_id = 0;
-- 0

-- Заменяем стоблцы местами, где updated_at больше чем created_at
INSERT INTO `posts` SELECT * FROM `posts` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка данных
SELECT COUNT(*) FROM posts WHERE updated_at < created_at;
-- 0


-- Выполняем проверку таблицы posts, где media_id ссылается на файлы, которых нет
SELECT COUNT(*) FROM posts WHERE media_id NOT IN (SELECT id FROM media);
-- 297 постов ссылаются на файлы, которых нет в таблице 

-- Обновляем данные для таблицы posts, где media_id ссылается на файлы, которых нет
UPDATE 
  posts 
SET 
  media_id = (SELECT id FROM media ORDER BY RAND() LIMIT 1) 
WHERE 
  media_id NOT IN (SELECT id FROM media);

-- Проверка данных
SELECT COUNT(*) FROM posts WHERE media_id NOT IN (SELECT id FROM media);
-- 0


-- Выполняем проверку таблицы posts, где user_id ссылается на пользователей, которых нет
SELECT COUNT(*) FROM posts WHERE user_id NOT IN (SELECT id FROM users);
-- 2

-- Обновляем данные для таблицы posts, где media_id ссылается на файлы, которых нет
UPDATE 
  posts 
SET 
  user_id = (SELECT id FROM users ORDER BY RAND() LIMIT 1) 
WHERE 
  user_id NOT IN (SELECT id FROM users);

-- Проверка данных
SELECT COUNT(*) FROM posts WHERE user_id NOT IN (SELECT id FROM users);
-- 0


-- Общий вывод данных для визуальной оценки
SELECT * FROM posts LIMIT 20;