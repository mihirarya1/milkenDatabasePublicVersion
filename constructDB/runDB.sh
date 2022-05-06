#!/bin/bash

mysql --local-infile=1 < ~/dh199/constructDB/createMainTables.sql
mysql --local-infile=1 < ~/dh199/constructDB/createTracksTable.sql
mysql --local-infile=1 < ~/dh199/constructDB/createArtistsTable.sql
mysql --local-infile=1 < ~/dh199/constructDB/createRolesTable.sql
mysql --local-infile=1 < ~/dh199/constructDB/createAlbumTable.sql
mysql --local-infile=1 < ~/dh199/constructDB/createSheetMusicTable.sql
mysql --local-infile=1 < ~/dh199/constructDB/createSponsors.sql
mysql --local-infile=1 < ~/dh199/constructDB/createHebrewTitle.sql
mysql --local-infile=1 < ~/dh199/constructDB/dropMainTables.sql

mysql --local-infile=1 < ~/dh199/constructDB/ga8.sql
mysql --local-infile=1 < ~/dh199/constructDB/ga9.sql
mysql --local-infile=1 < ~/dh199/constructDB/ga10.sql
