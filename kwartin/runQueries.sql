USE testing;

DROP TABLE IF EXISTS tmp1;
DROP TABLE IF EXISTS kwartinTrackID;

CREATE TABLE kwartinTrackID SELECT trackID FROM roles WHERE artistName LIKE '%Kwartin%';

CREATE TABLE tmp1 SELECT titleName,roles.trackID,roles.artistName,roles.personRole,roles.comment,
roles.notes, roles.mainArtist,tracks.yr,tracks.dates,tracks.notes AS trackNotes, swoodTracks.matrixNum, rsaTracks.catalogueNumber,yiddishName 
FROM kwartinTrackID,roles,artists,trackToTitles,titles,tracks 
LEFT JOIN swoodTracks 
ON swoodTracks.trackID=tracks.trackID
LEFT JOIN rsaTracks 
ON rsaTracks.trackID=tracks.trackID
WHERE kwartinTrackID.trackID=tracks.trackID AND kwartinTrackID.trackID=trackToTitles.trackID AND trackToTitles.titleID=titles.titleID AND kwartinTrackID.trackID=roles.trackID AND roles.artistName=artists.artistName;

DROP TABLE IF EXISTS kwartinTrackID;
