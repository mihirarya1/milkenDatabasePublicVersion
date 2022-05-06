USE testing;

UPDATE pennTitles SET genre='Zmiros/Table Song | Medieval Spain/Muslim/Christain/Jewish",subject="Sabbath/Observance/Covenent/Rest/Study/Torah/Manna | Song of Shabbat text' WHERE titleID="23235";
UPDATE pennTitles SET notes='Combined with duplicate titleID 27457 from original data' WHERE titleID="23235";

UPDATE pennTitles SET transliteration='T-004(d)',notes='Hymn for Friday evening | Come beloved/Friday evening Kabbalat Shabbat service | Combined with duplicate titleID 24070 from original data' WHERE titleID="29606";

UPDATE pennTitles SET genre='Choir/Zmir/Ladino/Folk/Sephardic/Love/Lament',subject='Birdsong/Nightingales/Blessing/Love',notes='Combined with duplicate titleID 25457 from original data' WHERE titleID="8302";

UPDATE pennTitles SET genre='Folk/Brass/Klezmer/Neo Klezmer/Instrumental',notes='Combined with duplicate titleID 25646 from original data' WHERE titleID="25683";

UPDATE pennTitles SET genre='Religious/Liturgical/Yom Kipur/Dance/Pop',notes='Combined with duplicate titleID 25997 from original data' WHERE titleID="7549";

UPDATE pennTitles SET subject='Love/Unrequited/Rejection/Depression/Death',notes='Is Merlin Shepherd the Composer | You Are My Heart | Combined with duplicate titleID 29409 from original data' WHERE titleID="29474";

UPDATE pennTitles SET subject='Dream/Sorrows/Heart/Soul/Silence/Healing/Strength/Angel/Renewal/Flight',notes='Combined with duplicate titleID 29410' WHERE titleID="29475";

UPDATE pennTitles SET subject='Silence/Heart/Independence/Soul/Shards/Soals/Prattle/God',translations='See Synopsis Alb S-202(b) | See Synopsis Alb S-2002(b)',notes='Combined with duplicate titleID 29411' WHERE titleID="29476";

UPDATE pennTitles SET subject='Memory/Youth/Happiness/Love/Bride/Harmony/Soul/Home/Tranquility',notes='Combined with duplicate titleID 29412' WHERE titleID="29477";

UPDATE pennTitles SET subject='Longing/Yearning/Spring/Separation/Silence/Heart/Bird',notes='Enveloped By The Night | Is Merlin Shepherd the composer? | Combined with duplicate titleID 29413' WHERE titleID="29478";

UPDATE pennTitles SET subject='Childrens Assistant/Melody/Nature/Praise/Baal Shem Tov/Bahelfer/Occupation', transliteration='Alb V-008(a) | Alb Y-008(a)/Alb T-027(b)C-035(e)', org='Alb V-008(a) | Alb Y-008(a)/Alb T-027(b)', notes='Based on a text by A. Liessin | Combined with duplicate titleID 29481 from original data' WHERE titleID="3432";

UPDATE pennTitles SET notes='Combined with duplicate titleID 29585 from original data' WHERE titleID="29584";

UPDATE pennTitles SET notes='Based on a song composed by Kostantiv Listiv titled Tachanka (Tank). Russian text in album notes. | Music based on song "Tachanka" compsed by Albert Listov (1900-1983) | Combined with duplicate titleID 29607 from original data' WHERE titleID="29588";

UPDATE pennTitles SET notes='Combined with duplicate titleID 29628 from original data' WHERE titleID="29629";

UPDATE pennTitles SET title='A Nestele' WHERE titleID="29542";

DELETE FROM pennTitles WHERE title="x";

DELETE FROM pennTitles WHERE titleID="27457";

DELETE FROM pennTitles WHERE titleID="24070";
UPDATE pennAltTitle SET titleID="29606" WHERE titleID="24070";
UPDATE pennSheetMusicToTitle SET titleID="29606" WHERE titleID="24070";
UPDATE pennTrackToTitle SET titleID="29606" WHERE titleID="24070";

DELETE FROM pennTitles WHERE titleID="25457";
UPDATE pennAltTitle SET titleID="8302" WHERE titleID="25457";
UPDATE pennSheetMusicToTitle SET titleID="8302" WHERE titleID="25457";
UPDATE pennTrackToTitle SET titleID="8302" WHERE titleID="25457";

DELETE FROM pennTitles WHERE titleID="25646";
UPDATE pennAltTitle SET titleID="25683" WHERE titleID="25646";
UPDATE pennSheetMusicToTitle SET titleID="25683" WHERE titleID="25646";
UPDATE pennTrackToTitle SET titleID="25683" WHERE titleID="25646";

DELETE FROM pennTitles WHERE titleID="25997";
UPDATE pennAltTitle SET titleID="7549" WHERE titleID="25997";
UPDATE pennSheetMusicToTitle SET titleID="7549" WHERE titleID="25997";
UPDATE pennTrackToTitle SET titleID="7549" WHERE titleID="25997";

DELETE FROM pennTitles WHERE titleID="29409";
UPDATE pennAltTitle SET titleID="29474" WHERE titleID="29409";
UPDATE pennSheetMusicToTitle SET titleID="29474" WHERE titleID="29409";
UPDATE pennTrackToTitle SET titleID="29474" WHERE titleID="29409";

