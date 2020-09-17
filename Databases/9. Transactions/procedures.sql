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



/* ТИПЫ ПЕРЕМЕННЫХ:
  IN - данные передаются строго внутрь хранимой процедуры;
  OUT - данные передаются строго из хранимой процедуры;
  INOUT - данные передаются как внутрь процедуры, так и из хранимой процедуры. */

DELIMITER //

/* Создаём процедуру, которая  принимает единственный параметр value и устанавливает в ней переменную x.
Параметр IN можно опускать, так как он установлен по умолчанию. */
DROP PROCEDURE IF EXISTS set_x//
CREATE PROCEDURE set_x (IN value INT)
BEGIN
  SET @x = value;
  SET value = value - 1000;
END//

DELIMITER ;

SET @y = 1000;

-- Вызываем процедуру
CALL set_x(@y);

-- Проверяем переменную Х
SELECT @x, @y;
-- 1000, 1000
-- Изменение не отразилось на переменной @y, если требуется чтоб процедура изменила значение переменной, необходимо создать процедуру с модификатором OUT


DELIMITER //

-- Изменяем процедуру, установив модификатор IN на OUT
DROP PROCEDURE IF EXISTS set_x//
CREATE PROCEDURE set_x (OUT value INT)
BEGIN
  SET @x = value;
  SET value = 1000;
END//

DELIMITER ;

-- Повторяем действия для проверки
SET @y = 10000;

-- Вызываем процедуру
CALL set_x(@y);

-- Проверяем переменную Х
SELECT @x, @y;
-- NULL, 1000
/* Переменная @x получила значение NULL, при помощи OUT модификатора мы не можем передать какое-либо значение внутрь процедуры.
Переменная @y изменила своё значение с 10000 на 1000, с помощью OUT параметра мы выставили новое значение.

Если установить INOUT, тогда можно будет передать значение внутрь процедруы и устанавливать значения из неё. */


DELIMITER //

-- Изменяем процедуру, установив модификатор OUT на INOUT
DROP PROCEDURE IF EXISTS set_x//
CREATE PROCEDURE set_x (INOUT value INT)
BEGIN
  SET @x = value;
  SET value = value - 1000;
END//

DELIMITER ;

-- Повторяем действия для проверки
SET @y = 10000;

-- Вызываем процедуру
CALL set_x(@y);

-- Проверяем переменную Х
SELECT @x, @y;
-- 10000, 9000


/* До этого момента, все локальные переменные, которые мы использовали, были объявлены как параметры - данный подход не удобен в использовании.
Часто, требуются только локальные переменные, без надобности передачи внутрь или наружу функции/процедуры.

Объявить такую локальную переменную можно с помощью команды DECLARE */

DELIMITER //

CREATE PROCEDURE declare_var()
BEGIN
  DECLARE id, num INT(11) DEFAULT 0;
  DECLARE name, hello, temp TINYTEXT;
END//

/* Ключевое слово DEFAULT позволяет назначить инициирующее значение. 
Те переменные, для которых не указано ключевое слово DEFAULT, можно инициализировать их с помощью SET 

Команда DECLARE может использоваться только внутри блока BEGIN END, область видимости переменной также ограничена этим блоком. */



/* ИНИЦИАЛИЗАЦИЯ ПЕРЕМЕННЫХ:
Помимо ключевого слова DEFAULT, существует ещё два способа инициализации переменных:
  Команда SET;
  Команда SELECT ... INTO ... FROM - позволяет сохранять результаты SELECT запроса без их вывода и без использования внешних переменных */

-- Процедура возвращает количество строк в таблице catalogs
DROP PROCEDURE IF EXISTS numcatalogs//
CREATE PROCEDURE numcatalogs (OUT total INT)
BEGIN
  SELECT COUNT(*) INTO total FROM catalogs;
END//

CALL numcatalogs(@a)//
SELECT @a//
-- 5


DELIMITER ;
/* ОБРАБОТКА ОШИБОК:
Во время выполнения процедур и функций могут происходить ошибки, поэтому MySQL поддреживает обработчики ошибок. */

-- Сгенерируем собственную ошибку: 

USE shop;

SELECT * FROM catalogs;
-- Запись с id = 1 уже есть в таблице

-- Добавим новую запись с id = 1:
INSERT INTO catalogs VALUE (1, 'Процессоры');
-- Error Code: 1062. Duplicate entry '1' for key 'catalogs.PRIMARY'


/* Обработаь код данной ошибки можно с помощью команды DECLARE CONTINUE HANDLER FOR
Данная команда может использоваться только в теле хранимых процедур / функций. 

Создадим для этого хранимую процедуру insert_to_catalog. Данная хранимая процедура будет вставлять запись в таблицу catalogs.
В случае неудачи мы перехватываем код 23000 и обрабатывать его при помощи обработчика ошибок. 
Обработчик будет выставлять значение для переменной error, в случае если переменная error будет определена, 
процедура будет выводить её содержимое пользователю. */

DELIMITER //

DROP PROCEDURE IF EXISTS insert_to_catalog//
CREATE PROCEDURE insert_to_catalog (IN id INT, IN name VARCHAR(255))
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
  INSERT INTO catalogs VALUES(id, name);
  IF @error IS NOT NULL THEN
    SELECT @error;
  END IF;
END//

SELECT * FROM catalogs//

CALL insert_to_catalog(4, 'Оперативная память')//
-- Запись успешно вставилась

CALL insert_to_catalog(1, 'Процессоры')//
-- Ошибка вставки значения