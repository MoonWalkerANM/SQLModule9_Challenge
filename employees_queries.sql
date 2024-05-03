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
SELECT last_name, COUNT(*) AS frequency_count FROM employees
GROUP BY last_name
ORDER BY frequency_count DESC
