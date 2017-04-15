/*-- Join involving four relations
--
-- Output should be
SELECT
FROM player p, team t, teamStats s, university u
WHERE
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
-- who are goalies
-- GROUP BY, HAVING, and ORDER BY
*/
SELECT DISTINCT p.lname, p.fname
FROM player p, team t
WHERE t.teamID = p.tID AND p.position = 'G' AND p.weight > ALL
                                     (SELECT AVG(p2.weight)
                                      FROM player p2)
GROUP BY p.lname
HAVING count(*) < 2
ORDER BY p.lname;
/*
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
SELECT DISTINCT p.playerID, p.lname
FROM player p
WHERE NOT EXISTS (SELECT gp.goalsScored
		  FROM games_played gp
		  WHERE gp.pID = p.playerID
		  AND gp.goalsScored < 20)
ORDER BY p.lname;
--
*/
-- Non-Correlated subquery
-- Find a university that was is not among the universities founded before the average
-- finding year and the population is < 6000, order by year founded
-- Output should be Robert Morris University / Neumann University
SELECT U.uName, U.uSize, U.yearFounded
FROM university U
WHERE U.uSize < 6000 AND
      U.yearFounded NOT IN ( SELECT AVG(Utwo.yearFounded)
                       FROM university Utwo
                      )
ORDER BY U.yearFounded;



-- Division query
-- Find which player(s) from the Neumann University played in all games 57984
-- Output should be Fox Shane
SELECT P.fname, P.lname, P.playerID
FROM player P
WHERE NOT EXISTS((SELECT G.gameID
                 FROM game G
                 WHERE G.hTID = 57984 OR G.aTID = 57984)
                 MINUS
                 (SELECT GP.gID
                  FROM games_played GP
                  WHERE GP.pID = P.playerID AND P.tID = 57984));


-- Outer join query
-- Find the name and size for all universities with more than three locations
-- Output should be University of Rhode Island & UniMass
SELECT U.uName, U.usize, COUNT(*) AS campuses
FROM university U LEFT OUTER JOIN locations L ON U.uName = L.uniName
GROUP BY U.uName, U.usize
HAVING count(*) > 3;



-- Rank query
-- The rank of the number 15 in the win category
-- Output should be 2
SELECT RANK (15) WITHIN GROUP (ORDER BY wins DESC) "rank15"
FROM team_stats t;
--

-- Top N query
-- The top 3 teams in the points category
-- Output should be Neumann, Farmingdale, and West Chester
SELECT T.univName, T.jerseyColor, T.mascot
FROM team T
WHERE T.teamID IN (SELECT TS.tmID
                   FROM (SELECT tmID FROM team_stats ORDER BY  points DESC) TS
                   WHERE ROWNUM < 4)
ORDER BY T.univName;
