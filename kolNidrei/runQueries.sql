USE testing;

DROP TABLE IF EXISTS tmp1;
DROP TABLE IF EXISTS tmp2;
DROP TABLE IF EXISTS tmp3;
DROP TABLE IF EXISTS tmp4;
DROP TABLE IF EXISTS tmp5;
DROP TABLE IF EXISTS tmp6;
DROP TABLE IF EXISTS tmp7;
DROP TABLE IF EXISTS tmp8;
DROP TABLE IF EXISTS tmp9;
DROP TABLE IF EXISTS kolNidreiTrackID;


CREATE TABLE tmp1 SELECT * FROM titles WHERE titleName LIKE '%Kol%' AND titleName LIKE '%Nidr%';

CREATE TABLE tmp2 SELECT trackID FROM titles,trackToTitles WHERE titles.titleName LIKE '%Kol%' AND titles.titleName LIKE '%Nidr%' AND titles.titleID=trackToTitles.titleID;

CREATE TABLE kolNidreiTrackID SELECT * FROM tmp2;

CREATE TABLE tmp3 SELECT * FROM tracks WHERE trackID IN (SELECT trackID FROM kolNidreiTrackID);

ALTER TABLE tracks RENAME COLUMN trackID TO tmpTrackID;

CREATE TABLE tmp4 SELECT * FROM tracks,milkenTracks WHERE tracks.tmpTrackID LIKE 'M%' AND tracks.tmpTrackID=milkenTracks.trackID AND tracks.tmpTrackID IN (SELECT trackID FROM kolNidreiTrackID);

CREATE TABLE tmp5 SELECT * FROM tracks,swoodTracks WHERE tracks.tmpTrackID LIKE 'S%' AND tracks.tmpTrackID=swoodTracks.trackID AND tracks.tmpTrackID IN (SELECT trackID FROM kolNidreiTrackID);

CREATE TABLE tmp6 SELECT * FROM tracks,rsaTracks WHERE tracks.tmpTrackID LIKE 'R%' AND tracks.tmpTrackID=rsaTracks.trackID AND tracks.tmpTrackID IN (SELECT trackID FROM kolNidreiTrackID);

CREATE TABLE tmp7 SELECT * FROM tracks,pennTracks WHERE tracks.tmpTrackID LIKE 'P%' AND tracks.tmpTrackID=pennTracks.trackID AND tracks.tmpTrackID IN (SELECT trackID FROM kolNidreiTrackID);

ALTER TABLE tracks RENAME COLUMN tmpTrackID TO trackID;

CREATE TABLE tmp8 SELECT titleName,roles.trackID,roles.artistName,roles.personRole,roles.comment,
roles.notes, roles.mainArtist,yiddishName 
FROM kolNidreiTrackID,roles,artists,trackToTitles,titles 
WHERE kolNidreiTrackID.trackID=trackToTitles.trackID AND trackToTitles.titleID=titles.titleID AND kolNidreiTrackID.trackID=roles.trackID AND roles.artistName=artists.artistName;

ALTER TABLE titles RENAME COLUMN titleID TO tmpTitleID;

CREATE TABLE tmp9 SELECT * FROM titles,sheetMusicToTitle,sheetMusic
WHERE titles.tmpTitleID=sheetMusicToTitle.titleID AND sheetMusicToTitle.smid=sheetMusic.sheetMusicID AND titleName LIKE '%Kol%' AND titleName LIKE '%Nidr%';

ALTER TABLE titles RENAME COLUMN tmpTitleID TO titleID;

DROP TABLE kolNidreiTrackID;
