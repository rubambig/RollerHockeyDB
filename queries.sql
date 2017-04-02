-- Join involving four relations
--
-- Output should be


-- A self join
-- 
-- Output should be 


-- UNION, INTERSECT, and/or MINUS
-- 
-- Output should be


-- SUM
-- Find the total number of games played in the season
-- Output should be 
SELECT SUM(t.wins)
FROM team t;


-- AVG
-- Find the average age of all the players on one team (Use Neumann University)
-- Output should be 21.3
SELECT AVG(p.age)
FROM player p, team t
WHERE t.teamId = 57984 AND p.teamId = t.teamId;


-- MAX
-- Find the maximum 
-- Output should be
SELECT MAX(p.weight)
FROM player p;

-- MIN
-- Find the minimum 
-- Output should be
SELECT MIN(p.weight)
FROM player p;

-- GROUP BY, HAVING, and ORDER BY
-- For every team that has more than 20 points, and more than 10 players, give the player name, age, team name, and number of points the team has
-- output should be all players from Farmingdale, West Chester, Massachusetts, and Rhode Island
SELECT p.name, p.age, t.teamName, s.points
FROM player p, team t, team_stats s
WHERE p.teamId = t.teamId
GROUP BY p.name, p.age
HAVING count(*) > 12
AND SUM(s.points > 20)
ORDER BY t.teamName;


-- Correlated subquery
-- Find every player whose age is above the team average (Use Farmingdale State)
-- Output should be
SELECT 
FROM
WHERE


-- Non-Correlated subquery
-- 
-- Output should be 


-- Division query
-- 
-- Output should be


-- Outer join query
-- 
-- Output should be


-- Rank query
-- The rank of the number 15 in the win category
-- Output should be 2
SELECT RANK (15) WITHIN GROUP
(ORDER BY t.wins ASC)
FROM team t;


-- Top N query
-- The top 3 teams in the points category 
-- Output should be Neumann, Farmingdale, and West Chester
SELECT t.univName, s.points
FROM (SELECT *
      FROM team t, team_stats s
      WHERE t.teamId = s.teamId
      ORDER BY s.points)
WHERE ROWNUM < 3;
