# Домашнее задание к занятию "`Базы данных`" - `Орешкин Евгений`


### Задание 1


Опишите не менее семи таблиц, из которых состоит база данных. Определите:

какие данные хранятся в этих таблицах,
какой тип данных у столбцов в этих таблицах, если данные хранятся в PostgreSQL.
Начертите схему полученной модели данных. Можете использовать онлайн-редактор: https://app.diagrams.net/

Этапы реализации:

Внимательно изучите предоставленный вам файл с данными и подумайте, как можно сгруппировать данные по смыслу.
Разбейте исходный файл на несколько таблиц и определите список столбцов в каждой из них.
Для каждого столбца подберите подходящий тип данных из PostgreSQL.
Для каждой таблицы определите первичный ключ (PRIMARY KEY).
Определите типы связей между таблицами.
Начертите схему модели данных. На схеме должны быть чётко отображены:
все таблицы с их названиями,
все столбцы с указанием типов данных,
первичные ключи (они должны быть явно выделены),
линии, показывающие связи между таблицами.
Результатом выполнения задания должен стать скриншот получившейся схемы базы данных.
<img width="1177" height="530" alt="image" src="https://github.com/user-attachments/assets/6aeccef0-cc1d-49f5-94e7-f34bc430d52d" />

### Задание 2
Разверните СУБД Postgres на своей хостовой машине, на виртуальной машине или в контейнере docker.
Опишите схему, полученную в предыдущем задании, с помощью скрипта SQL.
Создайте в вашей полученной СУБД новую базу данных и выполните полученный ранее скрипт для создания вашей модели данных.
В качестве решения приложите SQL скрипт и скриншот диаграммы.

Для написания и редактирования sql удобно использовать специальный инструмент dbeaver.

CREATE TABLE project (
    project_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE department_type (
    department_type_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE department (
    department_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    department VARCHAR(255) NOT NULL,
    department_type_id INTEGER NOT NULL,

    CONSTRAINT fk_department_type_id
        FOREIGN KEY (department_type_id)
        REFERENCES department_type(department_type_id)
);

CREATE TABLE filial_address (
    filial_address_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    filial_address VARCHAR(255) NOT NULL
);

CREATE TABLE job_title (
    job_title_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    job_title VARCHAR(255) NOT NULL
);

CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    salary NUMERIC(12, 2) NOT NULL,
    job_title_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,
    hire_date DATE NOT NULL,
    filial_address_id INTEGER NOT NULL,

    CONSTRAINT fk_job_title_id
        FOREIGN KEY (job_title_id)
        REFERENCES job_title(job_title_id),

    CONSTRAINT fk_department_id
        FOREIGN KEY (department_id)
        REFERENCES department(department_id),

    CONSTRAINT fk_filial_address_id
        FOREIGN KEY (filial_address_id)
        REFERENCES filial_address(filial_address_id)
);

CREATE TABLE employee_project (
    employee_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,

    PRIMARY KEY (employee_id, project_id),

    CONSTRAINT fk_employee_id
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    CONSTRAINT fk_project_id
        FOREIGN KEY (project_id)
        REFERENCES project(project_id)
);



<img width="515" height="289" alt="image" src="https://github.com/user-attachments/assets/59d75fe0-8038-4f73-b9b2-ea51c1a55fa2" />
