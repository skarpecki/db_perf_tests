USE perf_tests;

CREATE TABLE IF NOT EXISTS clients (
	client_id int PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50)
);