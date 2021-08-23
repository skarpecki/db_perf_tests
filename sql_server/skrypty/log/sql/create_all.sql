USE perf_tests;

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='clients_1')
BEGIN
	CREATE TABLE clients_1 (
		client_id int PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		city_id int,
		department_id int,
		company_id int
	);
END


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='clients_10')
BEGIN
	CREATE TABLE clients_10 (
		client_id int PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		city_id int,
		department_id int,
		company_id int
	);
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='clients_100')
BEGIN
	CREATE TABLE clients_100 (
		client_id int PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		city_id int,
		department_id int,
		company_id int
	);
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='clients_1000')
BEGIN
	CREATE TABLE clients_1000 (
		client_id int PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		city_id int,
		department_id int,
		company_id int
	);
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='clients_10000')
BEGIN
	CREATE TABLE clients_10000 (
		client_id int PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		city_id int,
		department_id int,
		company_id int
	);
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='clients_100000')
BEGIN
	CREATE TABLE clients_100000 (
		client_id int PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		city_id int,
		department_id int,
		company_id int
	);
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='clients_1000000')
BEGIN
	CREATE TABLE clients_1000000 (
		client_id int PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		city_id int,
		department_id int,
		company_id int
	);
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='clients')
BEGIN
	CREATE TABLE clients (
		client_id int PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		city_id int,
		department_id int,
		company_id int
	);
END