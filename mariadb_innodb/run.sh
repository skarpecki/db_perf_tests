#!/bin/bash

cpus=$1
docker run --name="mariadb-innodb_srvr" --cpus=$cpus -p 3306:3306 --memory="8G" -v mariadb-innodb_vol:/var/lib/mysql -d mariadb-innodb_srvr
