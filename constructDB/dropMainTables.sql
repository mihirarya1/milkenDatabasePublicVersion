/* 
  Script to create the final schema for: 'milkenTracks', 'swoodTracks', 'rsaTracks', 'pennTracks', 'pennTitles', 'pennSheetMusic',
  'pennAltTitle','pennTrackToTitle','pennSheetMusicToTitle'. With the exception of the last three, the rest of the tables are 
  column subsets of their corresponding 'main' table (which were constructed and used earlier). 
*/
 

USE testing;

/* Create and populate milkenTracks */
DROP TABLE IF EXISTS milkenTracks;
CREATE TABLE milkenTracks
SELECT
  trackID,
  volume,
  composer,
  durationMin,
  commissioned,
  primaryGenre,
  instrumentation,
  formGeneral,
  formSpecific,
  otherForm,
  sacred,
  secular,
  ashkenazi,
  sephardi,
  israeli,
  mizrahi,
  musical,
  conceptual,
  textual,
  functional,
  sonic,
  classical,
  klezmer,
  cantorial,
  folk,
  jazz,
  devotionalSolemn,
  popular,
  theatrical,
  text,
  textType,
  textSource,
  hebrew,
  yiddish,
  english,
  ladino,
  german,
  otherLang,
  notes1,
  notes2,
  notes3,
  notes4  
FROM milkenMain;

/* Create and populate swoodTracks */
DROP TABLE IF EXISTS swoodTracks;
CREATE TABLE swoodTracks
SELECT
  trackId,
  sectionNum,
  matrixNum,
  placePerformed,
  instrumentation
FROM swoodMain;

/* Create and populate rsaTracks */
DROP TABLE IF EXISTS rsaTracks;
CREATE TABLE rsaTracks
SELECT
  trackID,
  catalogueNumber
FROM rsaMain;

/* Create and populate pennTracks */
DROP TABLE IF EXISTS pennTracks;
CREATE TABLE pennTracks
SELECT
  trackID,  
  firstLine,
  hebrewFirstLine,
  languages,
  styles,
  lengthMin,
  memo,
  fauLink,
  comment
FROM pennMain;

/* Create and populate pennTitles */
DROP TABLE IF EXISTS pennTitles;
CREATE TABLE pennTitles
SELECT
  title,
  titleID,
  genre,
  hebrewTitle,
  subject,
  org,
  transliteration,
  music,
  notes,
  translations
FROM pennMainTitle;

/* Create and populate pennSheetMusic */
DROP TABLE IF EXISTS pennSheetMusic;
CREATE TABLE pennSheetMusic
SELECT
  sheetMusicID,
  seriesLetter,
  arrangements,
  texts,
  address,
  dateMade,
  provenance,
  yiddishFirstLine,
  notes,
  firstLine,
  arranger,
  translator
FROM sheetMusicMain;

/* Create and populate pennAltTitle */
DROP TABLE IF EXISTS pennAltTitle;
CREATE TABLE pennAltTitle (
  titleID VARCHAR(8) NOT NULL,
  altTitleID VARCHAR(8) NOT NULL,
  PRIMARY KEY(titleID,altTitleID)
);
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennAlternativeTitle.csv' INTO TABLE pennAltTitle FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
/* Should implement this at PYTHON level */
DELETE FROM pennAltTitle WHERE altTitleID='' OR titleID='';

/* Create and populate pennTrackToTitle */
DROP TABLE IF EXISTS pennTrackToTitle;
CREATE TABLE pennTrackToTitle (
  trackID VARCHAR(8) NOT NULL,
  titleID VARCHAR(8) NOT NULL,
  PRIMARY KEY(trackID)
);
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennTrackToTitle.csv' INTO TABLE pennTrackToTitle FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

/* Create and populate pennSheetMusicToTitle */
DROP TABLE IF EXISTS pennSheetMusicToTitle;
CREATE TABLE pennSheetMusicToTitle (
  smid VARCHAR(8) NOT NULL,
  titleID VARCHAR(8) NOT NULL,
  PRIMARY KEY(smid)
);
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennSheetMusicToTitle.csv' INTO TABLE pennSheetMusicToTitle FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';


DROP TABLE IF EXISTS milkenMain;
DROP TABLE IF EXISTS rsaMain;
DROP TABLE IF EXISTS swoodMain;
DROP TABLE IF EXISTS dmouthMain;
DROP TABLE IF EXISTS pennMain;
DROP TABLE IF EXISTS pennMainTitle;
DROP TABLE IF EXISTS swoodRoles;
DROP TABLE IF EXISTS pennAlbum;
DROP TABLE IF EXISTS dmouthAlbum;
DROP TABLE IF EXISTS pennAlbum;
DROP TABLE IF EXISTS hebrewTitleRaw;
DROP TABLE IF EXISTS sheetMusicMain;
