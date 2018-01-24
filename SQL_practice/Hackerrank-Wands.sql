/* https://www.hackerrank.com/challenges/harry-potter-and-wands/problem */

SELECT 
w.id, 
p.age, 
w.coins_needed, 
w.power 
FROM Wands w
INNER JOIN Wands_Property p 
ON w.code = p.code where p.is_evil=0 
AND w.coins_needed =
    (SELECT MIN(Wands.coins_needed) 
     FROM Wands 
     INNER JOIN Wands_Property 
     ON Wands.code=Wands_Property.code 
     WHERE Wands_Property.age=p.age and Wands.power=w.power) 
ORDER BY w.power DESC, p.age DESC