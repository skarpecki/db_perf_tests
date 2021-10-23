SELECT  first_name,
        last_name,
        count(*) as ppl_count
FROM perf_tests.dbo.clients_1
GROUP BY first_name, last_name
ORDER BY ppl_count DESC;