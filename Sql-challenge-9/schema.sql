DROP SCHEMA IF EXISTS employee_db;
CREATE SCHEMA employee_db;
USE employee_db;

-- Create 'departments' table
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL
);

-- Create 'titles' table
CREATE TABLE titles (
    title_id CHAR(5) PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

-- Create 'employees' table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id CHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT FK_emp_title FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Create 'dept_emp' table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no CHAR(4),
    PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT FK_dept_emp_emp FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    CONSTRAINT FK_dept_emp_dept FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create 'dept_manager' table
CREATE TABLE dept_manager (
    dept_no CHAR(4),
    emp_no INT,
    PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT FK_dept_manager_emp FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    CONSTRAINT FK_dept_manager_dept FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create 'salaries' table
CREATE TABLE salaries (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
    CONSTRAINT FK_salaries_emp FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


LOAD DATA INFILE 'F:/Students and Clients/Students/Super-Prof/Kay/Sql Assignment/data/departments.csv' INTO TABLE departments FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA INFILE 'F:/Students and Clients/Students/Super-Prof/Kay/Sql Assignment/data/titles.csv' INTO TABLE titles FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA INFILE 'F:/Students and Clients/Students/Super-Prof/Kay/Sql Assignment/data/employees.csv' INTO TABLE employees FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES
(emp_no, emp_title_id, @birth_date, first_name, last_name, sex, @hire_date)
SET
    birth_date = STR_TO_DATE(@birth_date, '%m/%d/%Y'),
    hire_date = STR_TO_DATE(@hire_date, '%m/%d/%Y');

LOAD DATA INFILE 'F:/Students and Clients/Students/Super-Prof/Kay/Sql Assignment/data/dept_emp.csv' INTO TABLE dept_emp FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA INFILE 'F:/Students and Clients/Students/Super-Prof/Kay/Sql Assignment/data/dept_manager.csv' INTO TABLE dept_manager FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA INFILE 'F:/Students and Clients/Students/Super-Prof/Kay/Sql Assignment/data/salaries.csv' INTO TABLE salaries FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
