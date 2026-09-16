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
