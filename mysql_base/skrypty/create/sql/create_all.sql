USE perf_tests;

CREATE TABLE IF NOT EXISTS clients_1 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);


CREATE TABLE IF NOT EXISTS clients_10 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);


CREATE TABLE IF NOT EXISTS clients_100 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);


CREATE TABLE IF NOT EXISTS clients_1000 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);


CREATE TABLE IF NOT EXISTS clients_10000 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);


CREATE TABLE IF NOT EXISTS clients_100000 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);


CREATE TABLE IF NOT EXISTS clients_1000000 (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);


CREATE TABLE IF NOT EXISTS clients (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);