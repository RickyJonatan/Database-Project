/*
 * Kelompok 7 / Kelompok G
 * 1. William Suryadi       - 2201742135
 * 2. Ricky Jonatan         - 2201772472
 * 3. Osvaldo Richie Riady  - 2201823290
 * 4. Louis Raymond         - 2201849535
 */


USE Project;

/* This is Lyora's 3rd Task */

SELECT 'IDR ' + CAST(AVG(rf.refreshmentPrice) AS VARCHAR) 'Display Average Refreshment Revenue per Day', 
    DATEDIFF(DD, MIN(rt.transactionRDate), MAX(rt.transactionRDate)) AS 'Transaction Days', 
	COUNT(s.staffGender) AS 'Female Staff Count'
FROM Refreshment rf, RefreshmentTrans rt, Staff s
WHERE rf.refreshmentID = rt.refreshmentID AND 
    rt.staffID = s.staffID AND
    s.staffGender = 'Female' AND         -- handled by staff whose gender is female
    rt.transactionRDate < '2020-02-10'   -- transaction date is before 10 February 2020
;
