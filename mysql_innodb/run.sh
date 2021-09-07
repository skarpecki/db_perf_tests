#!/bin/bash

sudo docker run --name="mysql-innodb_srvr" --cpus=4 -p 3306:3306 --memory="8G" -v mysql-innodb_vol:/var/lib/mysql -d mysql-innodb_srvr
