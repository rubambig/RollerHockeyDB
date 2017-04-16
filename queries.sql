-- Join involving four relations
-- Find all the players whose team is top 2 in the league with a size < 10,000
-- Order by the last name
-- Output should be all Neumann University players
SELECT P.lname, U.uName, S.points, U.usize
FROM player P, team T, team_stats S, university U
WHERE P.tID = T.teamID AND T.teamID = S.tmID and T.univName = U.uName
      AND S.points >= 30 AND U.Usize < 5000
ORDER BY P.lname;


/*
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


*/
-- AVG, INTERSECT
-- Find the name, and university of all forwards who teams are at the top
-- and whose weights are below the league average
-- Output should be Schultz, Saklad, & DeSalvo
SELECT p.fname, p.lname, t.univName
FROM player p, team t
WHERE t.teamID = p.tID AND p.position = 'F' AND p.weight < ALL
                                     (SELECT AVG(p2.weight)
                                      FROM player p2)
INTERSECT
SELECT P.fname, P.lname, T.univName
FROM player P, team_stats S, team T
WHERE T.teamID = P.tID AND S.points > 30 AND T.teamID = S.tmID;

-- LIKE
-- Find the names, university name, and points for players whose names contain
-- ~O whose teams have more than 25 points, order by the points
-- Output should be O~Shaughnessy and O~Connell
SELECT P.fname, P.lname, T.univName, S.points
FROM player P, team T, team_stats S
WHERE P.tId = T.teamId AND T.teamID = S.tmID AND P.lname LIKE '%O~%'
                       AND S.points > 25
ORDER BY S.points;

-- Correlated subquery
-- Find every player who scored at least 2 goals in Neumann's games
-- Output should be DeSalvo and Fox
SELECT DISTINCT p.playerID, p.lname, p.height, p.position
FROM player p
WHERE EXISTS (SELECT gp.goalsScored
		              FROM games_played gp
		              WHERE gp.pID = p.playerID AND gp.goalsScored >= 2)
ORDER BY p.lname;
--

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


-- Outer join query && GROUP BY, HAVING, and ORDER BY
-- Find the name and size for all universities with more than three locations
-- Output should be University of Rhode Island & UniMass
SELECT U.uName, U.usize, COUNT(*) AS campuses
FROM university U LEFT OUTER JOIN locations L ON U.uName = L.uniName
GROUP BY U.uName, U.usize
HAVING count(*) > 3
ORDER BY U.uName;



-- Rank query
-- The rank of the number 15 in the win category
-- Output should be 2
SELECT RANK (15) WITHIN GROUP (ORDER BY wins DESC) "rank15"
FROM team_stats t;
--

-- Top N query
-- Find the name, jerseyColor and mascot of the top 3 in the points category
-- Output should be Neumann, Farmingdale, and West Chester
SELECT DISTINCT T.univName, T.jerseyColor, T.mascot
FROM team T
WHERE T.teamID IN (SELECT TS.tmID
                   FROM (SELECT tmID FROM team_stats ORDER BY  points DESC) TS
                   WHERE ROWNUM < 3) ;
