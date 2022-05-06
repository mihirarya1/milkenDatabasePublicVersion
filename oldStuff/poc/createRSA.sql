USE dh199;

DROP TABLE IF EXISTS rsa;

CREATE TABLE rsa (
       title VARCHAR(250) NOT NULL,
       catalogNumber VARCHAR(100) NOT NULL,
       yearMade VARCHAR(50),
       artistBand VARCHAR(250),
       recordLabel VARCHAR(250),
       recordFormat VARCHAR(100),
       PRIMARY KEY (title, catalogNumber)
);
       
