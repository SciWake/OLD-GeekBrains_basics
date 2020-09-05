-- Выполнение запросов

-- Примеры на основе базы данных vk
USE vk;

-- Получаем данные пользователя
SELECT * FROM users WHERE id = 7;

-- Выставляем заглушки на данные, которые необходимо получить
SELECT first_name, last_name, 'city', 'main_photo' FROM users WHERE id = 7;

-- Получаем данные из заглушек
SELECT
  first_name,
  last_name,
  (SELECT city FROM profiles WHERE user_id = 7) AS city,
  (SELECT filepath FROM media WHERE id = 
    (SELECT photo_id FROM profiles WHERE user_id = 7)
  ) AS file_path
  FROM users
    WHERE id = 7;  

-- Дорабатывем условия    
SELECT
  first_name,
  last_name,
  (SELECT city FROM profiles WHERE user_id = users.id) AS city,
  (SELECT filepath FROM media WHERE id = 
    (SELECT photo_id FROM profiles WHERE user_id = users.id)
  ) AS file_path
  FROM users
    WHERE id = 7;


-- Получаем фотографии пользователя
SELECT filepath FROM media
  WHERE user_id = 7
    AND media_type_id = (
      SELECT id FROM media_types WHERE name = 'photo'
    );


-- Выбираем историю по добавлению фотографий пользователем
SELECT CONCAT(
  'Пользователь ', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = media.user_id),
  ' добавил фото ', 
  filepath, ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 8 AND media_type_id = (
        SELECT id FROM media_types WHERE name LIKE 'photo'
);


-- Найдём кому принадлежат 10 самых больших медиафайлов
SELECT user_id, filepath, size 
  FROM media 
  ORDER BY size DESC
  LIMIT 10;
  
  -- Улучшим запрос и используем алиасы для имён таблиц
SELECT 
  (SELECT CONCAT(first_name, ' ', last_name) 
    FROM users u WHERE u.id = m.user_id) AS owner,
  filepath, 
  size 
    FROM media m
    ORDER BY size DESC
    LIMIT 10;


 -- Выбираем друзей пользователя с двух сторон отношения дружбы
(SELECT friend_id FROM friendship WHERE user_id = 7)
UNION
(SELECT user_id FROM friendship WHERE friend_id = 7);


-- Выбираем только друзей с активным статусом
SELECT * FROM friendship_statuses;

(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 8 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
)
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 8 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
);


-- Выбираем медиафайлы друзей
SELECT filepath FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 8 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 8 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
  )
);


-- Определяем пользователей, общее занимаемое место медиафайлов которых 
-- превышает 100МБ
SELECT user_id, SUM(size) AS total
  FROM media
  GROUP BY user_id
  HAVING total > 1000000;
  
-- Добавим сумму всех значений пользователей
SELECT user_id, SUM(size) AS total
  FROM media
  GROUP BY user_id WITH ROLLUP
  HAVING total > 1000000;


-- Выбираем сообщения от пользователя и к пользователю
SELECT from_user_id, to_user_id, body, is_delivered, created_at 
  FROM messages
    WHERE from_user_id = 7 OR to_user_id = 7
    ORDER BY created_at DESC;


-- Сообщения со статусом
SELECT from_user_id, 
  to_user_id, 
  body, 
  IF(is_delivered, 'delivered', 'not delivered') AS status 
    FROM messages
      WHERE (from_user_id = 7 OR to_user_id = 7)
    ORDER BY created_at DESC;


-- Поиск пользователя по шаблонам имени  
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE first_name LIKE 'M%';
  
-- Используем регулярные выражения
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE last_name RLIKE '^K.*r$';
  


-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- Отсортируем пользователей по количеству лайков
SELECT user_id, COUNT(*) as count_likes 
  FROM likes 
  GROUP BY user_id 
  ORDER BY count_likes DESC;

-- Выбираем пользователей, которые являются девушками
SELECT user_id FROM profiles WHERE gender = 'f';

-- Выбираем девушку которая поставила больше всего лайков
SELECT user_id, COUNT(*) as count_likes
  FROM likes 
  GROUP BY user_id 
    HAVING user_id IN (SELECT user_id FROM profiles WHERE gender = 'f')
  ORDER BY count_likes DESC
  LIMIT 1;
-- user_id = 90 | count_likes = 14

