USE testing;

/* 
    Script to create the 'hebrewTitle' table.  


/* Create hebrewTitle table based off of Penn data of the same name */
DROP TABLE IF EXISTS hebrewTitle;
CREATE TABLE hebrewTitle (
  hebrewTitleID VARCHAR(8) NOT NULL,
  title VARCHAR(100) DEFAULT "-",
  pennTrackID VARCHAR(8) DEFAULT "-",
  hebrewTitle VARCHAR(200) DEFAULT "-",
  hebrewFirstLine VARCHAR(300) DEFAULT "-",
  PRIMARY KEY (hebrewTitleID)
);
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennHebrewTitle.csv' INTO TABLE hebrewTitle FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

/* Make copy of hebrewTitle table */ 
DROP TABLE IF EXISTS hebrewTitleRaw;
CREATE TABLE hebrewTitleRaw SELECT * FROM hebrewTitle;

/* 
   Purpose of this join with itself essentially, is to remove duplicate rows on basis of 
   same hebrewTitle, hebrewFirstLine, and title. Better suited to do this in PYTHON 
*/
DELETE t1 FROM hebrewTitle t1
INNER JOIN hebrewTitle t2
WHERE
    t1.hebrewTitleID < t2.hebrewTitleID AND
    t1.hebrewTitle = t2.hebrewTitle AND
    t1.hebrewFirstLine = t2.hebrewFirstLine AND
    t1.title = t2.title;

/* Create the 'trackToHebrewTitle' mapping table. 
DROP TABLE IF EXISTS trackToHebrewTitle;
CREATE TABLE trackToHebrewTitle (
  trackID VARCHAR(8) NOT NULL,
  hebrewTitleID VARCHAR(8) NOT NULL,
  PRIMARY KEY (trackID,hebrewTitleID)
);

/* 
   Insert all the track to 'hebrewTitleID' mappings into 'trackToHebrewTitle' by performing necessary joins. Shouldn't have to 
   have the 'hebrewTitleRaw' table in the first place, if we use PYTHON 
*/
INSERT INTO trackToHebrewTitle SELECT pennMain.trackID,hebrewTitle.hebrewTitleID FROM  hebrewTitleRaw,hebrewTitle,pennMain WHERE hebrewTitle.hebrewTitle = hebrewTitleRaw.hebrewTitle AND hebrewTitle.hebrewFirstLine = hebrewTitleRaw.hebrewFirstLine AND hebrewTitle.title = hebrewTitleRaw.title AND pennMain.pennID=hebrewTitleRaw.pennTrackID;

/* Don't need 'hebrewTitleRaw' anymore */
DROP TABLE hebrewTitleRaw;

/* Don't need the pennTrackID column in this table anymore */ 
ALTER TABLE hebrewTitle DROP COLUMN pennTrackID;
