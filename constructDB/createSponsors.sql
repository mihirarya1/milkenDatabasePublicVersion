/* 
   This script pertains to the creation and population of the 'sponsors' table. First,
   we create the schema for the 'sponsors' table, which is actually meant to preserve
   commisioner, record-label, and publisher information (which specific one is specified 
   in the 'sponsorType' field).
*/


USE testing;

/* Creating the commissioner/record-label/publisher table; calling this sponsors for now */
DROP TABLE IF EXISTS sponsors;
CREATE TABLE sponsors (
  sponsorID VARCHAR(8),
  sponsorName VARCHAR(300) NOT NULL,
  sponsorInstitutionType VARCHAR(200) NOT NULL DEFAULT '-',
  sponsorType VARCHAR(20) DEFAULT '-',
  PRIMARY KEY(sponsorName, sponsorInstitutionType)
);

/* Insert the milken commissioning institution name and type from the milken data into sponsors. Type of sponsor is 'Commissioned'. */
INSERT IGNORE INTO sponsors(sponsorName,sponsorInstitutionType) SELECT commissioningInstitutionName,commissioningInstitutionType FROM milkenMain;
UPDATE sponsors SET sponsorType='Commissioned';

/* Insert the record label information from the rsa data into sponsors. Type of sponsor is 'Record Label'. */
INSERT INTO sponsors(sponsorName) SELECT DISTINCT(recordLabel) FROM rsaMain;
UPDATE sponsors SET sponsorType='Record Label' WHERE sponsorType='-';

/* Insert the Spottswood record label information into sponsors. Type of sponsor is again 'Record Label' */
INSERT IGNORE sponsors(sponsorName) SELECT DISTINCT(recordLabel) FROM swoodMain;
UPDATE sponsors SET sponsorType='Record Label' WHERE sponsorType='-';



/* Insert the Penn sponsor information into sponsors. Type of sponsor is again 'Publisher' */
INSERT IGNORE sponsors(sponsorName) SELECT DISTINCT(publisher) FROM sheetMusicMain;
UPDATE sponsors SET sponsorType='Publisher' WHERE sponsorType='-';

/* Establish a sponsor id system for the sponsors table */
SET @pos:=1;
UPDATE sponsors SET sponsorID= CONCAT("SPR",(SELECT @pos:=@pos+1));

/* 
  Change the current multi-key of the sponsors table of 'sponsorName', 'sponsorInstitutionType' to the newly
  created sponsorID.
*/
ALTER TABLE sponsors DROP PRIMARY KEY;
ALTER TABLE sponsors ADD CONSTRAINT sponsorID PRIMARY KEY (sponsorID);

/* Populate the 'trackToSponsor' table */ 
DROP TABLE IF EXISTS trackToSponsor;
CREATE TABLE trackToSponsor (
  sponsorID VARCHAR(8) NOT NULL,
  trackID VARCHAR(8) NOT NULL,
  recordFormat VARCHAR(50) DEFAULT "-",
  recordNumber VARCHAR(200) DEFAULT "-",
  PRIMARY KEY(sponsorID,trackID)
);

/* By doing a join with the milken data, we can piece together the 'trackID' to 'sponsorID' mappings for this collection, and 
   place them in the trackToSponsor table.   
*/ 
INSERT INTO trackToSponsor(sponsorID,trackID) SELECT sponsorID,trackID FROM milkenMain,sponsors WHERE commissioningInstitutionName=sponsorName AND commissioningInstitutionType=sponsorInstitutionType;

/* 
   In similar fashion do a join between 'rsaMain' and 'sponsors', and get 'sponsorID','trackID','recordFormat'. Probably a better
   idea to find another home for 'recordFormat' also.
*/
INSERT INTO trackToSponsor(sponsorID,trackID,recordFormat) SELECT sponsorID,trackID,recordFormat FROM rsaMain,sponsors WHERE sponsorName=recordLabel AND sponsorInstitutionType="-";

/* 
   Do the same thing between swoodMain and sponsors, and also fetch the recordNumber information, since this is pertinent to 
   'Record Label' type of sponsor.
*/
INSERT INTO trackToSponsor(sponsorID,trackID,recordNumber) SELECT sponsorID,trackID,recordLabelNum FROM swoodMain,sponsors WHERE recordLabel=sponsorName AND sponsorInstitutionType="-";
