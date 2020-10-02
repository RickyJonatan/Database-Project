/*
 * Kelompok 7 / Kelompok G
 * 1. William Suryadi       - 2201742135
 * 2. Ricky Jonatan         - 2201772472
 * 3. Osvaldo Richie Riady  - 2201823290
 * 4. Louis Raymond         - 2201849535
 */


USE Project;

/* This is Lyora's 5th Task */

SELECT RefreshmentTransactionID.refreshmentTransID AS 'Refreshment Transaction ID',
       FORMAT(RefreshmentTransactionID.transactionRDate, 'MMM dd, yyyy') AS 'Refreshment Transaction Date' -- transaction date in ‘mon dd, yyyy’ format
FROM Refreshment rf,
     (SELECT RIGHT(rt.refreshmentTransID, 3) AS 'refreshmentTransID',   -- last three number of Transaction ID
	               refreshmentID,          
	               transactionRDate, 
				   quantitySold 
	                                         FROM RefreshmentTrans rt) AS RefreshmentTransactionID,
	 (SELECT RefreshmentTrans.quantitySold FROM RefreshmentTrans) AS RTQty
WHERE RefreshmentTransactionID.refreshmentID = RefreshmentTransactionID.refreshmentID AND
      CAST(RefreshmentTransactionID.refreshmentTransID AS INT) BETWEEN 6 AND 10 -- refreshment type ID is either ‘RT006’, ‘RT007’, ‘RT008’, ‘RT009’, or ‘RT010’.
GROUP BY RefreshmentTransactionID.quantitySold, rf.refreshmentPrice, RefreshmentTransactionID.refreshmentTransID, RefreshmentTransactionID.transactionRDate
HAVING RefreshmentTransactionID.quantitySold*rf.refreshmentPrice > AVG(RTQty.quantitySold)*rf.refreshmentPrice -- every refreshment transaction which quantity multiplied by refreshment price is more than average quantity multiplied by refreshment price
;