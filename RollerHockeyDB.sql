-- File: RollerHockeyDB.sql  
--
-- Drop the tables (in case they already exist)
--
DROP TABLE player CASCADE CONSTRAINTS;
DROP TABLE game CASCADE CONSTRAINTS;
DROP TABLE team CASCADE CONSTRAINTS;
DROP TABLE university CASCADE CONSTRAINTS;
DROP TABLE team_stats CASCADE CONSTRAINTS;
DROP TABLE locations CASCADE CONSTRAINTS;
DROP TABLE games_played CASCADE CONSTRAINTS;
--
-- Create the tables
--
/*Player(*playerID*, fname, lname, height, weight, num, position, tID)*/
--
CREATE TABLE player (
  playerID    number(6) PRIMARY KEY,
  fname     	varchar2(30),  
  lname    		varchar2(30),
  height     	number(3),
  weight   		number(3),
  num       	number(2),
  position    char(1),
  tID    		  number(5)
);
--
/*Games(*gameID*, gDate, hscore, ascore)*/

--
CREATE TABLE game (
  gameID      number(5) PRIMARY KEY,
  gDate       date, /* standard date format is DD-MON-YY */
  hscore    	number(2),
  ascore    	number(2)
);
--
/*University(*uName*, uSize, yearFounded)*/
--
CREATE TABLE university (
  uName      	varchar2(15) PRIMARY KEY,
  uSize       	number(6),
  yearFounded  number(4)
);
--
/*Team(*teamID*, jerseyColor, mascot, univName)*/
--
CREATE TABLE team (
  teamID       	number(5) PRIMARY KEY,
  jerseyColor  	varchar2(20),  
  mascot		    varchar2(30),
  univName   	  varchar2(50)
);
--
/*TeamStats(*year, tmID*, wins, losses, points)*/
--
CREATE TABLE team_stats (
  year        	number(4),
  tmID          number(5),
  wins         	number(2),
  losses     	  number(2),
  points        number(2),
  primary key (year,tmID)
);
--
/*Locations(*uniName , location*)*/
--
CREATE TABLE locations (
  uniName    	  varchar2(50),
  location      varchar2(30),
  primary key (uniName,location)
);
--
/*GamesPlayed(pID, gID, goalsScored)*/
--
CREATE TABLE games_played (
  pID    		  number(6),
  gID       	number(5),
  goalsScored number(2),
  primary key (pID,gID)
);
--
-- Add the foreign keys:
ALTER TABLE player
ADD FOREIGN KEY (tID) references team(teamID)
Deferrable initially deferred;
ALTER TABLE team
ADD FOREIGN KEY (univName) references university(uName)
Deferrable initially deferred;
ALTER TABLE team_stats
ADD FOREIGN KEY (tmID) references team(teamID)
Deferrable initially deferred;
ALTER TABLE locations
ADD FOREIGN KEY (uniName) references university(uName)
Deferrable initially deferred;
ALTER TABLE games_played
ADD FOREIGN KEY (pID) references player(playerID)
Deferrable initially deferred;
ALTER TABLE games_played
ADD FOREIGN KEY (gID) references game(gameID)
Deferrable initially deferred;
--
-- ----------------------------------------------------------
-- Populate the database
-- ----------------------------------------------------------
--
alter session set  NLS_DATE_FORMAT = 'YYYY-MM-DD';
--
--
insert into player values (	138942,	'Tyler',	'Kraft',	70,	185,	16,	'F',	57984	);
insert into player values (	138969,	'Sean',	'Phelan',	72,	200,	96,	'F',	57984	);
insert into player values (	138962,	'Nicholas',	'DeSalvo',	66,	145,	11,	'F',	57984	);
insert into player values (	141568,	'Gregory',	'Saklad',	67,	160,	97,	'F',	57984	);
insert into player values (	138965,	'Michael',	'Strofe',	70,	225,	26,	'F',	57984	);
insert into player values (	141565,	'Derek',	'Schultz',	73,	170,	98,	'F',	57984	);
insert into player values (	138969,	'Shane',	'Fox',	70,	170,	13,	'D',	57984	);
insert into player values (	138966,	'Ryan',	'Carr',	74,	190,	23,	'D',	57984	);
insert into player values (	139026,	'Andy',	'Zubak',	71,	174,	28,	'D',	57984	);
insert into player values (	139009,	'Adam',	'Goggio',	76,	175,	37,	'G',	57984	);
insert into player values (	139715,	'Luc',	'Corso',	70,	175,	11,	'F',	57950	);
insert into player values (	140701,	'Matthew',	'O', 'Shaughnessy',	69,	160,	91,	'F',	57950	);
insert into player values (	141874,	'PJ',	'DiMartino',	68,	160,	6,	'F',	57950	);
insert into player values (	139717,	'Chris',	'Russolello',	68,	175,	55,	'F',	57950	);
insert into player values (	139760,	'Nick',	'Tarasco',	70,	165,	97,	'F',	57950	);
insert into player values (	139441,	'Josh',	'Weger',	72,	190,	98,	'F',	57950	);
insert into player values (	139576,	'Matthew',	'Cicchetti',	70,	170,	81,	'D',	57950	);
insert into player values (	139438,	'Matthew',	'Catania',	69,	150,	14,	'D',	57950	);
insert into player values (	139663,	'Jonathan',	'Krumholz',	65,	140,	8,	'D',	57950	);
insert into player values (	139573,	'Nicholas',	'Walker',	71,	195,	88,	'D',	57950	);
insert into player values (	139547,	'Timothy',	'Janke',	72,	160,	24,	'D',	57950	);
insert into player values (	139719,	'Michael',	'Gonzalez',	69,	175,	86,	'D',	57950	);
insert into player values (	139425,	'Bobby',	'Litras',	69,	155,	9,	'D',	57950	);
insert into player values (	139651,	'Dustin',	'Muccio-Schrimpe',	72,	180,	70,	'G',	57950	);
insert into player values (	140061,	'Daniel',	'Perepezko',	72,	130,	37,	'G',	57950	);
insert into player values (	139682,	'Tim',	'Bowen',	73,	190,	92,	'F',	57946	);
insert into player values (	139674,	'David',	'Delseni',	69,	195,	17,	'F',	57946	);
insert into player values (	139677,	'Steve',	'Brown',	66,	160,	12,	'F',	57946	);
insert into player values (	139683,	'Nicholas',	'Hirsh',	69,	175,	27,	'F',	57946	);
insert into player values (	139684,	'Nick',	'Foster',	71,	185,	97,	'F',	57946	);
insert into player values (	139687,	'Justin',	'Giannantonio',	69,	150,	29,	'F',	57946	);
insert into player values (	139676,	'Jason',	'Kichline',	67,	150,	23,	'D',	57946	);
insert into player values (	139675,	'Lucas',	'Denczi',	70,	195,	20,	'D',	57946	);
insert into player values (	139681,	'Kyle',	'Green',	81,	190,	69,	'D',	57946	);
insert into player values (	139698,	'Derek',	'Hoffman',	67,	135,	8,	'D',	57946	);
insert into player values (	139686,	'Mike',	'Sabol',	73,	180,	21,	'D',	57946	);
insert into player values (	141205,	'Ryan',	'Hollingshead',	69,	169,	7,	'D',	57946	);
insert into player values (	139678,	'John',	'Whitman',	75,	225,	30,	'G',	57946	);
insert into player values (	139707,	'Brandon',	'McComsey',	72,	200,	35,	'G',	57946	);
insert into player values (	141555,	'Aaron',	'Marcel',	72,	195,	22,	'F',	57966	);
insert into player values (	139284,	'Joseph',	'Petruzziello',	68,	165,	13,	'F',	57966	);
insert into player values (	140014,	'Ryan',	'Dougherty',	74,	205,	97,	'F',	57966	);
insert into player values (	139797,	'Ronan',	'Carrier',	68,	160,	15,	'F',	57966	);
insert into player values (	139458,	'Rhys',	'Marcel',	71,	180,	2,	'F',	57966	);
insert into player values (	139635,	'Kurt',	'Leavitt',	73,	180,	77,	'F',	57966	);
insert into player values (	139742,	'Nicholas',	'Boccelli',	71,	160,	19,	'F',	57966	);
insert into player values (	139743,	'John',	'Carroll',	70,	175,	14,	'F',	57966	);
insert into player values (	139540,	'Nickolas',	'Chappell',	70,	170,	6,	'D',	57966	);
insert into player values (	138987,	'Ryan',	'Wolsiefer',	70,	165,	5,	'D',	57966	);
insert into player values (	139321,	'Shawn',	'Lapp',	69,	160,	3,	'D',	57966	);
insert into player values (	139537,	'Donald',	'Brodd',	69,	165,	21,	'D',	57966	);
insert into player values (	139315,	'Justin',	'O', 'Connell',	74,	185,	12,	'D',	57966	);
insert into player values (	139641,	'Christopher',	'Duffy',	67,	150,	10,	'D',	57966	);
insert into player values (	139314,	'Jordan',	'Davis',	67,	150,	91,	'G',	57966	);
insert into player values (	139633,	'Will',	'Lalor',	70,	175,	47,	'F',	57958	);
insert into player values (	139349,	'Gil',	'Lederhandler',	68,	185,	2,	'F',	57958	);
insert into player values (	139756,	'DJ',	'Davis',	72,	190,	91,	'F',	57958	);
insert into player values (	139602,	'Ryan',	'O', 'Regan',	69,	150,	5,	'F',	57958	);
insert into player values (	139653,	'Robert',	'Pratt',	72,	155,	8,	'F',	57958	);
insert into player values (	139434,	'Daniel',	'Harrison',	73,	180,	4,	'F',	57958	);
insert into player values (	139630,	'Brendan',	'Winne',	66,	150,	26,	'F',	57958	);
insert into player values (	139739,	'Dylan',	'Narodowy',	71,	175,	15,	'F',	57958	);
insert into player values (	139740,	'Ben',	'Pawlak',	66,	125,	16,	'F',	57958	);
insert into player values (	139757,	'Stephen',	'Falkowski',	72,	160,	97,	'D',	57958	);
insert into player values (	139758,	'Kyle',	'Alvanas',	69,	160,	6,	'D',	57958	);
insert into player values (	139657,	'Christopher',	'Malanga',	70,	230,	77,	'D',	57958	);
insert into player values (	140053,	'Matt',	'Cyrus',	73,	190,	22,	'D',	57958	);
insert into player values (	139613,	'Evan',	'Hosney',	70,	160,	1,	'G',	57958	);
insert into player values (	139925,	'Michael',	'Macchia',	71,	140,	31,	'G',	57958	);
--
--

COMMIT;

