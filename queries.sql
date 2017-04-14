-- Join involving four relations
--
-- Output should be
--SELECT 
--FROM player p, team t, teamStats s, university u
--WHERE 
-- A self join
-- 
-- Output should be 
SELECT p1.height, p1.lname, p1.tID
FROM player p1, player p2
WHERE p1.tID = p2.tID
AND p1.height > p2.height
ORDER BY p1.tID, p1.weight, p1.lname;
-- UNION, INTERSECT, and/or MINUS
-- 
-- Output should be
-- SUM
-- Find the total number of games played in the season
-- Output should be 
SELECT SUM(s.wins)
FROM team_stats s, team t
WHERE t.teamID = s.tmID;
-- AVG
-- Find the average age of all the players on one team (Use Neumann University)
-- Output should be 21.3
-- SELECT AVG(p.age)
-- FROM player p, team t
-- WHERE t.teamId = 57984 AND p.teamId = t.teamId;
--
--
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
-- Find the average league weight, then find number of players each team has above that weight
-- GROUP BY, HAVING, and ORDER BY
SELECT t.univName, p.lname, p.weight
FROM player p, team t
WHERE t.teamID = p.tID AND p.weight > ANY
                                     (SELECT AVG(p.weight)
                                      FROM player p2)
GROUP BY t.univName
HAVING count(*) > 5
ORDER BY p.weight;
--SELECT p.name, p.age, t.teamName, s.points
--FROM player p, team t, team_stats s
--WHERE p.teamId = t.teamId
--GROUP BY p.name, p.age
--HAVING count(*) > 10
--AND SUM(s.points > 20)
--ORDER BY t.teamName;
--
--
-- Correlated subquery
-- Find every player whose age is above the team average (Use Farmingdale State)
-- Output should be
SELECT DISTINCT p.pid, p.lname
FROM player p
WHERE NOT EXISTS (SELECT gp.goalsScored
		  FROM games_played
		  WHERE gp.pID = p.pid
		  AND gp.goalsScored < 20)
ORDER BY e.lname;
--
--
-- Non-Correlated subquery
-- 
-- Output should be 
--
--
-- Division query
-- 
-- Output should be
--
--
-- Outer join query
-- 
-- Output should be
--
--
-- Rank query
-- The rank of the number 15 in the win category
-- Output should be 2
SELECT RANK (15) WITHIN GROUP
(ORDER BY t.wins ASC)
FROM team_stats t;
--
--
-- Top N query
-- The top 3 teams in the points category 
-- Output should be Neumann, Farmingdale, and West Chester
SELECT t.univName, s.points
FROM (SELECT *
      FROM team t, team_stats s
      WHERE t.teamId = s.teamId
      ORDER BY s.points)
WHERE ROWNUM < 3;
