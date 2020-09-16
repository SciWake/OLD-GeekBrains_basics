-- Запросы на БД Vk
USE vk;

-- Выборка данных по пользователю
SELECT first_name, last_name, email, gender, birthday, city
  FROM users
    INNER JOIN profiles
      ON users.id = profiles.user_id
  WHERE users.id = 7;

-- Выборка медиафайлов пользователя
SELECT media.id, users.first_name, users.last_name, media.user_id, media.filepath, media.created_at
  FROM media
    JOIN users
      ON media.user_id = users.id     
  WHERE media.user_id = 7;
  
-- Выборка фотографий пользователя
SELECT media.id, users.first_name, users.last_name, media.user_id, media.filepath, media.created_at
  FROM media
    JOIN users
      ON media.user_id = users.id
    JOIN media_types
      ON media.media_type_id = media_types.id     
  WHERE media.user_id = 8 AND media_types.name = 'photo';


-- Выборка медиафайлов друзей пользователя
-- Вариант 1
SELECT DISTINCT media.id, media.user_id, media.filepath, media.created_at
  FROM media
    JOIN friendship
      ON media.user_id = friendship.user_id
        OR media.user_id = friendship.friend_id
    JOIN users 
      ON users.id = friendship.friend_id
        OR users.id = friendship.user_id   
  WHERE users.id = 7;

-- Вариант 2
SELECT DISTINCT media.id, media.user_id, media.filepath, media.created_at
  FROM media
    JOIN friendship
    JOIN users 
      ON (users.id = friendship.friend_id 
        OR users.id = friendship.user_id)
      AND (media.user_id = friendship.user_id 
        OR media.user_id = friendship.friend_id)   
  WHERE users.id = 7;


-- Отберём только медиафайлы друзей  
SELECT DISTINCT media.user_id, media.filepath, media.created_at
  FROM media
    JOIN friendship
    JOIN users 
      ON (users.id = friendship.friend_id 
        OR users.id = friendship.user_id)
      AND (media.user_id = friendship.user_id 
        OR media.user_id = friendship.friend_id)   
  WHERE users.id = 7 AND media.user_id != 7;

-- Проверка
SELECT user_id, friend_id FROM friendship WHERE user_id = 7 OR friend_id = 7;


-- Выборка фотографий пользователя и друзей пользователя (без DISTINCT)
SELECT media.id, media.user_id, media.filepath, media.created_at
  FROM media
    JOIN friendship
      ON media.user_id = friendship.user_id
        OR media.user_id = friendship.friend_id
    JOIN media_types
      ON media.media_type_id = media_types.id
    JOIN users 
      ON users.id = friendship.friend_id
        OR users.id = friendship.user_id   
  WHERE users.id = 7 AND media_types.name = 'photo';
  
-- Используем DISTINC  
SELECT DISTINCT media.id, media.user_id, media.filepath, media.created_at
  FROM media
    JOIN friendship
      ON media.user_id = friendship.user_id
        OR media.user_id = friendship.friend_id
    JOIN media_types
      ON media.media_type_id = media_types.id
    JOIN users 
      ON users.id = friendship.friend_id
        OR users.id = friendship.user_id   
  WHERE users.id = 7 AND media_types.name = 'photo';  


-- Сообщения от пользователя
SELECT messages.body, users.first_name, users.last_name, messages.created_at
  FROM messages
    JOIN users
      ON users.id = messages.to_user_id
  WHERE messages.from_user_id = 7;

-- Сообщения к пользователю
SELECT body, first_name, last_name, messages.created_at
  FROM messages
    JOIN users
      ON users.id = messages.from_user_id
  WHERE messages.to_user_id = 7;
  
-- Объединяем все сообщения от пользователя и к пользователю
SELECT messages.from_user_id, messages.to_user_id, messages.body, messages.created_at
  FROM users
    JOIN messages
      ON users.id = messages.to_user_id
        OR users.id = messages.from_user_id
  WHERE users.id = 7;


-- Количество друзей у пользователей с сортировкой
-- Выполним объединение и посмотрим на результат
SELECT users.id, first_name, last_name, friendship.created_at
  FROM users
    LEFT JOIN friendship
      ON users.id = friendship.user_id
        OR users.id = friendship.friend_id
        ORDER BY users.id;

-- Затем подсчитаем
SELECT users.id, first_name, last_name, COUNT(friendship.created_at) AS total_friends
  FROM users
    LEFT JOIN friendship
      ON users.id = friendship.user_id
        OR users.id = friendship.friend_id
  GROUP BY users.id
  ORDER BY total_friends DESC
  LIMIT 10;


