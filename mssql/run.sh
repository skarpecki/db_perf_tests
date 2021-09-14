#!/bin/bash

docker run --name="mssql_srvr" --cpus=1 -p 1433:1433 --memory="8G" -v mssql_vol:/var/opt/mssql -d mssql_srvr
