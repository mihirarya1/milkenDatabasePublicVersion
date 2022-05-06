USE testing;

/* Create and load the hebrewTitle table */
DROP TABLE IF EXISTS hebrewTitle;

CREATE TABLE hebrewTitle (
  hebrewTitleID INT NOT NULL,
  Title VARCHAR(5000),
  YTitle VARCHAR(5000),
  YFirstLine VARCHAR(5000),
  PRIMARY KEY(hebrewTitleID)
);

LOAD DATA LOCAL INFILE '/Users/mihirarya/dh199/rawData/hebrewTitleData/my_Hebrew_Title.csv' INTO TABLE hebrewTitle FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

/* */

/* Create and load the original hebrewTitle table, which includes TrackID */ 

DROP TABLE IF EXISTS hebrewTitle_Original;
CREATE TABLE hebrewTitle_Original (
  Title VARCHAR(5000),
  TrackID INT,
  YTitle VARCHAR(5000),
  YFirstLine VARCHAR(5000),
  PRIMARY KEY(TrackID)
);

LOAD DATA LOCAL INFILE '/Users/mihirarya/dh199/rawData/hebrewTitleData/Hebrew_Title.csv' INTO TABLE hebrewTitle_Original FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

/* */

DROP TABLE IF EXISTS trackToHebrewTitle;

CREATE TABLE trackToHebrewTitle SELECT TrackID,hebrewTitleID FROM hebrewTitle_Original,hebrewTitle WHERE ( hebrewTitle_Original.Title = hebrewTitle.Title AND hebrewTitle_Original.YTitle = hebrewTitle.YTitle AND hebrewTitle_Original.YFirstLine = hebrewTitle.YFirstLine ); 

DROP TABLE hebrewTitle_Original;
