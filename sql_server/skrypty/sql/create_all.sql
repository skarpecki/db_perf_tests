USE perf_tests;

CREATE TABLE clients (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	city_id int,
	department_id int,
	company_id int
);


CREATE TABLE cities (
	city_id int PRIMARY KEY,
	country varchar(50),
	city varchar(50),
	postal_code varchar(50)
);


CREATE TABLE companies (
	company_id int PRIMARY KEY,
	[name] varchar(50),
	sector varchar(50),
	legal_form varchar(50)
);


CREATE TABLE departments (
	department_id int PRIMARY KEY,
	[name] varchar(50),
);


CREATE TABLE orders (
	oreder_id int PRIMARY KEY,
	part_num varchar(50),
	client_id int
);