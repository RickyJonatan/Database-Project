/*
 * Kelompok 7 / Kelompok G
 * 1. William Suryadi       - 2201742135
 * 2. Ricky Jonatan         - 2201772472
 * 3. Osvaldo Richie Riady  - 2201823290
 * 4. Louis Raymond         - 2201849535
 */


USE Project;

/* This is Lyora's 1st Task */

SELECT mv.movieID AS 'MovieID', 'IDR ' + CAST(sd.studioPrice*mt.seatSold AS VARCHAR) AS 'Total Revenue'
FROM Movie mv, MovieTrans mt, Studio sd, ScheduleTrans st
WHERE mv.movieID = st.movieID AND 
      st.studioID = sd.studioID AND 
	  st.scheduleID = mt.scheduleID AND 
	  sd.studioPrice > 50000 AND            -- studio price higher than 50000
      DAY(st.showTime) < 20                 -- occurred before the 20th day of the month
;