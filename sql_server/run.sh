#!/bin/bash

sudo docker run --name="sql_srvr" --cpus=1 -p 1433:1433 --memory="8G" -v mssql-vol:/var/opt/mssql -d sql_server
