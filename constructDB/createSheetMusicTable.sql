/*
   This script creates the sheetMusic table, largely based off the table of the same name 
   existing in the Penn data. After creating table schema and importing data in from the 
   Penn file, this script populates 'pennSheetMusicSeriesName', and does a join with it,
*/


USE testing;

/* Create schema for sheetMusicMain and populate with Penn data on sheet music */
DROP TABLE IF EXISTS sheetMusicMain;
CREATE TABLE sheetMusicMain (
       sheetMusicID VARCHAR(8) NOT NULL,
       seriesLetter VARCHAR(20) DEFAULT "-",
       titleID VARCHAR(8) DEFAULT "-",
       arrangements VARCHAR(100) DEFAULT "-",
       texts VARCHAR(100) DEFAULT "-",
       publisher VARCHAR(100) DEFAULT "-",
       address VARCHAR(100) DEFAULT "-",
       dateMade VARCHAR(30) DEFAULT "-",
       provenance VARCHAR(150) DEFAULT "-",
       yiddishFirstLine VARCHAR(150) DEFAULT "-",
       notes VARCHAR(1000) DEFAULT "-",
       firstLine VARCHAR(100) DEFAULT "-",
       arranger VARCHAR(100) DEFAULT "-",
       translator VARCHAR(100) DEFAULT "-",
       PRIMARY KEY (sheetMusicID)
);
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennSheetMusic.csv' INTO TABLE sheetMusicMain FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';


/* Create schema for pennSheetMusicSeriesName and populate with Penn data on sheet music series name */
DROP TABLE IF EXISTS pennSheetMusicSeriesName;
CREATE TABLE pennSheetMusicSeriesName (
       id VARCHAR(20) NOT NULL,
       seriesName VARCHAR(20) NOT NULL,
       PRIMARY KEY (id)
);
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennSheetMusicSeriesName.csv' INTO TABLE pennSheetMusicSeriesName FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'; 

/* 
   Perform a join between 'sheetMusicMain' and 'peenSheetMusicSeriesName' to port over the actual series name
   into the 'sheetMusicMain' table.
*/

UPDATE sheetMusicMain
INNER JOIN pennSheetMusicSeriesName
SET sheetMusicMain.seriesLetter=pennSheetMusicSeriesName.seriesName
WHERE sheetMusicMain.seriesLetter=pennSheetMusicSeriesName.id;
DROP TABLE pennSheetMusicSeriesName;
