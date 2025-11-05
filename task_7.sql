-- ======================================================
-- 7.a Create a Trigger to Automatically Insert Match Results
-- ======================================================

-- Creating the Match_Result table
CREATE TABLE Match_Result (
    ResultID VARCHAR2(10) PRIMARY KEY,
    MatchID  VARCHAR2(10),
    TeamID   VARCHAR2(10),
    Result   VARCHAR2(20),
    FOREIGN KEY (MatchID) REFERENCES Match(MatchID),
    FOREIGN KEY (TeamID)  REFERENCES Team(TeamID)
);

-- Creating the Trigger
CREATE OR REPLACE TRIGGER trg_insert_match_result
AFTER INSERT ON Match
FOR EACH ROW
DECLARE
    N NUMBER;
BEGIN
    N := INSTR(UPPER(:NEW.Result), 'WIN');

    IF N > 0 AND INSTR(UPPER(:NEW.Result), UPPER(:NEW.TeamID1)) > 0 THEN
        INSERT INTO Match_Result (ResultID, MatchID, TeamID, Result)
        VALUES ('R' || :NEW.MatchID || '1', :NEW.MatchID, :NEW.TeamID1, 'WIN');
        INSERT INTO Match_Result (ResultID, MatchID, TeamID, Result)
        VALUES ('R' || :NEW.MatchID || '2', :NEW.MatchID, :NEW.TeamID2, 'FAIL');
    ELSE
        INSERT INTO Match_Result (ResultID, MatchID, TeamID, Result)
        VALUES ('R' || :NEW.MatchID || '1', :NEW.MatchID, :NEW.TeamID1, 'FAIL');
        INSERT INTO Match_Result (ResultID, MatchID, TeamID, Result)
        VALUES ('R' || :NEW.MatchID || '2', :NEW.MatchID, :NEW.TeamID2, 'WIN');
    END IF;
END;
/
-- Trigger created successfully.

-- Sample Data Insertion
INSERT INTO Match VALUES ('M01', 'CCB01', 'TCB01', DATE '2022-06-22', 1.3, 'TCB01 - WIN');
INSERT INTO Match VALUES ('M02', 'CCB02', 'TCB02', DATE '2022-06-22', 8.3, 'CCB01 - WIN');
INSERT INTO Match VALUES ('M03', 'TRICB01', 'TCB01', DATE '2022-06-24', 8.3, 'TCB01 - WIN');
INSERT INTO Match VALUES ('M04', 'TRICB01', 'TCB02', DATE '2022-06-25', 8.3, 'TRICB01 - WIN');
INSERT INTO Match VALUES ('M05', 'TCB01', 'TCB02', DATE '2025-09-20', 16.00, 'TCB02 - WIN');

-- Verify Trigger Output
SELECT * FROM Match_Result;


-- ======================================================
-- 7.b Create a View Showing Player and Team Details
-- ======================================================

CREATE OR REPLACE VIEW Player_Team_View AS
SELECT 
    p.PlayerID,
    p.FName       AS FirstName,
    p.PlayingRole AS PlayingRole,
    p.Batting     AS BattingStyle,
    p.Bowling     AS BowlingStyle,
    t.TeamID,
    t.Name        AS TeamName,
    t.Coach,
    t.Captain
FROM Player p
JOIN Team t ON p.TeamID = t.TeamID;
/

-- Retrieve View Data
SELECT * FROM Player_Team_View;
/

-- ======================================================
-- 7.c Procedure to Retrieve Even-Numbered PlayerIDs (with Exception Handling)
-- ======================================================

CREATE OR REPLACE PROCEDURE Get_Even_PlayerIDs_For_Matches IS
    CURSOR even_players IS
        SELECT DISTINCT 
            p.PlayerID, 
            p.FName, 
            p.LName, 
            m.MatchID
        FROM Player p
        JOIN Team t ON p.TeamID = t.TeamID
        JOIN Match m ON (m.TeamID1 = t.TeamID OR m.TeamID2 = t.TeamID)
        WHERE MOD(TO_NUMBER(REGEXP_SUBSTR(p.PlayerID, '\d+$')), 2) = 0;

    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Even-numbered PlayerIDs registered for Matches:');

    FOR rec IN even_players LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('MatchID: ' || rec.MatchID ||
                             ' | PlayerID: ' || rec.PlayerID ||
                             ' | Name: ' || rec.FName || ' ' || rec.LName);
    END LOOP;

    -- Exception Handling: No matching records
    IF v_count = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No even-numbered PlayerIDs found for any match.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
-- Enable output
SET SERVEROUTPUT ON;

-- Execute the procedure
EXEC Get_Even_PlayerIDs_For_Matches;
/
