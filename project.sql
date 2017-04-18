SPOOL project.out
SET ECHO ON

/*
CIS 353 - 01 - Database Design Project
Team 1 - Winter 2017
< David Brown >
< Wesley Guthrie >
< Gloire Rubambiza >
< Rebekah Suttner >
*/

DROP TABLE university CASCADE CONSTRAINTS;
DROP TABLE team CASCADE CONSTRAINTS;
DROP TABLE player CASCADE CONSTRAINTS;
DROP TABLE game CASCADE CONSTRAINTS;
DROP TABLE team_stats CASCADE CONSTRAINTS;
DROP TABLE locations CASCADE CONSTRAINTS;
DROP TABLE games_played CASCADE CONSTRAINTS;

/*
 University(*uName*, uSize, yearFounded)
*/
CREATE TABLE university (
  uName         varchar2(50) PRIMARY KEY,
  uSize         number(6),
  yearFounded   number(4),
  CONSTRAINT ICunivNameNODOTS CHECK(NOT(uName LIKE '%.%'))
);
/*
 Team(*teamID*, jerseyColor, mascot, univName)
*/
CREATE TABLE team (
  teamID        number(5) PRIMARY KEY,
  jerseyColor   varchar2(20),
  mascot        varchar2(30),
  univName      varchar2(50),
  CONSTRAINT ICunivNameForeignKey FOREIGN KEY (univName) REFERENCES university(uName)
);
/*
 Player(*playerID*, fname, lname, height, weight, num, position, tID)
*/
CREATE TABLE player (
  playerID    	number(6) PRIMARY KEY,
  fname     	varchar2(30),
  lname    		varchar2(30),
  height     	number(3),
  weight  		number(3),
  num       	number(3),
  position    	char(1),
  tID     		number(5),
  CONSTRAINT ICteamIdForeignKey FOREIGN KEY (tID) REFERENCES team(teamID),
  CONSTRAINT ICjerseynumber CHECK (num > 0 AND num <= 99),
  CONSTRAINT ICjerseynumbergoalie CHECK (NOT (num < 30 AND position = 'G'))
);
/*
 Games(*gameID*, gDate, hscore, ascore, hTID, aTID)
*/
CREATE TABLE game (
  gameID    	number(6) PRIMARY KEY,
  gDate       	date, /* standard date format is DD-MON-YYYY */
  hscore    	number(2),
  ascore    	number(2),
  hTID			number(5),
  aTID			number(5),
  CONSTRAINT IChTIDForeignKey FOREIGN KEY (hTID) REFERENCES team(teamID),
  CONSTRAINT ICaTIDForeignKey FOREIGN KEY (aTID) REFERENCES team(teamID)
);
/*
 TeamStats(*year, tmID*, wins, losses, points)
*/
CREATE TABLE team_stats (
  year        	number(4),
  tmID          number(5),
  wins         	number(2),
  losses     	number(2),
  points        number(2),
  PRIMARY KEY (year,tmID),
  CONSTRAINT ICtmIDForeignKey FOREIGN KEY (tmID) REFERENCES team(teamID)
);
/*
 Locations(*uniName , location*)
*/
CREATE TABLE locations (
  uniName    	varchar2(50),
  location      varchar2(30),
  primary key (uniName,location),
  CONSTRAINT ICuniNameForeignKey FOREIGN KEY(uniName) REFERENCES university(uName)
);
/*
 GamesPlayed(pID, gID, goalsScored)
*/
CREATE TABLE games_played (
  pID    		number(6),
  gID       	number(6),
  goalsScored 	number(2),
  primary key (pID,gID),
  CONSTRAINT ICpIDForeignKey FOREIGN KEY(pID) REFERENCES player(playerID),
  CONSTRAINT ICgIDForeignKey FOREIGN KEY(gID) REFERENCES game(gameID)
);
--------------------------------------------------------------------------------
SET FEEDBACK OFF

/*
  Populate the database
*/
insert into university values('Robert Morris University', 5000, 1921);
insert into university values('Farmingdale State College', 9000, 1912);
insert into university values('West Chester University of Pennsylvania', 16000, 1871);
insert into university values('University of Massachusetts', 79000 , 1863);
insert into university values('University of Rhode Island', 16000, 1892);
insert into university values('Neumann University', 3000, 1965);

insert into team values(57984, 'Navy', 'Knights', 'Neumann University');
insert into team values(57950, 'Green', 'Rams', 'Farmingdale State College');
insert into team values(57966, 'Maroon', 'Minuteman', 'University of Massachusetts');
insert into team values(57958, 'Dark Blue', 'Rams', 'University of Rhode Island');
insert into team values(57959, 'Navy', 'Colonials', 'Robert Morris University');

