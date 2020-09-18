/* Триггер — специальная хранимая процедура, привязанная к событию изменения содержимого таблицы.
Существуют три события изменения таблицы, к которым можно привязать триггер: 
  это изменение содержимого таблицы при помощи команд INSERT, DELETE и UPDATE. 
  Триггеры могут выполняться до и после каждой из этих команд, поэтому существуют три BEFORE- и три AFTER-триггера, 
которые на рисунке обозначены белыми прямоугольниками.
 */
 

DELIMITER //

/* 
Для создания триггера используется команда CREATE TRIGGER. После команды следует имя триггера, далее при помощи ключевого слова AFTER указывается, 
что триггер запускается уже после выполнения команды. В данном случае — после команды INSERT для таблицы catalogs.

Между ключевыми словами BEGIN и END располагается тело триггера. Внутри составного тела триггера между ключевыми словами BEGIN и END допускаются 
все специфичные для хранимых процедур операторы и конструкции.

В триггере мы извлекаем количество записей в таблице catalogs и помещаем это значение в переменную @total. 
Воспользуемся триггером. */

CREATE TRIGGER catalogs_count AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
  SELECT COUNT(*) INTO @total FROM catalogs;
END//

-- Для этого достаточно вставить новую запись в таблицу catalogs:
INSERT INTO catalogs VALUES (NULL, 'Мониторы')//

-- Извлечем записи:
SELECT * FROM catalogs//

-- И давайте убедимся, что переменная @total установлена:
SELECT @total//



-- Получить список триггеров можно при помощи команды SHOW TRIGGERS:
SHOW TRIGGERS//

-- За удаление отвечает команда DROP TRIGGER. Давайте удалим ранее созданный триггер catalogs_count:
DROP TRIGGER catalogs_count//

-- Чтобы избежать ошибок, как и во многих других командах MySQL, мы можем использовать ключевое слово IF EXISTS.
DROP TRIGGER IF EXISTS catalogs_count//


/* Триггеры очень сложно использовать, не имея доступа к новым записям, которые вставляются в таблицу, или старым записям, которые обновляются или удаляются. 
Для доступа к новым и старым записям используются префиксы NEW и OLD соответственно. 

То есть, если в таблице обновляется поле name, то получить доступ к старому значению можно по имени OLD.name, а к новому — NEW.name. */


/* Давайте создадим триггер, который при вставке новой товарной позиции в таблицу products будет следить за состоянием внешнего ключа catalog_id. 
Если внешний ключ будет оставаться незаполненным, триггер будет извлекать из таблицы catalogs наименьший идентификатор id и назначать его записи. 

Эти действия нужно выполнить до вставки записи в таблицу, поэтому воспользуемся BEFORE-триггером:

В триггере мы объявляем переменную id и извлекаем в нее наименьшее значение идентификатора из таблицы catalogs. Далее, если вставляемое значение catalog_id 
не инициализировано, вместо него вставляется значение переменной id. Если пользователь передает значение catalog_id, оно остается неизменным. Для доступа к 
данным, которые пользователь хочет вставить в таблицу products, мы используем ключевое слово NEW.*/

CREATE TRIGGER check_catalog_id_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  DECLARE cat_id INT;
  SELECT id INTO cat_id FROM catalogs ORDER BY id LIMIT 1;
  SET NEW.catalog_id = COALESCE(NEW.catalog_id, cat_id);
END//

/* Функция COALESCE возвращает первое не NULL-значение и довольно интенсивно используется в SQL-программировании: */

SELECT COALESCE(NULL, NULL, NULL, 1, 2, 3)//
-- 1
SELECT COALESCE(NULL, 3, NULL)//
-- 3

-- Давайте вставим в таблицу products записи без указания внешнего ключа catalog_id:
INSERT INTO products
  (name, description, price)
VALUES
  ('AMD RYZEN 5 1600', 'Процессор AMD', 13200.00)//

SELECT id, name, price, catalog_id FROM products//
-- Как видим, товарная позиция автоматически получает значение 1, в то же время, если мы вставим внешний ключ явно, то:


INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('ASUS PRIME Z370-P', 'HDMI, SATA3, PCI Express 3.0,, USB 3.1', 9360.00, 2)//

SELECT id, name, price, catalog_id FROM products//


/* В таблицу попадет значение из запроса, триггер не будет вносить коррективы в параметры запроса. 
Итак, мы добились того, чтобы значение внешнего ключа корректировалось при вставке. 
Однако мы по-прежнему можем сделать поле catalog_id при помощи команды UPDATE: */

UPDATE products SET catalog_id = NULL WHERE name = 'AMD RYZEN 5 1600'//

SELECT id, name, price, catalog_id FROM products//


/* Мы можем создать триггер и для команды UPDATE. Давайте при попытке назначить полю catalog_id значение будем оставлять текущее, 
если оно отлично от NULL, или заменять его не NULL-значением. Если и текущее и новое значения принимают значение NULL, будем 
назначать наименьшее значение из таблицы catalogs.*/
CREATE TRIGGER check_catalog_id_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  DECLARE cat_id INT;
  SELECT id INTO cat_id FROM catalogs ORDER BY id LIMIT 1;
  SET NEW.catalog_id = COALESCE(NEW.catalog_id, OLD.catalog_id, cat_id);
END//


UPDATE products SET catalog_id = NULL WHERE name = 'AMD RYZEN 5 1600'//
SELECT id, name, price, catalog_id FROM products//

UPDATE products SET catalog_id = 3 WHERE name = 'MSI B250M GAMING PRO'//
SELECT id, name, price, catalog_id FROM products//

UPDATE products SET catalog_id = NULL WHERE name = 'MSI B250M GAMING PRO'//
SELECT id, name, price, catalog_id FROM products//
