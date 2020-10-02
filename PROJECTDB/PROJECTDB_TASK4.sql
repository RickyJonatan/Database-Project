/*
 * Kelompok 7 / Kelompok G
 * 1. William Suryadi       - 2201742135
 * 2. Ricky Jonatan         - 2201772472
 * 3. Osvaldo Richie Riady  - 2201823290
 * 4. Louis Raymond         - 2201849535
 */


USE Project;

/* This is Lyora's 4th Task */

GO

CREATE VIEW StaffView AS
SELECT 'Mr. ' + LEFT(MaleStaff.staffName, CHARINDEX(' ', MaleStaff.staffName, 0)) AS 'Staff First Name',        -- started with ‘Mr. ’ added with staff’s first name
    MaleStaff.staffID
FROM (SELECT s.staffName, s.staffID FROM Staff s WHERE s.staffGender = 'Male') AS MaleStaff
UNION
SELECT 'Ms. ' + LEFT(FemaleStaff.staffName, CHARINDEX(' ', FemaleStaff.staffName, 0)) AS 'Staff First Name',    -- started with ‘Ms. ’ added with staff’s first name
    FemaleStaff.staffID
FROM (SELECT s.staffName, s.staffID FROM Staff s WHERE s.staffGender = 'Female') AS FemaleStaff
;

GO

SELECT sv.[Staff First Name] AS 'Staff First Name',
    COUNT(rt.quantitySold) AS 'Total of Refreshment',  -- obtained  from count of refreshment
	SUM(rt.quantitySold) AS 'Total of Quantity Sold'   -- obtained from sum of quantity
FROM StaffView sv, 
    RefreshmentTrans rt
WHERE sv.staffID = rt.staffID
GROUP BY sv.[Staff First Name]
;

DROP VIEW StaffView;