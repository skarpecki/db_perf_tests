#! /bin/bash

no_of_inserts=1000


for j in $(seq 0 "$no_of_inserts")
do
    id="$(( 100001 + $j ))"
    first_name="$(tr -dc a-z < /dev/urandom | head -c 5)"
    last_name="$(tr -dc a-z < /dev/urandom | head -c 15)"
    email="$first_name"'.'"$last_name"'@org.com'
    insert='INSERT INTO perf_tests.clients 
            (client_id, first_name, last_name, email, city_id, department_id, company_id)
            VALUES '"('${id}' , '${first_name}' , '${last_name}' , '${email}', 1, 1, 1);" 
            
    if [[ "$j" -eq "0" ]] 
    then
        echo "$insert" | sqlplus PERF_TESTS/password@ORCLPDB1 
    else
        echo "$insert" | sqlplus PERF_TESTS/password@ORCLPDB1 > /dev/null
    fi
done

