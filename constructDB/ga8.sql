/* This script creates the titles table, which contains the names of all the distinct tracks. */ 

USE testing;

/* Create titles table */
DROP TABLE IF EXISTS titles;
/* pull all the distinct tracks from existing tracks table, and all the pennTitles and unionize */
CREATE TABLE titles ((SELECT DISTINCT(trackName) FROM tracks) UNION DISTINCT (SELECT DISTINCT(title) FROM pennTitles));
ALTER TABLE titles RENAME COLUMN trackName TO titleName;
/* Create titleID field and make it the primary key*/ 
ALTER TABLE titles ADD COLUMN titleID INT NOT NULL AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE titles CHANGE COLUMN titleID titleID VARCHAR(8);
/* Append a 'T' in front of each the titleID's, to establish convention */ 
UPDATE titles SET titleID=CONCAT("T",titleID);

/* Create trackToTitles mapping */ 
DROP TABLE IF EXISTS trackToTitles;

CREATE TABLE trackToTitles SELECT * FROM pennTrackToTitle;
ALTER TABLE trackToTitles MODIFY COLUMN trackID VARCHAR(8) AFTER titleID;
ALTER TABLE trackToTitles ADD COLUMN titleNameTmp VARCHAR(200);

INSERT INTO trackToTitles(trackID,titleNametmp) SELECT DISTINCT(trackID),trackName FROM tracks; 

CREATE INDEX x ON titles(titleName);
CREATE INDEX j ON trackToTitles(titleNametmp);
CREATE INDEX y ON trackToTitles(titleID);
CREATE INDEX z ON titles(titleID);

UPDATE trackToTitles
INNER JOIN titles ON titles.titleName=trackToTitles.titleNametmp
SET trackToTitles.titleID=titles.titleID;

ALTER TABLE trackToTitles DROP COLUMN titleNametmp;

DELETE FROM pennAltTitle WHERE altTitleID NOT IN (SELECT titleID FROM pennTitles) OR titleID NOT IN (SELECT titleID FROM pennTitles);
DELETE FROM pennSheetMusicToTitle WHERE titleID="TITLEID" OR titleID="0";
DELETE FROM pennTrackToTitle WHERE titleID NOT IN (SELECT titleID FROM pennTitles);

/*ALTER TABLE pennTitles ADD PRIMARY KEY (titleID);*/


CREATE INDEX aaa ON pennTitles(titleID);
CREATE INDEX aab ON pennAltTitle(altTitleID);
CREATE INDEX aad ON pennAltTitle(titleID);
CREATE INDEX aac ON pennSheetMusicToTitle(titleID);
CREATE INDEX aad ON pennTrackToTitle(titleID);


ALTER TABLE pennAltTitle ADD FOREIGN KEY (titleID) REFERENCES pennTitles(titleID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE pennAltTitle ADD FOREIGN KEY (altTitleID) REFERENCES pennTitles(titleID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE pennSheetMusicToTitle ADD FOREIGN KEY (titleID) REFERENCES pennTitles(titleID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE pennTrackToTitle ADD FOREIGN KEY (titleID) REFERENCES pennTitles(titleID) ON UPDATE CASCADE ON DELETE CASCADE;
