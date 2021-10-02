COPY clients
FROM '/dane/clients_100000.csv'
DELIMITER ',' 
CSV HEADER;