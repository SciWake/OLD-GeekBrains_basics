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
