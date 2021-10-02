SELECT * FROM clients cl 
INNER JOIN  cities ci ON cl.city_id = ci.city_id 
INNER JOIN companies co ON cl.company_id = co.company_id;