SELECT  first_name,
        last_name,
        count(*) as ppl_count
FROM clients_1
GROUP BY first_name, last_name
ORDER BY ppl_count DESC;