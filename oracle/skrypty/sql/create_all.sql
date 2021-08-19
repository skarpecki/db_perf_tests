ALTER SESSION SET CONTAINER = ORCLPDB1;

DECLARE
user_exist integer;
BEGIN
  SELECT count(*) INTO user_exist FROM dba_users WHERE username='PERF_TESTS';
  IF (user_exist = 0) THEN
    EXECUTE IMMEDIATE 'CREATE USER PERF_TESTS IDENTIFIED BY password';
   	EXECUTE IMMEDIATE 'GRANT CONNECT TO perf_tests CONTAINER=CURRENT';
  	EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO perf_tests CONTAINER=CURRENT';
 	EXECUTE IMMEDIATE 'GRANT RESOURCE TO perf_tests CONTAINER=CURRENT';
 	EXECUTE IMMEDIATE 'ALTER USER perf_tests QUOTA 2000M ON USERS';
  END IF;
END;

ALTER SESSION SET CURRENT_SCHEMA = PERF_TESTS;



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
	name varchar(50),
	sector varchar(50),
	legal_form varchar(50)
);


CREATE TABLE departments (
	department_id int PRIMARY KEY,
	name varchar(50)
);


CREATE TABLE orders (
	order_id int PRIMARY KEY,
	part_num varchar(50),
	client_id int
);


