-- CricketBoard Table
CREATE TABLE CricketBoard (
    BoardID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(30),
    Address VARCHAR(50),
    Contact_No NUMBER
);

-- Team Table
CREATE TABLE Team (
    TeamID VARCHAR(10) PRIMARY KEY,
    BoardID VARCHAR(10),
    Name VARCHAR(30),
    Coach VARCHAR(30),
    Captain VARCHAR(30),
    FOREIGN KEY (BoardID) REFERENCES CricketBoard(BoardID)
);

-- Player Table
CREATE TABLE Player (
    PlayerID VARCHAR(6) PRIMARY KEY,
    TeamID VARCHAR(10),
    FName VARCHAR(30),
    LName VARCHAR(30),
    Age NUMBER(5,2),
    DateofBirth DATE,
    PlayingRole VARCHAR(25),
    Email VARCHAR(40),
    Contact_No NUMBER,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- Match Table
CREATE TABLE Match (
    MatchID VARCHAR(10) PRIMARY KEY,
    TeamID1 VARCHAR(10),
    TeamID2 VARCHAR(10),
    Match_Date DATE,
    Time1 NUMBER,
    Result VARCHAR(20),
    FOREIGN KEY (TeamID1) REFERENCES Team(TeamID),
    FOREIGN KEY (TeamID2) REFERENCES Team(TeamID)
);

-- Ground Table
CREATE TABLE Ground (
    GroundID VARCHAR(10) PRIMARY KEY,
    MatchID VARCHAR(10),
    Name VARCHAR(30),
    Location VARCHAR(30),
    Capacity NUMBER,
    FOREIGN KEY (MatchID) REFERENCES Match(MatchID)
);

-- Umpire Table
CREATE TABLE Umpire (
    UmpireID VARCHAR(10) PRIMARY KEY,
    FName VARCHAR(30),
    LName VARCHAR(30),
    Age NUMBER(5,2),
    DateofBirth DATE,
    Country VARCHAR(30),
    Email VARCHAR(40),
    Contact_No NUMBER
);

-- Umpire_Umpired Table
CREATE TABLE Umpire_Umpired (
    UmpireID VARCHAR(10),
    MatchID VARCHAR(10),
    GroundID VARCHAR(10),
    FOREIGN KEY (UmpireID) REFERENCES Umpire(UmpireID),
    FOREIGN KEY (MatchID) REFERENCES Match(MatchID),
    FOREIGN KEY (GroundID) REFERENCES Ground(GroundID)
);




CREATE TABLE Team_Player (
    TeamID VARCHAR(10),
    PlayerID VARCHAR(6),
    PRIMARY KEY (TeamID, PlayerID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);

CREATE TABLE Match_Team (
    MatchID VARCHAR(10),
    TeamID VARCHAR(10),
    PRIMARY KEY (MatchID, TeamID),
    FOREIGN KEY (MatchID) REFERENCES Match(MatchID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);




ALTER TABLE Player
ADD CONSTRAINT check_con CHECK (Age >= 18);



ALTER TABLE Umpire RENAME COLUMN contact_no TO phone_no;

-- To verify:
DESC Umpire;



-- Create a new user
CREATE USER Raj IDENTIFIED BY kumar;

-- Grant privileges
GRANT RESOURCE TO Raj;
GRANT CREATE SESSION TO Raj;

-- Connect as the new user
CONNECT Raj/kumar;

-- Create a sample table as Raj
CREATE TABLE emp (
    eno NUMBER,
    ename VARCHAR(10)
);

-- Reconnect as system/admin
CONNECT system/manager;

-- Grant full privileges on Umpire table to Raj
GRANT ALL ON Umpire TO Raj;


