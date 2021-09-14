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