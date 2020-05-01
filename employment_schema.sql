-- Create the table schema
create table departments(
	dept_no varchar(255) primary key,
	dept_name varchar(255)
);

create table dept_emp(
	emp_no integer not null,
	foreign key (emp_no) references employees(emp_no),
	dept_no varchar(255) not null,
	foreign key (dept_no) references departments(dept_no),
	from_date varchar(255),
	to_date varchar(255)
);

create table dept_manager(
	dept_no varchar(255) not null,
	foreign key (dept_no) references departments(dept_no),
	emp_no integer not null,
	foreign key (emp_no) references employees(emp_no),
	from_date varchar(255),
	to_date varchar(255)
);

create table employees(
	emp_no serial primary key,
	birth_date varchar(255),
	first_name varchar(255),
	last_name varchar(255),
	gender varchar(30),
	hire_date varchar(255)
);

create table salaries(
	emp_no integer not null,
	foreign key (emp_no) references employees(emp_no),
	salary integer not null,
	from_date varchar(255),
	to_date varchar(255)
);

create table titles(
	emp_no integer not null,
	foreign key (emp_no) references employees(emp_no),
	title varchar(255),
	from_date varchar(255),
	to_date varchar(255)
);

-- 1. List employee number, last name, first name, gender, and salary for each employee
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from salaries s
left join employees e
on e.emp_no = s.emp_no;

-- 2. List employees who where hired in 1986
select * from employees
where hire_date like '%1986';

-- 3. List department number, department name, manager employee number, last name, first name, start date and end date for each department
select e.emp_no, e.last_name, e.first_name, d.dept_no, d.dept_name, m.from_date, m.to_date
from departments d
left join dept_manager m
on m.dept_no = d.dept_no
left join employees e
on m.emp_no = e.emp_no;

--  4. List employee number, last name, first name and department name for each employee
select e.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp p
left join departments d
on d.dept_no = p.dept_no
left join employees e
on e.emp_no = p.emp_no;

-- 5. List all employees whose first name is Hercules and last name begins with B
select * from employees
where first_name = 'Hercules' and last_name like 'B%';

-- 6. List employee number, last name, first name and department name from the Sales department
select e.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp p
left join employees e
on e.emp_no = p.emp_no
left join departments d
on d.dept_no = p.dept_no
where d.dept_name = 'Sales'

-- 7. List employee number, last name, first name and department name from the Sales and Development departments
select e.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp p
left join employees e
on e.emp_no = p.emp_no
left join departments d
on d.dept_no = p.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development'

-- 8. List employee last name frequency in descending order
select count(last_name), last_name from employees
group by last_name
order by count(last_name) desc