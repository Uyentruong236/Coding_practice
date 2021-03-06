
/*
https://www.hackerrank.com/challenges/full-score/problem
*/

S.HACKER_ID, 
H.NAME 
FROM SUBMISSIONS S 
LEFT JOIN CHALLENGES C 
    ON S.CHALLENGE_ID=C.CHALLENGE_ID 
LEFT JOIN DIFFICULTY D 
    ON D.DIFFICULTY_LEVEL=C.DIFFICULTY_LEVEL 
LEFT JOIN HACKERS H 
    ON H.HACKER_ID=S.HACKER_ID 
    WHERE S.SCORE=D.SCORE 
GROUP BY S.HACKER_ID, H.NAME 
HAVING COUNT(H.HACKER_ID) >1 
ORDER BY COUNT(*) DESC, S.HACKER_ID