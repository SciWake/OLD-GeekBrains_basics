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