insert into player values (138942, 'Tyler', 'Kraft', 70, 185, 16, 'F', 57984);
insert into player values (138970, 'Sean', 'Phelan', 72, 200, 96, 'F', 57984);
insert into player values (138962, 'Nicholas', 'DeSalvo', 66, 145, 11, 'F', 57984);
insert into player values (141568, 'Gregory', 'Saklad', 67, 160, 97, 'F', 57984);
insert into player values (138965, 'Michael', 'Strofe', 70, 225, 26, 'F', 57984);
insert into player values (141565, 'Derek', 'Schultz', 73, 170, 98, 'F', 57984);
insert into player values (138969, 'Shane', 'Fox', 70, 170, 13, 'D', 57984);
insert into player values (138966, 'Ryan', 'Carr', 74, 190, 23, 'D', 57984);
insert into player values (139026, 'Andy', 'Zubak', 71, 174, 28, 'D', 57984);
insert into player values (139009, 'Adam', 'Goggio', 76, 175, 37, 'G', 57984);
insert into player values (139715, 'Luc', 'Corso', 70, 175, 11, 'F', 57950);
insert into player values (140701, 'Matthew', 'O~Shaughnessy', 69, 160, 91, 'F', 57950);
insert into player values (139458, 'Rhys', 'Marcel', 71, 180, 2, 'F', 57966);
insert into player values (139315, 'Justin', 'O~Connell', 74, 185, 12, 'D', 57966);
insert into player values (139633, 'Will', 'Lalor', 70, 175, 47, 'F', 57958);
insert into player values (139602, 'Ryan', 'O~Regan', 69, 150, 5, 'F', 57958);

insert into locations values('Robert Morris University', 'Moon, PA');
insert into locations values('Farmingdale State College', 'Farmingdale, NY');
insert into locations values('University of Massachusetts', 'Amherst, MA' );
insert into locations values('University of Massachusetts', 'Boston, MA' );
insert into locations values('University of Massachusetts', 'North Dartmouth, MA' );
insert into locations values('University of Rhode Island', 'Kingston, RI' );
insert into locations values('University of Rhode Island', 'Providence, RI');
insert into locations values('University of Rhode Island', 'Narragansett, RI');
insert into locations values('Neumann University', 'Aston, PA' );

insert into team_stats values(2017, 57984, 16, 2, 32);
insert into team_stats values(2017, 57950, 15, 3, 30);
insert into team_stats values(2017, 57966, 13, 5, 26);
insert into team_stats values(2017, 57958, 11, 6, 23);
insert into team_stats values(2017, 57959, 4, 13, 9);

insert into game values(511, '22-Nov-2016', 3, 0, 57984, 57966);
insert into game values(512, '28-Nov-2016', 2, 3, 57958, 57984);
insert into game values(513, '30-Nov-2016', 5, 1, 57984, 57958);

insert into games_played values(138969, 511, 3);
insert into games_played values(138966, 511, 0);
insert into games_played values(138970, 511, 0);
insert into games_played values(138942, 511, 0);
insert into games_played values(138962, 511, 0);
insert into games_played values(138969, 512, 1);
insert into games_played values(138970, 512, 0);
insert into games_played values(138942, 512, 0);
insert into games_played values(138962, 512, 2);
insert into games_played values(139026, 512, 0);
insert into games_played values(138969, 513, 2);
insert into games_played values(138966, 513, 0);
insert into games_played values(139009, 513, 0);
insert into games_played values(138965, 513, 3);
insert into games_played values(139026, 513, 0);
-------------------------------------------------------------------------------
SET FEEDBACK ON
COMMIT;

/*
  Printing out the databases
*/
SELECT * FROM university;
SELECT * FROM team;
SELECT * FROM player;
SELECT * FROM game;
SELECT * FROM team_stats;
SELECT * FROM locations;
SELECT * FROM games_played;
--------------------------------------------------------------------------------
/*
  Database Queries
*/
/*
 Q1 - Join Involving Four Relations
For all the players who weigh more than 180lbs, whose team has points greater 
than or equal to 30 and a university population of less than 10,000, find the 
last name, university name, total points, university name, and university size, 
order by the last name.
*/

SELECT P.lname, U.uName, S.points, U.usize
FROM player P, team T, team_stats S, university U
WHERE P.tID = T.teamID AND T.teamID = S.tmID AND T.univName = U.uName
      AND S.points >= 30 AND U.Usize < 10000 AND P.weight >= 175
ORDER BY P.lname;

/*
Q2 - A Self-Join
For all pairs of players on Neumann with the first player weighing more than
200 pounds, and the first player is taller and weighs more than the second
player, find the last name and weights of each pair.
Output should be Strofe/Desalvo & Strofe/Saklad
*/
SELECT p1.lname, p1.weight, p1.height, p2.lname, p2.weight, p2.height
FROM player p1, player p2
WHERE p1.weight > 200 AND p1.weight > p2.weight AND
      p1.height > p2.height AND p1.tID = 57984 AND
      p1.tID = p2.tID;

/*
 Q3 - MIN
Find the minimum player weight in the league.
Output should be 145
*/
SELECT MIN(p.weight)
FROM player p;

