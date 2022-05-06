/* This script pertains to the creation and population of the 'albums' table. We first construct and populate the 
   'pennAlbum' table, with the structure/data of pennAlbum.csv. We then rename this table 'albums' and drop any 
   Penn metadata specific columns from 'albums'. Finally we create 'trackToAlbum' table, which contains mappings
   pulled from pennMain, of track to album.
*/

USE testing;

/*------------------Create pennAlbum Table-------------------*/
/*
   Begin by creating and populating the 'pennAlbum' table, which essentially
   follows the Penn template for storing album information. The final 'albums'
   table will essentially follow this table's schema.
*/
DROP TABLE IF EXISTS pennAlbum;
CREATE TABLE pennAlbum (
  albumID VARCHAR(8) NOT NULL,
  pennAlbumID VARCHAR(30) DEFAULT "-",
  albumName VARCHAR(250) DEFAULT "-",
  albumNameYiddish VARCHAR(200) DEFAULT "-",
  publisher VARCHAR(100) DEFAULT "-",
  linenote VARCHAR(300) DEFAULT "-",
  rpm BOOLEAN,
  LP_BOX INT,
  format VARCHAR(50) DEFAULT "-",
  timeMade VARCHAR(20) DEFAULT "-",
  languages VARCHAR(80) DEFAULT "-",
  genre VARCHAR(100) DEFAULT "-",
  whereProduced VARCHAR(100) DEFAULT "-",
  comments VARCHAR(150) DEFAULT "-",
  trackNumber INT,
  notes VARCHAR(750) DEFAULT "-",
  fauLink VARCHAR(200) DEFAULT "-",
  dateMade VARCHAR(30) DEFAULT "-",
  provenance VARCHAR(150) DEFAULT "-",
  cassette VARCHAR(20) DEFAULT "-",
  cd VARCHAR(20) DEFAULT "-",
  PRIMARY KEY (albumID)
);
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennAlbum.csv' INTO TABLE pennAlbum FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

/*------------------Create dmouthAlbum Table-------------------*/
/*
    Create and populate a temporary 'dmouthAlbum' table, to be eventually
    copied into 'albums'
*/
/* DISREGARDING DARTMOUTH */
/*DROP TABLE IF EXISTS dmouthAlbum;
CREATE TABLE dmouthAlbum (
   albumID VARCHAR(8) NOT NULL,
   albumName VARCHAR(100) DEFAULT "-",
   PRIMARY KEY(albumID)
);*/
/*LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/dmouthAlbum.csv' INTO TABLE dmouthAlbum FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';*/

/*------------------Create 'albums' table-------------------*/
/*
   Copy 'pennAlbum' into a table called 'albums', and then drop all Penn specific
   information like 'pennAlbumID' or 'publisher' from 'albums'.
*/
DROP TABLE IF EXISTS albums;
CREATE TABLE albums SELECT * FROM pennAlbum;
ALTER TABLE albums DROP pennAlbumID;
ALTER TABLE albums DROP publisher;

/*------------------Populate 'albums' table with 'dmouthAlbum'-------------------*/
/* DISREGARDING DARTMOUTH */
/*INSERT INTO albums(albumID,albumName) SELECT * FROM dmouthAlbum;*/

/*------------------Establshing 'trackToAlbum' mapping table-------------------*/
/* Create 'trackToAlbum' mapping table */
DROP TABLE IF EXISTS trackToAlbum;
CREATE TABLE trackToAlbum (
       trackID VARCHAR(8) NOT NULL,
       albumID VARCHAR(40) NOT NULL,
       PRIMARY KEY(trackID, albumID)
);

/* For the time being, insert 'trackID' and 'albumInfo' tupples into 'trackToAlbum' from/for 'pennMain' */
INSERT INTO trackToAlbum SELECT trackID,albumInfo FROM pennMain;

/* DISREGARDING DARTMOUTH */
/*INSERT INTO trackToAlbum SELECT trackID,albumID FROM dmouthAlbum,dmouthMain WHERE dmouthMain.album=dmouthAlbum.albumName;*/
