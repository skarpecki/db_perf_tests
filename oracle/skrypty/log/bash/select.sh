#! /bin/bash

selects_path="/skrypty/log/sql/selects"
count=$2

for script in $selects_path/*.sql
do
script_name=$(basename $script .sql)
was_indexed=$1
indexed_table=$(basename $script_name _all)
indexed_table=$(basename $script_name _where)

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/log/'"$cpus_path"'/results/select/'"$indexed_table"'/'"$was_indexed"'/'"$script_name"

mkdir -p $results_path
    for i in $(seq 0 $count)
    do
        echo "Log select iteration $i"
        if [[ "$i" -eq "0" ]] 
        then
            echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$script" | head -n 100
        else
            echo $script_name $was_indexed $i
            ( time echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$script" > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
        fi
    done
done
