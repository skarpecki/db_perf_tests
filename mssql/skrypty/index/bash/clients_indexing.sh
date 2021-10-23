#! /bin/bash

count=$1

for pow in $(seq 0 7)
do
    if [[ "$pow" -ne "7" ]]
    then
        val="_$(( 10 ** $pow ))"
    else
        val=""
    fi

    for i in $(seq 0 $count)
    do
        echo "Indexing iteration: $i"
        create_index='CREATE NONCLUSTERED INDEX IX_clients'"$val"' ON perf_tests.dbo.clients'"$val"' (first_name, last_name);'
        drop_index='DROP INDEX IX_clients'"$val"' ON perf_tests.dbo.clients'"$val"';'
        results_path='/results/index/clients'"$val"
        mkdir -p "$results_path"

        if [[ "$i" -eq "0" ]]
        then
            /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD \
                -Q "$create_index"
        else
            ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD \
                -Q "$create_index" > /dev/null) \
                |& tee "$results_path"'/'"$i"'.txt'
        fi
        /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD \
            -Q "$drop_index"
    done
done