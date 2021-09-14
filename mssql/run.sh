#!/bin/bash

sudo docker run --name="mssql_srvr" --cpus=1 -p 1433:1433 --memory="8G" -v mssql_vol:/var/opt/mssql -d sql_server
