-- ======================================================
-- 5.1 Retrieve all cricket boards and their teams
-- ======================================================
SELECT 
    cb.Name AS CricketBoard, 
    t.Name AS Team
FROM CricketBoard cb
JOIN Team t ON cb.BoardID = t.BoardID;

-- Expected Output:
-- Displays each Cricket Board with its respective teams.


-- ======================================================
-- 5.2 List all matches along with the teams and their captains
-- ======================================================
SELECT 
    m.MatchID,
    m.Match_Date,
    m.Result,
    t1.TeamID   AS Team1_ID,
    t1.Name     AS Team1_Name,
    t1.Captain  AS Team1_Captain,
    t2.TeamID   AS Team2_ID,
    t2.Name     AS Team2_Name,
    t2.Captain  AS Team2_Captain
FROM Match m
JOIN Team t1 ON m.TeamID1 = t1.TeamID
JOIN Team t2 ON m.TeamID2 = t2.TeamID
ORDER BY m.MatchID;

-- Expected Output:
-- Each match with both teams and their captains.


-- ======================================================
-- 5.3 Count the number of matches played by each team
-- ======================================================
SELECT 
    t.TeamID,
    t.Name AS Team_Name,
    COUNT(m.MatchID) AS Matches_Played
FROM Team t
JOIN Match m ON (t.TeamID = m.TeamID1 OR t.TeamID = m.TeamID2)
GROUP BY t.TeamID, t.Name
ORDER BY Matches_Played DESC;

-- Expected Output:
-- Each team with number of matches played.


-- ======================================================
-- 5.4 Find all players who are part of the team named 'TIGER ROCK'
-- ======================================================
SELECT 
    p.PlayerID,
    p.FName,
    p.TeamID,
    t.Coach,
    t.Captain
FROM Player p
JOIN Team t ON p.TeamID = t.TeamID
WHERE t.Name = 'TIGER ROCK';

-- Expected Output:
-- Player list of team “TIGER ROCK”.


-- ======================================================
-- 5.5 Retrieve all team details including count of winning matches
-- ======================================================
SELECT 
    t.TeamID,
    t.Name AS TeamName,
    t.Coach,
    t.Captain,
    COUNT(m.MatchID) AS WinningMatchCount
FROM Team t
LEFT JOIN Match m ON t.TeamID = SUBSTR(m.Result, 1, 5)
GROUP BY t.TeamID, t.Name, t.Coach, t.Captain;

-- Expected Output:
-- Teams with count of matches they have won.


-- ======================================================
-- 5.6 Retrieve total number of 'Tie' matches team-wise
-- ======================================================
SELECT 
    t.TeamID,
    t.Name AS Team_Name,
    COUNT(m.MatchID) AS Tie_Matches
FROM Team t
JOIN Match m ON (t.TeamID = m.TeamID1 OR t.TeamID = m.TeamID2)
WHERE UPPER(m.Result) LIKE '%TIE%'
GROUP BY t.TeamID, t.Name
ORDER BY Tie_Matches DESC;

-- Expected Output:
-- Team list with number of Tie matches.


-- ======================================================
-- 5.7 Retrieve team details who won the matches
-- ======================================================
SELECT DISTINCT 
    t.TeamID,
    t.BoardID,
    t.Name AS Team_Name,
    t.Coach,
    t.Captain
FROM Team t
JOIN Match m
    ON (
        (INSTR(m.Result, m.TeamID1) > 0 AND t.TeamID = m.TeamID1)
        OR 
        (INSTR(m.Result, m.TeamID2) > 0 AND t.TeamID = m.TeamID2)
    );

-- Expected Output:
-- Teams that have won matches.


-- ======================================================
-- 5.8 Retrieve players and match details of players above 25 years old
-- ======================================================
SELECT 
    p.PlayerID,
    p.FName,
    p.LName,
    p.Age,
    p.PlayingRole,
    t.TeamID,
    t.Name AS Team_Name,
    m.MatchID,
    m.Match_Date,
    m.Result
FROM Player p
JOIN Team t ON p.TeamID = t.TeamID
JOIN Match m ON (t.TeamID = m.TeamID1 OR t.TeamID = m.TeamID2)
WHERE p.Age > 25
ORDER BY p.PlayerID, m.MatchID;

-- Expected Output:
-- Players above 25 years with related match details.


-- ======================================================
-- 5.9 Retrieve team details of teams who have NOT played any matches
-- ======================================================
SELECT 
    t.TeamID,
    t.BoardID,
    t.Name AS Team_Name,
    t.Coach,
    t.Captain
FROM Team t
WHERE t.TeamID NOT IN (
    SELECT TeamID1 FROM Match
    UNION
    SELECT TeamID2 FROM Match
);

-- Expected Output:
-- Teams that have not participated in any match.


-- ======================================================
-- 5.10 Retrieve teamid, boardid, teamname, and playername for a given playerid
-- ======================================================
SELECT 
    t.TeamID,
    t.BoardID,
    t.Name AS TeamName,
    p.FName AS PlayerName
FROM Team t
JOIN Player p ON t.TeamID = p.TeamID
WHERE p.PlayerID = '66';

-- Expected Output:
-- Displays the team and player details for the given PlayerID.

