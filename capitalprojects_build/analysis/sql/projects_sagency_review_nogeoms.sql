-- Projects where category is Fixed Asset or NULL and geom is NULL (sagency)
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

SELECT maprojid, 
	sagencyacro, 
	magencyacro, 
	description, 
	typecategory
FROM projects
WHERE geom IS NULL
	AND (typecategory = 'Fixed Asset' OR typecategory IS NULL) 
	AND (dataname IS NULL OR dataname = 'dpr_properties')
	AND ccpversion = '2017_Apr'
)TO '/tmp/projects_unmapped.csv' DELIMITER ',' CSV HEADER;

