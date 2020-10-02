 SELECT DATENAME(WEEKDAY,mt.transactionMdate)+',' + 
 CAST (CONVERT (varchar,mt.transactionMdate,105) AS varchar) AS "Transaction Date"
,'IDR '+CAST((mt.seatSold * s.studioPrice)  AS Varchar)AS "Total Movie Revenue"
FROM MovieTrans mt,Studio s,ScheduleTrans st,
(SELECT "Average"=AVG(seatSold) FROM MovieTrans) AS "Avg"
 WHERE s.studioID=st.studioID AND  st.scheduleID=mt.scheduleID 
 AND mt.transactionMDate<'2020-02-28' AND mt.transactionMDate>'2020-01-28' AND 
 (mt.seatSold * s.studioPrice)> Average * s.studioPrice
