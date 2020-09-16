USE shop;

DELIMITER //

-- Создание процедуруры, которая выводит версию MySQL Server
CREATE PROCEDURE my_version ()
BEGIN
  SELECT VERSION();
END//

DELIMITER ;

-- SHOW PROCEDURE STATUS - выводит список всех хранимых процедур
SHOW PROCEDURE STATUS LIKE 'my_version%';

-- Просмотр информации о процедуре
SHOW CREATE PROCEDURE my_version;

-- Удаление процедуры
DROP PROCEDURE IF EXISTS my_version;


