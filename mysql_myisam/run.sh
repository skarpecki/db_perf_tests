#!/bin/bash

sudo docker run --name="mysql-myisam_srvr" --cpus=1 -p 3306:3306 --memory="8G" -v mysql-myisam_vol:/var/lib/mysql -d mysql-myisam_srvr
