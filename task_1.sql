-- From the document: Create Table CricketBoard
SQL>create table CricketBoard(BoardID varchar(10) PRIMARY KEY, Name varchar(30), Address varchar(50), Contact_No number);

-- Create Table Team
SQL> create table Team(TeamID varchar(10) PRIMARY KEY, BoardID varchar(10), Name varchar(30), Coach varchar(30), Captain varchar(30), FOREIGN KEY(BoardID) REFERENCES CricketBoard(BoardID));

-- Create Table Player
SQL> CREATE table Player(PlayerID varchar(6) PRIMARY KEY, TeamID varchar(10),  FName varchar(30), LName varchar(30), Age number(5,2), DateofBirth date, PlayingRole varchar(25), email varchar(40), contact_no number, FOREIGN KEY(TeamID) REFERENCES Team(TeamID));

-- Create Table Match
SQL> create table Match( MatchID varchar(10), TeamID1 varchar(10), TeamID2 varchar(10), Match_Date date, Time1 number, Result varchar(20), PRIMARY KEY(MatchID), FOREIGN KEY(TeamID1) REFERENCES team(TeamID), FOREIGN KEY(TeamID2) REFERENCES team(TeamID));

-- Create Table Ground
SQL> create table Ground(GroundID varchar(10) PRIMARY KEY, MatchID Varchar(10), Name varchar(30), Location varchar(30), Capacity number, FOREIGN KEY(MatchID) REFERENCES Match(MatchID));

-- Create Table Umpire
SQL> Create Table Umpire(UmpireID varchar(10) PRIMARY KEY, FName varchar(30), LName varchar(30), Age number(5,2), DateofBirth date, Country varchar(30), email varchar(40), contact_no number);

-- Create Table Umpire_Umpired
SQL> create table Umpire_Umpired(UmpireID varchar(10), MatchID Varchar(10), GroundID varchar(10), FOREIGN KEY(UmpireID) REFERENCES Umpire(UmpireID), FOREIGN KEY(MatchID) REFERENCES Match(MatchID), FOREIGN KEY(GroundID) REFERENCES Ground(GroundID));
