CREATE VIEW "Refreshment Transaction Summary Viewer" AS 
SELECT CAST(countt AS varchar)+' transactions' AS "Transaction Count",
CAST(sumee AS varchar)+' products' AS "Quantity Sold"
FROM (SELECT "countt"=COUNT(refreshmentID)FROM RefreshmentTrans WHERE DATENAME(WEEKDAY,transactionRDate)in ('Saturday', 'Sunday') AND quantitySold > 5) AS "kount",
(SELECT "sumee"=SUM(quantitySold)FROM RefreshmentTrans WHERE DATENAME(WEEKDAY,transactionRDate)in ('Saturday', 'Sunday') AND quantitySold > 5) AS "Summe",
RefreshmentTrans
WHERE DATENAME(WEEKDAY,transactionRDate)in ('Saturday', 'Sunday') AND quantitySold > 5