DELETE FROM pennTitles WHERE titleID="29410";
UPDATE pennAltTitle SET titleID="29475" WHERE titleID="29410";
UPDATE pennSheetMusicToTitle SET titleID="29475" WHERE titleID="29410";
UPDATE pennTrackToTitle SET titleID="29475" WHERE titleID="29410";

DELETE FROM pennTitles WHERE titleID="29411";
UPDATE pennAltTitle SET titleID="29476" WHERE titleID="29411";
UPDATE pennSheetMusicToTitle SET titleID="29476" WHERE titleID="29411";
UPDATE pennTrackToTitle SET titleID="29476" WHERE titleID="29411";

DELETE FROM pennTitles WHERE titleID="29412";
UPDATE pennAltTitle SET titleID="29477" WHERE titleID="29412";
UPDATE pennSheetMusicToTitle SET titleID="29477" WHERE titleID="29412";
UPDATE pennTrackToTitle SET titleID="29477" WHERE titleID="29412";

DELETE FROM pennTitles WHERE titleID="29413";
UPDATE pennAltTitle SET titleID="29478" WHERE titleID="29413";
UPDATE pennSheetMusicToTitle SET titleID="29478" WHERE titleID="29413";
UPDATE pennTrackToTitle SET titleID="29478" WHERE titleID="29413";

DELETE FROM pennTitles WHERE titleID="29481";
UPDATE pennAltTitle SET titleID="3432" WHERE titleID="29481";
UPDATE pennSheetMusicToTitle SET titleID="3432" WHERE titleID="29481";
UPDATE pennTrackToTitle SET titleID="3432" WHERE titleID="29481";

DELETE FROM pennTitles WHERE titleID="29585";
UPDATE pennAltTitle SET titleID="29584" WHERE titleID="29585";
UPDATE pennSheetMusicToTitle SET titleID="29584" WHERE titleID="29585";
UPDATE pennTrackToTitle SET titleID="29584" WHERE titleID="29585";

DELETE FROM pennTitles WHERE titleID="29607";
UPDATE pennAltTitle SET titleID="29588" WHERE titleID="29607";
UPDATE pennSheetMusicToTitle SET titleID="29588" WHERE titleID="29607";
UPDATE pennTrackToTitle SET titleID="29588" WHERE titleID="29607";

DELETE FROM pennTitles WHERE titleID="29628";
UPDATE pennAltTitle SET titleID="29629" WHERE titleID="29628";
UPDATE pennSheetMusicToTitle SET titleID="29629" WHERE titleID="29628";
UPDATE pennTrackToTitle SET titleID="29629" WHERE titleID="29628";


UPDATE pennTitles                                                                                                                                           
INNER JOIN titles ON titles.titleName=pennTitles.title                                                                                                SET pennTitles.titleID=titles.titleID;                                                                                                       
DROP TABLE IF EXISTS  mainTitles;
DROP TABLE IF EXISTS newPenntitleToOld;

DELETE FROM trackToTitles WHERE titleID NOT LIKE 'T%'; 


ALTER TABLE pennTitles ADD FOREIGN KEY (titleID) REFERENCES titles(titleID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE trackToTitles ADD FOREIGN KEY (titleID) REFERENCES titles(titleID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE trackToTitles ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE;

DROP TABLE IF EXISTS pennTrackToTitle;

RENAME TABLE pennAltTitle TO alternateTitles;
RENAME TABLE pennSheetMusic TO sheetMusic;
RENAME TABLE pennSheetMusicToTitle TO sheetMusicToTitle;

/*ALTER TABLE tracks DROP COLUMN trackName;*/


CREATE INDEX a ON albums(albumID);

/*ALTER TABLE trackToAlbum ADD FOREIGN KEY (albumID) REFERENCES albums(albumID) ON UPDATE CASCADE ON DELETE CASCADE;*/


ALTER TABLE roles ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE; 

ALTER TABLE roles ADD FOREIGN KEY (artistName) REFERENCES artists(artistName) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE trackToSponsor ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE trackToSponsor ADD FOREIGN KEY (sponsorID) REFERENCES sponsors(sponsorID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE rsaTracks ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE milkenTracks ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE swoodTracks ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE pennTracks ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE albums ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE hebrewTitle ADD FOREIGN KEY (title) REFERENCES titles(title) ON UPDATE CASCADE ON DELETE CASCADE;

CREATE INDEX aac ON sheetMusic(sheetMusicID);

CREATE INDEX bbc ON sponsors(sponsorID); 

ALTER TABLE sheetMusicToSponsor ADD FOREIGN KEY (sheetMusicID) REFERENCES sheetMusic(sheetMusicID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE sheetMusicToSponsor ADD FOREIGN KEY (sponsorID) REFERENCES sponsors(sponsorID) ON UPDATE CASCADE ON DELETE CASCADE;

INSERT INTO trackToTitles VALUES ("T25433","R11683");

ALTER TABLE tracks ADD FOREIGN KEY (trackID) REFERENCES trackToTitles(trackID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE trackToTitles ADD FOREIGN KEY (trackID) REFERENCES tracks(trackID) ON UPDATE CASCADE ON DELETE CASCADE;
