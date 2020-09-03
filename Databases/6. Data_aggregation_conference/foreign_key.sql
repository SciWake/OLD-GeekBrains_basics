USE vk;

-- Добавляем внешние ключи в БД vk
-- Для таблицы профилей

-- Смотрим структуру таблицы
DESC profiles;

-- Описание синтаксиса запроса
-- Добавляем внешние ключи
ALTER TABLE profiles
/*Есть возможность задать ограниечение бзе использования ключевого слова CONSTRAINT
Это позволит задать сквозное наименование объекта

profiles_user_id_fk Другая интерпритация это, 
profiles - это таблица для которой создаём внешний ключ,
user_id - имя столбца, для которого мы этот ключа создаём,
fk - суффикс типа ключа */
  ADD CONSTRAINT profiles_user_id_fk
    
    /*Определение ключа
    В скобках определяем на какой столбец выставляется ключ
    Определяем куда ссылается данный столбец, для этого используется ключевое слово REFERENCES,
    после ключевого слова указываем таблицу, куда ссылается внешний ключ и в скобках указываем имя столбца */
    FOREIGN KEY (user_id) REFERENCES users(id)
      
      /*После этого внешний ключ может уже быт создан, но обычно, задают дополнительные параметры:
      ON DELETE (что сделать, когда строка удаляется на которую ссылается внешний ключ)
      Если указать CASCADE: при удалении строки, куда ссылается user_id, тогда СУБД автоматически удалит сам профиль*/
      ON DELETE CASCADE,
      
  /*Задаём ключ для photo_id*/
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      -- SET NULL
      ON DELETE SET NULL;


-- Запрос без описания как используются ключевые слова 
-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

-- Изменяем тип столбца при необходимости
ALTER TABLE profiles DROP FOREIGN KEY profiles_user_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;