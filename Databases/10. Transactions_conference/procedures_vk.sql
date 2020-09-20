USE vk;


/* Создание триггера для обработки target_id. Тригер будет работать аналогично тому, как СУБД проверяет допустимость значений внешнего ключа, 
например для столбца user_id и ссылку на id из таблицы users.

Тригер будет работать на вставку строки таблицы Likes, который будет првоерять по введённым значениям target_id и target_type_id, существует ли
в соответсвующей таблице запись с представленным id. Если в соответствующей таблице, которая задана ссылкой в target_type_id нет идентификатора,
который задан  в target_id, то будет генерироваться ошибка. Ошибка сообщает о том, что не ссылочной целостности (Попытка вставки данных, которых 
нет в связанных на ЛОГИЧЕСКОМ уровне таблицах).

Сначала создадим функцию для проверки существования строки. Причиной этого служит, что тригеры проверяют данные по очень простым критериям,
поэтому в триггерах не работают некоторые управляющие структуры, которые мы можем использовать в функциях или процедурах. Вся логика проверки 
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


-- Создадим триггер для проверки валидности target_id и target_type_id
 
DROP TRIGGER IF EXISTS like_validation;
DELIMITER //

CREATE TRIGGER like_validation BEFORE INSERT ON likes

FOR EACH ROW BEGIN
  IF NOT is_row_exists(NEW.target_id, NEW.target_type_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided!";
  END IF;
  
END//

DELIMITER ;

-- Проверка работы триггера 
INSERT INTO likes (user_id, target_id, target_type_id) VALUES (34, 56, 2);
-- Вставка прошла успешно

-- Изменим target_type_id на другое значение
INSERT INTO likes (user_id, target_id, target_type_id) VALUES (34, 56, 8);
-- Такого id в таблице target_types нет, поэтому триггер сообщает нам об ошибке


-- Просмотр функций и процедур
SHOW FUNCTION STATUS LIKE 'is_row_exists';
SHOW CREATE FUNCTION is_row_exists;