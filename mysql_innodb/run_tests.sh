#!/bin/bash

cpus=1
./run.sh $cpus
sleep 30
docker exec -it mysql-innodb_srvr /skrypty/group_by_order/run.sh
sleep 1
docker cp mysql-innodb_srvr:/results/ './group_by_order/results_'"$cpus"'cpus'
sleep 1
./prune.sh
sleep 1

cpus=2
./run.sh $cpus
sleep 30
docker exec -it mysql-innodb_srvr /skrypty/group_by_order/run.sh
sleep 1
docker cp mysql-innodb_srvr:/results/ './group_by_order/results_'"$cpus"'cpus'
sleep 1
./prune.sh
sleep 1

cpus=4
./run.sh $cpus
sleep 30
docker exec -it mysql-innodb_srvr /skrypty/group_by_order/run.sh
sleep 1
docker cp mysql-innodb_srvr:/results/ './group_by_order/results__'"$cpus"'cpus'
sleep 1
./prune.sh
sleep 1
