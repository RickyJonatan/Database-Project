SELECT RIGHT(s.staffName, (LEN(s.staffName)-CHARINDEX(' ',s.staffName))) AS "Staff's Last Name" 
,rt.refreshmentTransID AS "Refreshment Transaction Id"
,r.refreshmentName AS "Refreshment" ,'IDR '+CAST(r.refreshmentPrice AS varchar) AS "price"
FROM Staff s,Refreshment r,RefreshmentTrans rt,
(SELECT "Minimum"=MIN(refreshmentPrice) FROM Refreshment) AS "Min",
(SELECT "Maximum"=MAX(refreshmentPrice) FROM Refreshment) AS "Max"
WHERE s.staffID=rt.staffID AND rt.refreshmentID= r.refreshmentID 
AND r.refreshmentPrice>Minimum AND r.refreshmentPrice<Maximum