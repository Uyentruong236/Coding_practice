
/* https://www.hackerrank.com/challenges/average-population-of-each-continent/problem */

SELECT 
	COUNTRY.continent,
	Floor(AVG(CITY.population)) as average_population
FROM CITY
INNER JOIN COUNTRY
ON CITY.CountryCode = Country.code
GROUP BY COUNTRY.continent