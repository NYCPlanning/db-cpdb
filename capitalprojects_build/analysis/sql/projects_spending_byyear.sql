-- Create summary table of spending by year for each project in the Captial Commitment Plan
DROP TABLE IF EXISTS cpdb_projects_spending_byyear;
CREATE TABLE cpdb_projects_spending_byyear AS (
	SELECT a.maprojid,
	b.totalspenddate as spend2010,
	c.totalspenddate as spend2011,
	d.totalspenddate as spend2012,
	e.totalspenddate as spend2013,
	f.totalspenddate as spend2014,
	g.totalspenddate as spend2015,
	h.totalspenddate as spend2016,
	i.totalspenddate as spend2017,
	j.totalspenddate as spend2018
	FROM cpdb_projects a
	LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2010
		GROUP BY TRIM(LEFT(capital_project,12))
		) b ON a.maprojid=b.maprojid
	LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2011
		GROUP BY TRIM(LEFT(capital_project,12))
		) c ON a.maprojid=c.maprojid
	LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2012
		GROUP BY TRIM(LEFT(capital_project,12))
		) d ON a.maprojid=d.maprojid
	LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2013
		GROUP BY TRIM(LEFT(capital_project,12))
		) e ON a.maprojid=e.maprojid
	LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2014
		GROUP BY TRIM(LEFT(capital_project,12))
		) f ON a.maprojid=f.maprojid
	LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2015
		GROUP BY TRIM(LEFT(capital_project,12))
		) g ON a.maprojid=g.maprojid
	LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2016
		GROUP BY TRIM(LEFT(capital_project,12))
		) h ON a.maprojid=h.maprojid
	LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2017
		GROUP BY TRIM(LEFT(capital_project,12))
		) i ON a.maprojid=i.maprojid
	 LEFT JOIN (
		SELECT TRIM(LEFT(capital_project,12)) AS maprojid, 
		SUM(check_amount::double precision) AS totalspenddate 
		FROM capital_spending 
		WHERE LEFT(issue_date, 4)::double precision = 2018
		GROUP BY TRIM(LEFT(capital_project,12))
		) j ON a.maprojid=j.maprojid
	 WHERE b.totalspenddate IS NOT NULL
	 	OR c.totalspenddate IS NOT NULL
	 	OR d.totalspenddate IS NOT NULL
	 	OR e.totalspenddate IS NOT NULL
	 	OR f.totalspenddate IS NOT NULL
	 	OR g.totalspenddate IS NOT NULL
	 	OR h.totalspenddate IS NOT NULL
	 	OR i.totalspenddate IS NOT NULL
	 	OR j.totalspenddate IS NOT NULL
	 );