-- Выбираем мужчину который поставил больше всего лайков
SELECT user_id, COUNT(*) AS count_likes
  FROM likes 
  GROUP BY user_id 
    HAVING user_id IN (SELECT user_id FROM profiles WHERE gender = 'm')
  ORDER BY count_likes DESC
  LIMIT 1;
-- user_id = 78 | count_likes = 15


-- Выведем пол пользователя, который получил наибольшее количество лайков

-- Выводим пользователя с наибольшим количеством лайков
SELECT user_id FROM likes GROUP BY user_id ORDER BY COUNT(*) DESC LIMIT 1;

-- Выводим пол пользователя, который поставил наибольшее количество лайков в системе
SELECT gender FROM profiles WHERE user_id = 
  (SELECT user_id FROM likes GROUP BY user_id ORDER BY COUNT(*) DESC LIMIT 1);
-- m



-- Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).

-- Смотрим таблицу лайков
SELECT * FROM likes;

-- Смотрим таблицу типов потсов
SELECT * FROM target_types;

-- Выведем 10 самых молодых пользователй в системе
SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;

-- Выбираем лайки поставленные пользователям
SELECT * FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users');

-- Считем сколько лайков поставили пользователям
SELECT target_id, COUNT(*) 
  FROM likes 
    WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users')
      AND target_id IN (SELECT * FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) AS top_profiles)
      GROUP BY target_id;


-- Выполним аналогичное с всеми типами лайков
-- Выбираем лайки поставленные сообщениям
SELECT * FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'messages');

-- Выбираем пользователй, которым поставили лайки на сообщения. При этом получаем их дату рождения
SELECT to_user_id,
  (SELECT birthday FROM profiles WHERE to_user_id = user_id) as birthday
  FROM messages
    WHERE id IN  (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'messages'));

-- Выбираем пользователй, которым были поставлены лайки на медиафайлы (фотографии). При этом получаем их дату рождения
SELECT user_id, 
  (SELECT birthday FROM profiles WHERE media.user_id = profiles.user_id) as birthday
    FROM media
      WHERE id IN (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'media'));

-- Выбираем пользователй, которым были поставлены лайки на посты. При этом получаем их дату рождения
SELECT user_id, 
  (SELECT birthday FROM profiles WHERE posts.user_id = profiles.user_id) as birthday
    FROM posts
      WHERE id IN (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'posts'));

-- Выбираем пользователй, которым были поставлены лайки
SELECT target_id,
  (SELECT birthday FROM profiles WHERE target_id = user_id) as birthday
    FROM likes 
      WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users');


-- Осталось выполнить вертикальное объединение всех запросов и задать условия фильтрации
SELECT user_id, COUNT(*)
  FROM (
	SELECT to_user_id AS user_id,
	  (SELECT birthday FROM profiles WHERE to_user_id = user_id) as birthday
	    FROM messages
		  WHERE id IN  (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'messages'))
	UNION ALL
	SELECT user_id, 
	  (SELECT birthday FROM profiles WHERE media.user_id = profiles.user_id) as birthday
	    FROM media
		  WHERE id IN (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'media'))
	UNION ALL
	SELECT user_id, 
	  (SELECT birthday FROM profiles WHERE posts.user_id = profiles.user_id) as birthday
	    FROM posts
		  WHERE id IN (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'posts'))
	UNION ALL
	SELECT target_id,
	  (SELECT birthday FROM profiles WHERE target_id = user_id) as birthday
	    FROM likes 
		  WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users')
    ) AS likes_users
  GROUP BY user_id 
  ORDER BY birthday DESC 
  LIMIT 10;
-- К данному запросу можно добавить сумму, но полуится дополнительная вложенность, что сделат запрос большим.
-- Поэтому, можно сказать, что данный запрос показывает сколько лайков получил каждый самый молодой пользователь из 10 молодых.


-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети

-- Выполняем запрос выше, но делаем сортировку по количествую лайков. Убираем столбец датый рождения, в данном запросе он не нужен
SELECT user_id, COUNT(*) AS count_likes 
  FROM (
	SELECT to_user_id AS user_id
	  FROM messages
		WHERE id IN  (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'messages'))
	UNION ALL
	SELECT user_id
	  FROM media
		WHERE id IN (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'media'))
	UNION ALL
	SELECT user_id
	  FROM posts
		WHERE id IN (SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'posts'))
	UNION ALL
	SELECT target_id
	  FROM likes 
		WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users')
    ) AS likes_users
  GROUP BY user_id 
  ORDER BY count_likes 
  LIMIT 10;

