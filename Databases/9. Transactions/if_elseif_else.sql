DELIMITER //

USE shop//

/* Оператор IF позволяет реализовать ветвление программ по условию */
DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
  IF(format = 'date') THEN
    SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
  END IF;
  IF(format = 'time') THEN
    SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
  END IF;
END//

CALL format_now('date')//
CALL format_now('time')//


-- Перепишем с использованием ELSE
DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
  IF(format = 'date') THEN
    SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
  ELSE
    SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
  END IF;
END//


-- Используем ESLEIF, добавлен вывод количество секунд прошедших с 1 января 1970 года
DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
  IF(format = 'date') THEN
    SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
  ELSEIF (format = 'time') THEN
    SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
  ELSE
    SELECT UNIX_TIMESTAMP(NOW()) AS format_now;
  END IF;
END//


-- Перепишем процедуру выше с использование  CASE. В операторе CASE отдельные условия задаются ключевыми словами WHEN
DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
  CASE format
    WHEN 'date' THEN
      SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
    WHEN 'time' THEN
      SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
    WHEN 'secs' THEN
      SELECT UNIX_TIMESTAMP(NOW()) AS format_now;
    ELSE
      SELECT 'Ошибка в параметре format';
  END CASE;
END//

CALL format_now ('date')//
CALL format_now ('secs')//
CALL format_now ('four')//