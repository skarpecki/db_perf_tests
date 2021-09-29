#!/bin/bash

cpus=$1
docker run --name="mariadb-aria_srvr" --cpus=$cpus -p 3306:3306 --memory="8G" -v mariadb-aria_vol:/var/lib/mysql -d mariadb-aria_srvr
