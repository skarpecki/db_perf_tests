#! /bin/bash

no_of_inserts=1000


for j in $(seq 0 "$no_of_inserts")
do
    id="$(( 100001 + $j ))"
    first_name="$(tr -dc a-z < /dev/urandom | head -c 5)"
    last_name="$(tr -dc a-z < /dev/urandom | head -c 15)"
    email="$first_name"'.'"$last_name"'@org.com'
    insert='INSERT INTO perf_tests.dbo.clients SELECT '"'${id}' , '${first_name}' , '${last_name}' , '${email}', 1, 1, 1 ;" 
    if [[ "$j" -eq "0" ]] 
    then
        /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "$insert"
    else
        /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "$insert" &> /dev/null
    fi
done

