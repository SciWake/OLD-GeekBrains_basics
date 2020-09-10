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
SELECT DISTINCT media.id, media.user_id, media.filepath, media.created_at
  FROM media
    JOIN friendship
      ON media.user_id = friendship.user_id
        OR media.user_id = friendship.friend_id
    JOIN users 
      ON users.id = friendship.friend_id
        OR users.id = friendship.user_id   
  WHERE users.id = 7;