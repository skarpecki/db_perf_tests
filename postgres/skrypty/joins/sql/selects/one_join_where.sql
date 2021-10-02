SELECT * FROM clients cl
INNER JOIN  cities ci ON cl.city_id = ci.city_id
WHERE cl.first_name='Mercedes'
 	AND ci.city = 'LAKE HELEN';