-- Список медиафайлов пользователя с количеством лайков
SELECT likes.target_id,
  media.filepath,
  target_types.name AS target_type,
  COUNT(DISTINCT(likes.id)) AS total_likes,
  CONCAT(first_name, ' ', last_name) AS owner
  FROM media
    LEFT JOIN likes
      ON media.id = likes.target_id
    LEFT JOIN target_types
      ON likes.target_type_id = target_types.id
    LEFT JOIN users
      ON users.id = media.user_id
  WHERE users.id = 7 AND target_types.name = 'media'
  GROUP BY media.id;

-- 10 пользователей с наибольшим количеством лайков за медиафайлы
SELECT users.id, first_name, last_name, COUNT(target_types.id) AS total_likes
  FROM users
    LEFT JOIN media
      ON users.id = media.user_id
    LEFT JOIN likes
      ON media.id = likes.target_id
    LEFT JOIN target_types
      ON likes.target_type_id = target_types.id
        AND target_types.name = 'media'
  GROUP BY users.id
  ORDER BY total_likes DESC
  LIMIT 10;


/* Определить кто больше поставил лайков (всего) - мужчины или женщины? */

SELECT COUNT(likes.user_id) AS count_likes, profiles.gender
  FROM likes
    INNER JOIN profiles
      ON likes.user_id = profiles.user_id
  GROUP BY gender
  ORDER BY count_likes DESC
  LIMIT 1;
  
-- Пример вывода данных:
-- |  count_likes  |  gender  |
--       1132           f


/* Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей). */

-- Подсчитываем общее количество лайков, которые получили 10 самых молодых пользователей.
SELECT SUM(got_likes) AS total_likes_for_youngest
  FROM (   
    SELECT COUNT(DISTINCT likes.id) AS got_likes 
      FROM profiles
        LEFT JOIN likes
          ON likes.target_id = profiles.user_id
            AND target_type_id = 2
      GROUP BY profiles.user_id
      ORDER BY profiles.birthday DESC
      LIMIT 10
) AS youngest;

/* Доработаем запрос. 
Используюя LEFT JOIN, так как INNER JOIN не выбирает пользователей без лайков (0). 
Данный запрос меняет логику работы и выборку из данных */
SELECT SUM(got_likes) AS total_likes_for_youngest
  FROM (   
    SELECT COUNT(DISTINCT likes.id) AS got_likes 
      FROM profiles
        LEFT JOIN likes
          ON likes.target_id = profiles.user_id
            AND target_type_id = 2
      GROUP BY profiles.user_id
      ORDER BY profiles.birthday DESC
      LIMIT 10
) AS youngest;


/* Доработаем запрос.
 Удаляем явное указание id, который обозначает тип объекта (фото, пост...), поэтому была введена таблица c объединение (LEFT / RIGHT JOIN target_types),
 которая позволяет указать тип объекта в формате 'users' */

-- Вариант с левой таблицей профилей
SELECT SUM(got_likes) AS total_likes_for_youngest
  FROM (   
    SELECT COUNT(target_types.id) AS got_likes 
      FROM profiles
        LEFT JOIN likes
          ON likes.target_id = profiles.user_id
        LEFT JOIN target_types
          ON likes.target_type_id = target_types.id
            AND target_types.name = 'users'
      GROUP BY profiles.user_id
      ORDER BY profiles.birthday DESC
      LIMIT 10
) AS youngest;

-- Вариант с правой таблицей профилей
SELECT SUM(got_likes) AS total_likes_for_youngest
  FROM (   
    SELECT COUNT(target_types.id) AS got_likes 
      FROM likes
        INNER JOIN target_types
          ON likes.target_type_id = target_types.id
            AND target_types.name = 'users'
        RIGHT JOIN profiles
          ON likes.target_id = profiles.user_id
      GROUP BY profiles.user_id
      ORDER BY profiles.birthday DESC
      LIMIT 10
) AS youngest;

-- Пример вывода данных:
-- |  total_likes_for_youngest  |
--    8


/* Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети */
-- Для оценки активности используется количество данных пользователя (Количество сообщений, лайков, медиафайлов)

SELECT users.id,
  COUNT(DISTINCT messages.id) + 
  COUNT(DISTINCT likes.id) + 
  COUNT(DISTINCT media.id) AS activity 
  FROM users
    LEFT JOIN messages 
      ON users.id = messages.from_user_id
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media
      ON users.id = media.user_id
  GROUP BY users.id
  ORDER BY activity
  LIMIT 10;

-- Пример вывода данных:
-- |  id  |  activity  |
--    97     10
--    231    11
--       . . .