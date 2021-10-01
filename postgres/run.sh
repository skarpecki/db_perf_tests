#!/bin/bash

cpus=$1
docker run --name="postgres_srvr" --cpus=$cpus -p 5432:5432 --memory="8G" -v postgres_vol:/var/lib/postgresql/data -d postgres_srvr