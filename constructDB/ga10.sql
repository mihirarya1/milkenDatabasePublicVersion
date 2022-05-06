USE testing;


DROP TABLE IF EXISTS images;
CREATE TABLE images (
   idOrName VARCHAR(200) NOT NULL,
   localFilePath VARCHAR(200) NOT NULL,
   PRIMARY KEY (idOrName,localFilePath)
);

INSERT INTO images VALUES ("Benny Goodman","musicDBImages/Benny-Goodman.jpeg");



DROP TABLE IF EXISTS tmpAltNames;
CREATE TABLE tmpAltNames (
  altNames VARCHAR(1600) NOT NULL,
  realName VARCHAR(250) NOT NULL,
  PRIMARY KEY(realName)
);

LOAD DATA INFILE '/Users/mihirarya/dh199/authority/altNamesNew.csv' IGNORE INTO TABLE tmpAltNames FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

UPDATE artists
INNER JOIN tmpAltNames
SET artists.altNames=tmpAltNames.altNames 
WHERE artists.artistName=tmpAltNames.realName;

DROP TABLE tmpAltNames;
