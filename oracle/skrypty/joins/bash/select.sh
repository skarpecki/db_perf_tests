#! /bin/bash



declare -a scripts_names=( 
                # 'one_join' 
                'one_join_where'
                # 'two_joins'
                'two_joins_where'
                # 'three_joins'
                'three_joins_where'
                )
scripts_path='/skrypty/joins/sql/selects'
indexed_table=$1
was_indexed=$2
cpus=$3
count=$4
cpus_path='results_'"$cpus"'cpus'

for script_name in "${scripts_names[@]}"
do
    results_path='/home/oracle/results/joins/'"$cpus_path"'/results/select/'"$indexed_table"'/'"$was_indexed"'/'"$script_name"
    script="$scripts_path"'/'"$script_name"'.sql'
    mkdir -p $results_path
    for i in $(seq 0 $count)
    do
        echo "Joins iteration no $i"
        if [[ "$i" -eq "0" ]] 
        then
            echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$script" | head -n 100            
        else
            echo $script_name $indexed_table $was_indexed $i
            ( time echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$script" > /dev/null ) |& tee $results_path/$i.txt
        fi
    done
done
