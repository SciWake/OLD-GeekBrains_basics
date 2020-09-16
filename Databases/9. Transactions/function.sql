USE shop;


-- Создание функции, которая выводит версию MySQL Server
DROP FUNCTION IF EXISTS get_version;

DELIMITER //

CREATE FUNCTION get_version()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
  RETURN VERSION();
END//
/* DETERMINISTIC - сообщает что результат функции детерминирован (При вызове функции возвращает одно значение)
NOT DETERMINISTIC - если результат при вызове функция возвращает разные значения */
DELIMITER ;