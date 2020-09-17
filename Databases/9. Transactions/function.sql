USE shop;


-- Создание функции, которая выводит версию MySQL Server
DELIMITER //
DROP FUNCTION IF EXISTS get_version//
CREATE FUNCTION get_version()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
  RETURN VERSION();
END//
/* DETERMINISTIC - сообщает что результат функции детерминирован (При вызове функции возвращает одно значение)
NOT DETERMINISTIC - если результат при вызове функция возвращает разные значения */
DELIMITER ;



/* ИНИЦИАЛИЗАЦИЯ ПЕРЕМЕННЫХ:
Помимо ключевого слова DEFAULT, существует ещё два способа инициализации переменных:
  Команда SET;
  Команда SELECT ... INTO ... FROM - позволяет сохранять результаты SELECT запроса без их вывода и без использования внешних переменных */

DELIMITER //

/* Функция принимает в качестве аргумента количество секунд и возвращает строку, которая сообщает сколько дней, часов, минут, секунд
входит в данный интервал */
DROP FUNCTION IF EXISTS second_format;
CREATE FUNCTION second_format (seconds INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
  DECLARE days, hours, minutes INT;

  SET days = FLOOR(seconds / 86400);
  SET seconds = seconds - days * 86400;
  SET hours = FLOOR(seconds / 3600);
  SET seconds = seconds - hours * 3600;
  SET minutes = FLOOR(seconds / 60);
  SET seconds = seconds - minutes * 60;

  RETURN CONCAT(days, " days ",
                hours, " hours ",
                minutes, " minutes ",
                seconds, " seconds");
END//


DELIMITER ;

SELECT second_format(123456);
-- '1 days 10 hours 17 minutes 36 seconds'