/*
    This script pertains to creation and population of the 'roles' table. First the
    'roles' table is created based on ER model. Then Penn roles are inserted into
    'roles'. The 'trackID' for these imported roles is then updated to match the
    'trackID' convention established by us, and 'artistID' mapped to true 'artistName'.
    Finally, role information from 'pennMain','rsaMain','swoodMain' is inserted into 'roles'.
*/
USE testing;

/*--------------Create 'roles' table--------------*/
/* Create 'roles' table based on schema in ER model */
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
  trackID VARCHAR(8) NOT NULL,
  artistName VARCHAR(200) NOT NULL,
  personRole VARCHAR(100) NOT NULL DEFAULT '-',
  comment VARCHAR(200) DEFAULT "-",
  notes VARCHAR(200) DEFAULT "-",
  mainArtist VARCHAR(5) DEFAULT 'No',
  PRIMARY KEY(trackID, artistName, personRole)
);

/*--------------Load 'pennRoles' into 'roles'--------------*/
/*
   Load the penn information on artist roles into the 'roles' table. For now we will load penn artistID into the
   artistName field, which we will then later join with the artist table to actually fetch artist names.
*/
LOAD DATA INFILE '/Users/mihirarya/dh199/rawData/generalApproach/pennRoles.csv'
IGNORE INTO TABLE roles FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';


/*--------------Map trackID's of Penn roles in 'roles' table to my trackID convention--------------*/
/* First create indexes so that join between 'roles' and 'pennMain' is fast */
CREATE INDEX roles_tid ON roles(trackID);
CREATE INDEX pennMain_pid ON pennMain(pennID);
CREATE INDEX pennMain_tid ON pennMain(trackID);

/*
    'trackID' of all items in 'roles' (which is penn data only right now) to be
    mapped to 'trackID' seen in pennMain, which is the convention we developed
    (as opposed to pennMain.pennID which is the convention Penn follows). Join
    done about the common variable: 'roles.trackID' and 'pennMain.pennID'
*/
UPDATE roles
INNER JOIN pennMain
ON roles.trackID = pennMain.pennID
SET roles.trackID=pennMain.trackID;

/*--------------Map the penn 'artistID' present in roles to actual artist name--------------*/
/* First create indexes so that join between 'roles' and 'artists' is fast */
CREATE INDEX roles_artistName ON roles(artistName);
CREATE INDEX artists_id ON artists(artistID);
CREATE INDEX artists_name ON artists(artistName);

/*
    'artistName' of all items in 'roles' (which is actually Penn artistID's right now') to be
    mapped to actual 'artistName' seen in 'artists', about the common variable:
    'roles.artistName' and 'artists.artistID'.
*/
UPDATE roles
INNER JOIN artists
ON roles.artistName = artists.artistID
SET roles.artistName = artists.artistName;


/*--------------Insert role information from 'milkenMain' and 'rsaMain' into 'roles'--------------*/
INSERT INTO roles(trackID, artistName) SELECT trackID,composer FROM milkenMain;
INSERT INTO roles(trackID, artistName) SELECT trackID,artistBand FROM rsaMain;




/*--------------Insert role information from Spottswood collection into 'roles'-------------*/

/*
    First lets create a temporary 'swoodRoles' table for convenience purposes,
    which we will first appropriately fill and then copy over to the actual 'roles' table.
*/

DROP TABLE IF EXISTS swoodRoles;
CREATE TABLE swoodRoles (
  trackID VARCHAR(8) NOT NULL,
  personRole VARCHAR(200) DEFAULT "-",
  artistName VARCHAR(200) DEFAULT "-",
  PRIMARY KEY (artistName,trackID,personRole)
);

/*
    Load the Spottswood track-role-artist mappings present in raw data file
    into the roles 'swoodRoles' table
*/
LOAD DATA INFILE '/Users/mihirarya/dh199/dataCleaning/swoodtrackRoleArtist.csv'
INTO TABLE swoodRoles FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

/* Copy 'swoodRoles' data over to roles table */
INSERT INTO roles(trackID,personRole,artistName) SELECT * FROM swoodRoles;

DROP TABLE swoodRoles;

/*--------------Insert Dmouth Roles------------*/

/*INSERT IGNORE INTO roles(trackID, artistName) SELECT trackID,performer FROM dmouthMain;*/
