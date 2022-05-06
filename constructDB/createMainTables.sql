/*
    This script pertains to all of the 'main' tables in the database (each 'main' table
    is affiliated to a dataset). The script begins by dropping all the existing 'main' tables,
    and then creates each of the 'main' tables with the schema defined in the entity-relationship
    model. Finally, the data from each of the datasets is loaded into the newly created 'main' tables.
*/

/*
    Initially turn foreign key checks off, so that we can delete 'main'
    tables without any errors
*/
SET FOREIGN_KEY_CHECKS=0;


USE testing; /* Local iteration of database we are working on is called 'testing' */


/*--------------Drop all 'main' tables--------------*/
/* Drop any existing 'main' tables in the database if they exist */
DROP TABLE IF EXISTS milkenMain;
DROP TABLE IF EXISTS rsaMain;
DROP TABLE IF EXISTS swoodMain;
DROP TABLE IF EXISTS dmouthMain;
DROP TABLE IF EXISTS pennMain;
DROP TABLE IF EXISTS pennMainTitle;


/*--------------Create 'milkenMain' table--------------*/
/*
    Create all the 'main' tables using ER model defined schema
    Default cell value for columns which are permitted to have empty/NULL cells is '-'
*/
CREATE TABLE milkenMain (
  trackID VARCHAR(8) NOT NULL,
  volume INT,
  composer VARCHAR(250) DEFAULT "-",
  title VARCHAR(300) DEFAULT "-",
  durationMin DECIMAL(4,2),
  yearKnown VARCHAR(20) DEFAULT "-",
  yearEstimated VARCHAR(40) DEFAULT "-",
  commissioned BOOLEAN,
  commissioningInstitutionName VARCHAR(300) DEFAULT "-",
  commissioningInstitutionType VARCHAR(100) DEFAULT "-",
  primaryGenre VARCHAR(30) DEFAULT "-",
  instrumentation VARCHAR(100) DEFAULT "-",
  formGeneral VARCHAR(40) DEFAULT "-",
  formSpecific VARCHAR(60) DEFAULT "-",
  otherForm VARCHAR(130) DEFAULT "-",
  sacred BOOLEAN,
  secular BOOLEAN,
  ashkenazi BOOLEAN,
  sephardi BOOLEAN,
  israeli BOOLEAN,
  mizrahi BOOLEAN,
  musical BOOLEAN,
  conceptual BOOLEAN,
  textual BOOLEAN,
  functional BOOLEAN,
  sonic BOOLEAN,
  classical BOOLEAN,
  klezmer BOOLEAN,
  cantorial BOOLEAN,
  folk BOOLEAN,
  jazz BOOLEAN,
  devotionalSolemn BOOLEAN,
  popular BOOLEAN,
  theatrical BOOLEAN,
  text BOOLEAN,
  textType VARCHAR(40),
  textSource VARCHAR(120),
  hebrew BOOLEAN,
  yiddish BOOLEAN,
  english BOOLEAN,
  ladino BOOLEAN,
  german BOOLEAN,
  otherLang BOOLEAN,
  notes1 VARCHAR(500),
  notes2 VARCHAR(500),
  notes3 VARCHAR(500),
  notes4 VARCHAR(500),
  PRIMARY KEY (trackID)
);

/*--------------Create 'rsaMain' table--------------*/
CREATE TABLE rsaMain (
 trackID VARCHAR(8) NOT NULL,
 title VARCHAR(300) DEFAULT "-",
 catalogueNumber VARCHAR(100) DEFAULT "-",
 years VARCHAR(50) DEFAULT "-",
 artistBand VARCHAR(250) DEFAULT "-",
 recordLabel VARCHAR(100) DEFAULT "-",
 recordFormat VARCHAR(50) DEFAULT "-",
 PRIMARY KEY (trackID)
);

