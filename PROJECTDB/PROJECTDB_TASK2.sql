/*
 * Kelompok 7 / Kelompok G
 * 1. William Suryadi       - 2201742135
 * 2. Ricky Jonatan         - 2201772472
 * 3. Osvaldo Richie Riady  - 2201823290
 * 4. Louis Raymond         - 2201849535
 */


 USE Project;

 /* This is Lyora's 2nd Task */

SELECT s.staffName AS 'StaffName', mt.seatSold AS 'Total Sold Seats'
FROM Staff s, MovieTrans mt
WHERE s.staffID = mt.staffID AND
    s.staffGender = 'Male' AND       -- handled by staff whose gender is male
	DAY(mt.transactionMDate) < 28    -- occurred before the 28th before the month
;