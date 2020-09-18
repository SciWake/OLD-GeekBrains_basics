/* 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */
USE shop;

DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
  SET @now_hour = HOUR(NOW());
  
  IF @now_hour BETWEEN 0 AND 5 THEN
    RETURN 'Доброй ночи';
  ELSEIF @now_hour BETWEEN 6 AND 11 THEN
    RETURN 'Доброе утро';
  ELSEIF NOT @now_hour BETWEEN 12 AND 18 THEN
    RETURN 'Добрый день';
  ELSE
    RETURN 'Доброй вечер';
  END IF;
END//

SELECT HOUR(NOW()) AS Now_hour//
-- 18

SELECT hello()//
-- 'Доброй вечер'

