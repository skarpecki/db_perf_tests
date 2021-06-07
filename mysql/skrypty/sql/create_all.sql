USE perf_tests;

CREATE TABLE employees (
	employee_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	address_id int,
	department_id int,
	company_id int
);


CREATE TABLE addresses (
	address_id int PRIMARY KEY,
	country varchar(50),
	city varchar(50),
	postal_code varchar(50),
	house_number varchar(50),
	mobile_phone varchar(50)
);


CREATE TABLE companies (
	company_id int PRIMARY KEY,
	`name` varchar(50),
	sector varchar(50),
	legal_form varchar(50)
);


CREATE TABLE departments (
	department_id int PRIMARY KEY,
	`name` varchar(50)
);


