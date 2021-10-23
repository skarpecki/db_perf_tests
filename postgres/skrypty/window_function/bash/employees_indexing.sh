#! /bin/bash

for pow in $(seq 0 7)
do
    if [[ "$pow" -ne "7" ]]
    then
        val="_$(( 10 ** $pow ))"
    else
        val=""
    fi

    index_first_name='CREATE INDEX IX_employees'"$val"'_first_name ON perf_tests.employees'"$val"' (first_name);'
    index_last_name='CREATE INDEX IX_employees'"$val"'_last_name ON perf_tests.employees'"$val"' (last_name);'
    index_email='CREATE INDEX IX_employees'"$val"'_email ON perf_tests.employees'"$val"' (email);'
    index_salary='CREATE INDEX IX_employees'"$val"'_salary ON perf_tests.employees'"$val"' (salary);'

    mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "$index_first_name"
    mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "$index_last_name"
    mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "$index_email"
    mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "$index_salary"

done