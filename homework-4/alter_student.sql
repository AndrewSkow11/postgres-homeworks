-- сделано в другой базе данных
CREATE DATABASE db_students
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- 1. Создать таблицу student с полями
--student_id serial,
--first_name varchar,
--last_name varchar,
--birthday date,
--phone varchar

CREATE TABLE student
(
	student_id serial,
	first_name varchar,
	last_name varchar,
	birthday date,
	phone varchar,


	CONSTRAINT pk_student_student_id
	PRIMARY KEY (student_id)
)

-- 2. Добавить в таблицу student колонку middle_name varchar

ALTER TABLE student
ADD COLUMN middle_name varchar;
-- для проверки
SELECT * FROM student;

-- 3. Удалить колонку middle_name
ALTER TABLE student
DROP COLUMN middle_name;


-- 4. Переименовать колонку birthday в birth_date
ALTER TABLE student
RENAME birthday TO birth_date;


-- 5. Изменить тип данных колонки phone на varchar(32)
ALTER TABLE student
ALTER COLUMN phone
SET DATA TYPE varchar(32);

-- date example 2022-06-16

-- 6. Вставить три любых записи с автогенерацией идентификатора
INSERT INTO student (first_name, last_name, birth_date, phone)
VALUES
('Name 1', 'Last 1', '2000-01-01', '+3 1234'),
('Name 2', 'Last 2', '2000-02-01', '+3 1235'),
('Name 3', 'Last 3', '2000-03-01', '+3 1236');

-- 7. Удалить все данные из таблицы со сбросом идентификатор
-- в исходное состояние
TRUNCATE TABLE student RESTART IDENTITY;

