SELECT LEFT(RIGHT(mt.movieTransID,(LEN(mt.movieTransID)-CHARINDEX('M',mt.movieTransID))),2) 
+' '+RIGHT(mt.movieTransID,(LEN(mt.movieTransID)-CHARINDEX('M',mt.movieTransID)-2)) AS "Transaction ID",
s.studioName AS "Studio",'IDR '+CAST(s.studioPrice AS varchar) AS "Studio Price"
FROM MovieTrans mt,Studio s,ScheduleTrans st,
(SELECT "Avgseat"=AVG(seatSold) FROM MovieTrans) AS "Avg",
(SELECT "Maxseat"=MAX(seatSold) FROM MovieTrans) AS "MAX",
(SELECT "Avgprc"=AVG(studioPrice) FROM Studio) AS "Avgy",
(SELECT "Maxprc"=MAX(studioPrice) FROM Studio) AS "MAXy"
WHERE s.studioID=st.studioID AND st.scheduleID=mt.scheduleID 
AND mt.seatSold > Avgseat AND mt.seatSold < Maxseat
AND s.studioPrice > Avgprc AND s.studioPrice < Maxprc
 