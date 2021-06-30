#!/bin/bash

sudo docker run --name="mysql_srvr" --cpus=1 -p 3306:3306 --memory="8G" -v mysql-vol:/var/lib/mysql -d mysql_srvr