/*
Q4 - AVG, INTERSECT
For all forwards whose team is the top team in the league and weight
below the league average, find the first name, last name, university name.
Output should be Schultz, Saklad, & DeSalvo
*/
SELECT p.fname, p.lname, t.univName
FROM player p, team t
WHERE t.teamID = p.tID AND p.position = 'F' AND p.weight < ALL
                                     (SELECT AVG(p2.weight)
                                      FROM player p2)
INTERSECT
SELECT P.fname, P.lname, T.univName
FROM player P, team_stats S, team T
WHERE T.teamID = P.tID AND S.points > 30 AND T.teamID = S.tmID;

/*
Q5 LIKE
For all players whose names contain O~ and belong to teams with more than
25 points, find the names, university name, and points, order by total the points.
Output should be O~Shaughnessy and O~Connell
*/
SELECT P.fname, P.lname, T.univName, S.points
FROM player P, team T, team_stats S
WHERE P.tId = T.teamId AND T.teamID = S.tmID AND P.lname LIKE '%O~%'
                       AND S.points > 25
ORDER BY S.points;

/*
Q6 - Correlated subquery
For every player who scored at least 2 goals in Neumann's games, find the
playerID, last name, height and position.
Output should be DeSalvo, Fox, and Strofe
*/
SELECT DISTINCT p.playerID, p.lname, p.height, p.position
FROM player p
WHERE EXISTS (SELECT gp.goalsScored
		              FROM games_played gp
		              WHERE gp.pID = p.playerID AND gp.goalsScored >= 2)
ORDER BY p.lname;

/*
Q7 - Non-Correlated Qubquery
For all universities founded after the average university finding year
and a student population less than 6000, find the name,
size, and yearfound, order by year founded
Output should be Robert Morris University and Neumann University
*/
SELECT U.uName, U.uSize, U.yearFounded
FROM university U
WHERE U.uSize < 6000 AND
      U.yearFounded NOT IN ( SELECT AVG(Utwo.yearFounded)
                             FROM university Utwo
                            )
ORDER BY U.yearFounded;

/*
Q8 - Division Query
For all players that played in every Neumann University game, find the first
name, last name, playerID.
Output should be Shane Fox
*/
SELECT P.fname, P.lname, P.playerID
FROM player P
WHERE NOT EXISTS((SELECT G.gameID
                 FROM game G
                 WHERE G.hTID = 57984 OR G.aTID = 57984)
                 MINUS
                 (SELECT GP.gID
                  FROM games_played GP
                  WHERE GP.pID = P.playerID AND P.tID = 57984));

/*
Q9 - OUTER JOIN, GROUP BY, HAVING, and ORDER BY
For all universities with more than two locations, find the name, size and
number of campuses, order by university name
Output should be University of Rhode Island & Univeristy of Massachusetts
*/
SELECT U.uName, U.usize, COUNT(*) AS campuses
FROM university U LEFT OUTER JOIN locations L ON U.uName = L.uniName
GROUP BY U.uName, U.usize
HAVING count(*) > 2
ORDER BY U.uName;


/*
Q10 - Rank query
Find the rank of '15' in the win category
Output should be 2
*/
SELECT RANK (15) WITHIN GROUP (ORDER BY wins DESC) "rank15"
FROM team_stats t;

/*
Q11 - Top N query
For the top 2 teams in the points category, Find the name, jerseyColor and mascot.
Output should be Neumann State College and Farmingdale University
*/
SELECT DISTINCT T.univName, T.jerseyColor, T.mascot
FROM team T
WHERE T.teamID IN (SELECT TS.tmID
                   FROM (SELECT tmID FROM team_stats ORDER BY  points DESC) TS
                   WHERE ROWNUM < 3) ;
-------------------------------------------------------------------------------

/*
Testing: < ICJERSEYNUMBERGOALIE >
*/
insert into player values (	139613,	'Evan',	'Hosney',	70,	160,	1,	'G',	57958	);

/*
Testing: < ICJERSEYNUMBER >
*/
insert into player values (	123456,	'Gloire',	'Rubambiza',	71,	140,	100,	'G',	57958	);

/*
Testing: < ICUNIVNAMENODOTS >
*/
insert into university values ('G.V.S.U', 25000, 1960);

/*
Testing: < ICUNIVNAMEFOREIGNKEY >
*/
insert into team values(51984, 'Red', 'I Love China', 'Trump University');

/*
Testing: < ICUNIVNAMEFOREIGNKEY >
*/
insert into game values(514, '30-Nov-2016', 5, 1, 57922, 57946);

/*
Testing: < ICPIDFOREIGNKEY >
*/
insert into games_played values(139011, 513, 0);

/*
Testing: < ICUNINAMEFOREIGNKEY >
*/
insert into locations values('Grand Valley State University', 'Grand Rapids, MI');

/*
Testing: < ICTMIDFOREIGNKEY >
*/
insert into team_stats values(2017, 57901, 3, 14, 7 );

COMMIT;
--------------------------------------------------------------------------------
SPOOL OFF
