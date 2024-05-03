CREATE TABLE employees (
    emp_no SERIAL PRIMARY KEY,
    emp_title_id VARCHAR(5),
    birth_date DATE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    sex CHAR(1),
    hire_date DATE
);

CREATE TABLE salaries (
    emp_no INT,
    salary INT,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles (
	title_id VARCHAR(5) NOT NULL PRIMARY KEY,
	title VARCHAR(50)
);

CREATE TABLE departments (
	dept_no VARCHAR(5) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(50)
);


CREATE TABLE dept_manager (
	dept_no VARCHAR(5),
	emp_no INT,
	CONSTRAINT dept_mgr_pk PRIMARY KEY(emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR(5),
	CONSTRAINT dept_emp_pk PRIMARY KEY(emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

Select * from dept_emp where dept_emp_id ='10001d005'

--List the employee number, last name, first name, sex, and salary of each employee
SELECT DISTINCT e.emp_no, last_name, first_name, sex, salary FROM employees e 
JOIN salaries s on s.emp_no = e.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1985-12-31' AND '1987-01-01';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT e.emp_no, last_name, first_name, d.dept_no, dept_name FROM employees e
JOIN dept_manager dm ON dm.emp_no=e.emp_no
JOIN departments d on d.dept_no=dm.dept_no
ORDER by dept_name;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT d.dept_no, dept_name, e.emp_no, last_name, first_name FROM employees e
JOIN dept_emp de ON de.emp_no=e.emp_no
JOIN departments d on d.dept_no=de.dept_no
ORDER by dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, last_name, first_name FROM employees e
JOIN dept_emp de ON de.emp_no=e.emp_no
JOIN departments d ON d.dept_no=de.dept_no
WHERE dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, dept_name FROM employees e
JOIN dept_emp de ON de.emp_no=e.emp_no
JOIN departments d ON d.dept_no=de.dept_no
WHERE dept_name IN ('Sales', 'Development')
ORDER BY dept_name;

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) FROM employees
GROUP BY last_name
