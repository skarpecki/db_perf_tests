OPTIONS (SKIP=1, ERRORS=100000, BINDSIZE=8000000, ROWS=5000)

LOAD DATA
	infile '/dane/orders.csv' "str '\r\n'"
	INSERT
	INTO TABLE perf_tests.orders
	FIELDS TERMINATED BY ','
	(
	ORDER_ID,
	PART_NUM,
	CLIENT_ID
    )