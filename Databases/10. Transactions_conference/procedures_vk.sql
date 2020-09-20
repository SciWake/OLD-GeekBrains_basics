USE vk;


/* Создание триггера для обработки target_id. Тригер будет работать аналогично тому, как СУБД проверяет допустимость значений внешнего ключа, 
например для столбца user_id и ссылку на id из таблицы users.

Тригер будет работать на вставку строки таблицы Likes, который будет првоерять по введённым значениям target_id и target_type_id, существует ли
в соответсвующей таблице запись с представленным id. Если в соответствующей таблице, которая задана ссылкой в target_type_id нет идентификатора,
который задан  в target_id, то будет генерироваться ошибка. Ошибка сообщает о том, что не ссылочной целостности (Попытка вставки данных, которых 
нет в связанных на ЛОГИЧЕСКОМ уровне таблицах).

Сначала создадим функцию для проверки существования строки. Причиной этого служит, что тригеры проверяют данные по очень простым критериям,
поэтому в тригерах не работают некоторые управляющие структуры, которые мы можем использовать в функциях или процедурах. Вся логика проверки 
будет вынесена в функцию.
*/

-- Просмотр структуры таблицы
DESC likes;

-- Выведем данные
SELECT * FROM likes LIMIT 10;


DROP FUNCTION IF EXISTS is_row_exists;
DELIMITER //

CREATE FUNCTION is_row_exists (target_id INT, target_type_id INT)
RETURNS BOOLEAN READS SQL DATA

BEGIN
  DECLARE table_name VARCHAR(50);
  SELECT name FROM target_types WHERE id = target_type_id INTO table_name; -- Помещаем запрос в таблицу table_name
  
  CASE table_name
    WHEN 'messages' THEN
      RETURN EXISTS(SELECT 1 FROM messages WHERE id = target_id);
    WHEN 'users' THEN 
      RETURN EXISTS(SELECT 1 FROM users WHERE id = target_id);
    WHEN 'media' THEN
      RETURN EXISTS(SELECT 1 FROM media WHERE id = target_id);
    WHEN 'posts' THEN
      RETURN EXISTS(SELECT 1 FROM posts WHERE id = target_id);
    ELSE 
      RETURN FALSE;
  END CASE;
  
END//

DELIMITER ;

-- Выведем типы таблицы, которые у нас есть
SELECT * FROM target_types;
-- id = 2, name = users

-- Тестирование функции
SELECT is_row_exists(300, 2);
-- 1

SELECT is_row_exists(301, 2);
-- 0
-- Мы знаем, что в таблице пользователей, их всего 300
