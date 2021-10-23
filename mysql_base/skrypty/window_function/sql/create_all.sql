USE perf_tests;

CREATE TABLE IF NOT EXISTS employees_1 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int,
	salary float
);


CREATE TABLE IF NOT EXISTS employees_10 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int,
	salary float
);


CREATE TABLE IF NOT EXISTS employees_100 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int,
	salary float
);


CREATE TABLE IF NOT EXISTS employees_1000 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int,
	salary float
);


CREATE TABLE IF NOT EXISTS employees_10000 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int,
	salary float
);


CREATE TABLE IF NOT EXISTS employees_100000 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int,
	salary float
);


CREATE TABLE IF NOT EXISTS employees_1000000 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int,
	salary float
);


CREATE TABLE IF NOT EXISTS employees (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int,
	salary float
);

CREATE TABLE departments (
	department_id int PRIMARY KEY,
	`name` varchar(31)
);