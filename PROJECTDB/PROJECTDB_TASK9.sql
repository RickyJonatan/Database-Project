CREATE VIEW "Movie Schedule Viewer" AS 
SELECT 'Studio'+RIGHT(s.studioID,(LEN(s.studioID)-CHARINDEX('T',s.studioID))) AS "Studio ID",
s.studioName AS "Studio Name",
counte AS "Total Play Schedule ",
sume AS "Movie Duration Total "
FROM Studio s,Movie m,ScheduleTrans st,
(SELECT "counte"=COUNT(showTime) FROM ScheduleTrans) AS "coun",
(SELECT "sume"=SUM(movieDuration) FROM Movie) AS "SUMe"
WHERE m.movieID=st.movieID AND st.studioID=s.studioID 
AND s.studioName LIKE 'Satin%' AND m.movieDuration > 120