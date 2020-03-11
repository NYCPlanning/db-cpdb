-- Projects w/ geoms for agency verifiction (sagency)
COPY(
WITH projects AS (
	SELECT a.*, 
		b.sagencyacro, 
		b.totalcost::double precision
	FROM cpdb_dcpattributes a
	LEFT JOIN (
		SELECT DISTINCT maprojid, 
			sagencyacro, 
			SUM(totalcost::double precision) AS totalcost 
		FROM cpdb_budgets 
		WHERE ccpversion = '2017_Apr'
		GROUP BY maprojid, sagencyacro
		) b
	ON a.maprojid=b.maprojid
	WHERE ccpversion = '2017_Apr')

SELECT a.maprojid, 
	a.sagencyacro, 
	a.magencyacro, 
	a.description, 
	a.typecategory,
	a.dataname
FROM projects a
WHERE geom IS NOT NULL 
AND dataname IS NULL
AND ccpversion = '2017_Apr'
)TO '/tmp/projects_DCPmapped.csv' DELIMITER ',' CSV HEADER;