/* 
   This script pertains to the creation and population of the 'artists' table. First,
   the 'artists' table is created using the schema in the ER diagram. Then, all of the
   artists (along with any additional available on them) contained in each datasource,
   is inserted into this table. The 'Spottswood' collection has artist names prevalent in
   two separate columns, and is handled  specially, as described below.
*/


USE testing;

/*--------------Create 'artists' table--------------*/
/* Create and populate artists table */
DROP TABLE IF EXISTS artists;
CREATE TABLE artists (
  artistID VARCHAR(8),
  artistName VARCHAR(200) NOT NULL,
  yiddishName VARCHAR(100) DEFAULT "-",
  notes VARCHAR(300) DEFAULT "-",
  birthDate VARCHAR(20) DEFAULT "-",
  deathDate VARCHAR(20) DEFAULT "-",
  deathPlace VARCHAR(100) DEFAULT "-",
  birthPlace VARCHAR(100) DEFAULT "-",
  PRIMARY KEY(artistName)
);

/*--------------Load the artists contained in 'pennArtists' into 'artists'--------------*/
/* Load the pennArtists file data into the artists table first */
/* The 'IGNORE' basically says to not insert a row if it is identical to a previously inserted row */
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennArtists.csv'
IGNORE INTO TABLE artists FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';


/*--------------Load the artists contained in 'swoodArtists' into 'artists'--------------*/
/*
    Load the swoodArtists file data into the artists table. To avoid mysql error,
   is necessary to explicitly declare that the first column present in the csv file
   is in fact the 'artistName' field.
*/
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/swoodArtistsModified.csv'
IGNORE INTO TABLE artists FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' (@col1) set artistName=@col1;

/*--------------Load the artists contained in 'dmouthMain' into 'artists'--------------*/
/* DISREGARDING DARTMOUTH */
/*INSERT IGNORE INTO artists(artistName) SELECT DISTINCT(performer) FROM dmouthMain;*/

/*--------------Load the artistBand contained in 'rsaMain' into 'artists'--------------*/
/* look into whitespace issues causing duplicates? */
INSERT IGNORE INTO artists(artistName) SELECT DISTINCT(artistBand) FROM rsaMain;

/*--------------Load the composers contained in 'milkenMain' into 'artists'--------------*/
INSERT IGNORE INTO artists(artistName) SELECT DISTINCT(composer) FROM milkenMain;

/*--------------Load the performers contained in 'swoodMain' into 'artists'--------------*/
/* 
   The earlier Spottswood data we loaded into the 'artists' table maps to the
   'Composers and Performers Normative Spelling' column seen in the original Spottswood data,
   with ';' or ',' delimited. The aritsts we are adding from the 'swoodMain' table maps to the
   'Normative Artist Name' field in the original Spottswood data. The reason this is done is
   because if a name appears in 'Normative Artist Name' it is not actually guaranteed to appear
   in 'Composers and Performers Normative Spelling' and vice-versa. Keep in mind that duplicate
   names will not be allowed to be inserted because of the 'IGNORE' keyword
*/
INSERT IGNORE INTO artists(artistName) SELECT DISTINCT(performer) FROM swoodMain;
