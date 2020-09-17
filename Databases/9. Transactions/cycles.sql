/* ЦИКЛЫ:	 
     * WHILE;
     * REPEAT;
     * LOOP.
Циклы можно использовать в теле хранимх процедур или функций (между ключевыми словами BEGIN и END) */

DELIMITER //

/* Здесь используется цикл WHILE для 3-х кратного вывода даты и времени. 
Цикл WHILE начинается ключевым словом DO, а заканчивается END WHILE */
DROP PROCEDURE IF EXISTS NOWN//
CREATE PROCEDURE NOW3 ()
BEGIN
  DECLARE i INT DEFAULT 3;
  WHILE i > 0 DO
    SELECT NOW();
    SET i = i - 1;
  END WHILE;
END//

CALL NOW3()//


-- Заданим количество повторов через параметр (num). С помощью IF проверяем что значение > 0
DROP PROCEDURE IF EXISTS NOWN//
CREATE PROCEDURE NOWN (IN num INT)
BEGIN
  DECLARE i INT DEFAULT 0;
  IF (num > 0) THEN
    WHILE i < num DO
      SELECT NOW();
      SET i = i + 1;
    END WHILE;
  ELSE
    SELECT 'Ошибочное значение параметра';
  END IF;
END//

CALL NOWN(1000)//




/* ДОСРОЧНЫЙ ВЫХОД ИЗ ЦИКЛОВ:
Ограничим цикл в процедуре NOWN двумя итерациями, для этого используется в теле цикла доаолнительное условие с LEAVE.
LEAVE - Предварительный выход их цикла. Циклы можно вкладывать друг в друга, чтоб LEAVE понимала какой из циклов требуется остановить
ей всегда передаётся метка цикла, в нашем случае это "cycle" */
DROP PROCEDURE IF EXISTS NOWN//
CREATE PROCEDURE NOWN (IN num INT)
BEGIN
  DECLARE i INT DEFAULT 0;
  IF (num > 0) THEN
    cycle: WHILE i < num DO
      IF i >= 2 THEN LEAVE cycle;  -- Данное условие не допускает счётсчику i первысить значение 2. После истинности условия сробатывает команда LEAVE
      END IF;
      SELECT NOW();
      SET i = i + 1;
    END WHILE cycle;
  ELSE
    SELECT 'Ошибочное значение параметра';
  END IF;
END//

CALL NOWN(1000)//
-- Выведет только две даты, а не 1000, так как установлено ограничение.


/* Ещё один оператор досрочного прекращения цикла является ITERATE.
В отличи от оператора LEAVE, ITERATE не прекращает выполнение цикла, а лишь выполняет досрочное прекращение текущей итерации. */
DROP PROCEDURE IF EXISTS numbers_string//
CREATE PROCEDURE numbers_string (IN num INT)
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE bin TINYTEXT DEFAULT '';
  IF (num > 0) THEN
    cycle : WHILE i < num DO
      SET i = i + 1;
      SET bin = CONCAT(bin, i);  -- Число значения счетчика добавляется к строке bin на каждой итерации.
      IF i > CEILING(num / 2) THEN ITERATE cycle;  -- Если IF условие ложное, то значение добавляется два раза. Если истинное, тогда срабатывает оператор ITERATE и итерация заверщается досрочно.
      END IF;
      SET bin = CONCAT(bin, i);
    END WHILE cycle;
    SELECT bin;
  ELSE
    SELECT 'Ошибочное значение параметра';
  END IF;
END//

CALL numbers_string(9)//



/* Опертор REPEAT похож на оператор WHILE, однако условие для выхода из цикла не в начале тела, а в конце (UNTIL). 
В результате тело цикла в любом случае будет выполняться минимум 1 раз.*/
DROP PROCEDURE IF EXISTS NOW3//
CREATE PROCEDURE NOW3 ()
BEGIN
  DECLARE i INT DEFAULT 3;
  REPEAT
    SELECT NOW();
    SET i = i - 1;
  UNTIL i <= 0
  END REPEAT;
END//

CALL NOW3()//
-- Данная процедура будет выполнена 3 раза


/* Цикл LOOP в отличе от WHILE, REPEAT не имеет условия выхода. Поэтому данный вид цикла, должен всегда иметь оператор LEAVE */
DROP PROCEDURE IF EXISTS NOW3//
CREATE PROCEDURE NOW3 ()
BEGIN
  DECLARE i INT DEFAULT 3;
  cycle: LOOP
    SELECT NOW();
    SET i = i - 1;
    IF i <= 0 THEN LEAVE cycle;
    END IF;
  END LOOP cycle;
END//

CALL NOW3()//