/*
   This script creates and then populates the 'tracks' table of the database, based
   on the schema outlined in the ER diagram and the data in each of the 'main' tables
*/

USE testing;

/*--------------Create 'tracks' table--------------*/
DROP TABLE IF EXISTS tracks; /* Drop 'tracks' table if already exists */
CREATE TABLE tracks ( /* Create 'tracks' table based on schema in ER model */
  trackID VARCHAR(8) NOT NULL,
  trackName VARCHAR(300) DEFAULT "-",
  yr VARCHAR(50) DEFAULT "-",
  dates VARCHAR(90) DEFAULT "-",
  notes VARCHAR(1000) DEFAULT "-",
  PRIMARY KEY (trackID)
);

/*--------------Populate 'tracks' table with 'milkenMain' data--------------*/
/*
    For the 'yearEstimated' column of the 'milkenMain' table, append an ' e' to any non-blank
    'year' cells.
*/
UPDATE milkenMain SET yearEstimated = CONCAT(yearEstimated," e") WHERE yearEstimated!="";

/*
   For every track in 'milkenMain', push that track's, 'trackID', 'trackName', 'year', and 'notes' into the
   'tracks' table. 'yearEstimated' and 'yearKnown' data in the 'milkenMain' data will be concatenated to
   form the 'yr' column of the 'tracks' table, with a 'yr' being an estimate if it has an 'e' appended to it.
   Similarily, the 4 'notes' columns present in 'milkenMain' will be appended and separated by '|', to constitute
   the 'notes' column of 'tracks'.
*/
INSERT INTO tracks(trackID,trackName,yr,notes)
SELECT trackID,title,CONCAT(yearEstimated,yearKnown),CONCAT( notes1," | ",notes2," | ",notes3," | ",notes4) FROM milkenMain;


/*--------------Populate 'tracks' table with 'rsaMain' data--------------*/
/* Insert 'trackID', 'title', 'years' data for each track in 'rsaMain' into 'tracks' */
INSERT INTO tracks(trackID, trackName, yr)
SELECT trackID,title,years FROM rsaMain;


/*--------------Populate 'tracks' table with 'swoodMain' data--------------*/
/*
    For the 'dateEstimate' column of the 'swoodMain' table, append an ' e' to any non-blank
    'dateEstimate' cells.
*/
UPDATE swoodMain SET dateEstimate = CONCAT(dateEstimate," e") WHERE dateEstimate!="";

/*
   Same idea as above, of inserting track information present in 'swoodMain' into 'tracks'.
   Combine the 'dateExact' and 'dateEstimate' columns (since they are mutually exclusive) and
   dump result of that in the 'dates' field of 'tracks', just like what we did with the year
   information for the 'milkenMain' data.
*/
INSERT INTO tracks(trackID, trackName,yr,dates,notes)
SELECT trackID, title, years, CONCAT(dateExact,dateEstimate), otherNotes FROM swoodMain;


/*--------------Populate 'tracks' table with 'dmouthMain' data--------------*/
/* DISREGARDING DARTMOUTH */
/*INSERT INTO tracks(trackID, trackName,notes)
SELECT trackID,track,lpInfo FROM dmouthMain;*/


/*--------------Populate 'tracks' table with 'pennMain' data--------------*/
/*
   For DB construction convenience purposes, lets actually preserve the titles of tracks in the
   tracks field itself for the Penn data, rather than solely in the 'pennMainTitle' table.
*/
UPDATE pennMain p
inner join pennMainTitle t on
  p.titleID = t.titleID
set p.title = t.title;

/* Same idea as earlier, of populating 'tracks' table with track information from 'pennMain' */
INSERT INTO tracks(trackID, trackName, notes)
SELECT trackID, title, comment FROM pennMain;
