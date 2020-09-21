USE vk;

-- ТРИГГЕРЫ

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



-- ИНДЕКСЫ
SELECT * FROM users;

-- Рассмотрим запрос
SELECT id, first_name, last_name 
  FROM users 
    WHERE email = 'Mireya12@example.com';

CREATE INDEX users_email_idx ON users(email);

-- Внутренности хранения индексов
-- Представим, что наша таблица выглядит так:
SELECT id, first_name, last_name, email FROM users;

/* После создания индекса на колонку email, MySQL сохранит все ее значения в 
отсортированном виде:
users_email_idx
+-----------------------------+
| acarroll@example.net        |
| alvera.terry@example.org    |
| alyce76@example.com         |
| arianna46@example.net       |
| arielle.murazik@example.org |
| aurelio.abbott@example.org  |
| beatty.tommie@example.com   |
| bergnaum.asia@example.org   |
| bergnaum.donato@example.org |
| blaise68@example.org        |
+-----------------------------+

После этой операции MySQL начнет использовать индекс users_email_idx для выполнения подобных запросов */

-- Сортировка
SELECT * FROM profiles ORDER BY birthday;

-- действует такое же правило — создаем индекс на колонку, по которой происходит сортировка:
CREATE INDEX profiles_birthday_idx ON profiles(birthday);

-- MySQL поддерживает также уникальные индексы. Это удобно для колонок, 
-- значения в которых должны быть уникальными по всей таблице. 

-- Такие индексы улучшают эффективность выборки для уникальных значений. 
SELECT * FROM users WHERE email = 'alexis29@example.org';

-- На колонку email необходимо создать уникальный индекс:
DROP INDEX users_email_idx ON users;
CREATE UNIQUE INDEX users_email_uq ON users(email);
-- СУБД будет знать, что такое значение одно и больше искать не требуется.

-- Составные индексы
-- Рассмотрим такой запрос:
SELECT * FROM messages WHERE from_user_id = 9 AND to_user_id = 3;

-- Нам следует создать составной индекс на обе колонки:
CREATE INDEX messages_from_user_id_to_user_id_idx ON messages (from_user_id, to_user_id);

-- Устройство составного индекса
-- messages_from_user_id_to_user_id_idx
-- 1 3
-- 2 4
-- 3 8
-- ...

-- Сортировка
-- Составные индексы также можно использовать, если выполняется сортировка:
SELECT * FROM profiles WHERE country = 'Russia' ORDER BY birthday;

-- В этом случае нам нужно будет создать индекс в порядке
-- WHERE ORDER BY



-- ОКОННЫЕ ФУНКЦИИ

-- Задача
-- Найти сколько занимают места медиафайлы в разрезе типов в процентном соотношении

-- Решаем традиционным способом, применяя агрегатные функции
SELECT media_types.name, 
  SUM(media.size) AS total_by_type,
  (SELECT SUM(size) FROM media) AS total_size,
  SUM(media.size)/(SELECT SUM(size) FROM media) * 100 AS "%%" 
    FROM media
      JOIN media_types
        ON media.media_type_id = media_types.id
    GROUP BY media.media_type_id;


-- Реализация используя агрегатные функции как оконные
SELECT DISTINCT media_types.name, 
  SUM(media.size) OVER(PARTITION BY media.media_type_id) AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER(PARTITION BY media.media_type_id) / SUM(media.size) OVER() * 100 AS "%%"
    FROM media
      JOIN media_types
        ON media.media_type_id = media_types.id;


-- Расширяем вывод
SELECT DISTINCT media_types.name,
  AVG(media.size) OVER(PARTITION BY media.media_type_id) AS average,
  MIN(media.size) OVER(PARTITION BY media.media_type_id) AS min,
  MAX(media.size) OVER(PARTITION BY media.media_type_id) AS max,
  SUM(media.size) OVER(PARTITION BY media.media_type_id) AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER(PARTITION BY media.media_type_id) / SUM(media.size) OVER() * 100 AS "%%"
    FROM media
      JOIN media_types
        ON media.media_type_id = media_types.id;

-- Выносим окно отдельно
SELECT DISTINCT media_types.name,
  AVG(media.size) OVER w AS average,
  MIN(media.size) OVER w AS min,
  MAX(media.size) OVER w AS max,
  SUM(media.size) OVER w AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER w / SUM(media.size) OVER() * 100 AS "%%"
    FROM (media
      JOIN media_types
        ON media.media_type_id = media_types.id)
        WINDOW w AS (PARTITION BY media.media_type_id);


-- Оконные функции не сворачивают вывод
-- Убираем DISTINCT
SELECT media_types.name,
  AVG(media.size) OVER w AS average,
  MIN(media.size) OVER w AS min,
  MAX(media.size) OVER w AS max,
  SUM(media.size) OVER w AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER w / SUM(media.size) OVER() * 100 AS "%%"
    FROM (media
      JOIN media_types
        ON media.media_type_id = media_types.id)
        WINDOW w AS (PARTITION BY media.media_type_id);


-- Применяем чистые оконные функции
SELECT user_id, city, birthday,
  ROW_NUMBER() OVER w AS 'row_number',
  FIRST_VALUE(city) OVER w AS 'first',
  LAST_VALUE(city) OVER(PARTITION BY LEFT(birthday, 3)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'last',
  NTH_VALUE(city, 2) OVER w AS 'second'
    FROM profiles
      WINDOW w AS (PARTITION BY LEFT(birthday, 3) ORDER BY birthday);


-- ЗАДНИЯ

/* Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
имя группы
среднее количество пользователей в группах
самый молодой пользователь в группе
самый старший пользователь в группе
общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100 */

SELECT DISTINCT 
  communities.name AS group_name,
  COUNT(communities_users.user_id) OVER() / (SELECT COUNT(*) FROM communities) AS avg_users_in_groups,
  FIRST_VALUE(users.id) OVER(PARTITION BY communities.id ORDER BY profiles.birthday DESC) AS youngest_user,
  FIRST_VALUE(users.id) OVER(PARTITION BY communities.id ORDER BY profiles.birthday) AS oldest,
  COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) AS users_in_groups,
  COUNT(communities_users.user_id) OVER() AS users_total,
  COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) / COUNT(communities_users.user_id) OVER() *100 AS '%%'
    FROM communities
      LEFT JOIN communities_users 
        ON communities_users.community_id = communities.id
      JOIN users 
        ON communities_users.user_id = users.id
      JOIN profiles 
        ON profiles.user_id = users.id;