/*--------------Create 'swoodMain' table--------------*/
CREATE TABLE swoodMain (
 trackID VARCHAR(8) NOT NULL,
 sectionNum DECIMAL(5,3),
 matrixNum VARCHAR(50) DEFAULT "-",
 performer VARCHAR(250) DEFAULT "-",
 title VARCHAR(300) DEFAULT "-",
 dateExact VARCHAR(60) DEFAULT "-",
 dateEstimate VARCHAR(50) DEFAULT "-",
 years VARCHAR(50) DEFAULT "-",
 placePerformed VARCHAR(30) DEFAULT "-",
 recordLabelNum VARCHAR(300) DEFAULT "-",
 recordLabel VARCHAR(80) DEFAULT "-",
 instrumentation VARCHAR(200) DEFAULT "-",
 arrangersComposersPerformers VARCHAR(300) DEFAULT "-",
 artistsNormativeSpelling VARCHAR(300) DEFAULT "-",
 otherNotes VARCHAR(350) DEFAULT "-",
 PRIMARY KEY (trackID)
);

/*--------------Create 'dmouthMain' table--------------*/
/* We will NOT BE INCLUDING the Dartmouth data, until further cleaning is done. */
/*CREATE TABLE dmouthMain (
  trackID VARCHAR(8) NOT NULL,
  performer VARCHAR(200) DEFAULT "-",
  album VARCHAR(200) DEFAULT "-",
  track VARCHAR(300) DEFAULT "-",
  lpInfo VARCHAR(10) DEFAULT "-",
  PRIMARY KEY (trackID)
);*/

/*--------------Create 'pennMain' table--------------*/
CREATE TABLE pennMain (
  trackID VARCHAR(8) NOT NULL,
  pennID VARCHAR(8),
  albumInfo VARCHAR(30) DEFAULT "-",
  titleID VARCHAR(8) DEFAULT "-",
  firstLine VARCHAR(200) DEFAULT "-",
  hebrewFirstLine VARCHAR(200),
  languages VARCHAR(80) DEFAULT "-",
  styles VARCHAR(100) DEFAULT "-",
  lengthMin VARCHAR(20) DEFAULT "-",
  memo VARCHAR(1000) DEFAULT "-",
  fauLink VARCHAR(200) DEFAULT "-",
  comment VARCHAR(200) DEFAULT "-",
  title VARCHAR(200) DEFAULT "-",
  PRIMARY KEY (trackID)
);

/*--------------Create 'pennMainTitle' table--------------*/
CREATE TABLE pennMainTitle (
  titleID VARCHAR(8) NOT NULL,
  title VARCHAR(100) DEFAULT "-",
  hebrewTitle VARCHAR(100) DEFAULT "-",
  genre VARCHAR(100) DEFAULT "-",
  subject VARCHAR(100) DEFAULT "-",
  org VARCHAR(160) DEFAULT "-",
  transliteration VARCHAR(160) DEFAULT "-",
  music VARCHAR(100) DEFAULT "-",
  notes VARCHAR(1000) DEFAULT "-",
  translations VARCHAR(150) DEFAULT "-",
  PRIMARY KEY (titleID)
);


/*--------------Load data into created 'main' tables--------------*/
/* Load data from raw csv files into 'main' tables. */
/*
   'FIELDS TERMINATED BY ','' indicates that columns are comma-separated, while
   'OPTIONALLY ENCLOSED BY '"'' indicates to not use commas as a delimiter in cells
    where they appear between two sets of double quotes
*/
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/milkenMain.csv' INTO TABLE milkenMain FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/rsaMain.csv' INTO TABLE rsaMain FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/swoodMain.csv' INTO TABLE swoodMain FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

/* DISREGARDING DARTMOUTH */
/*LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/dmouthMain.csv' INTO TABLE dmouthMain FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';*/

LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennMain.csv' INTO TABLE pennMain FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennMainTitle.csv'INTO TABLE pennMainTitle FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
