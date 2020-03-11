-- Summary of $s commitments by managing agency for a given fiscal year
WITH master AS 
	(SELECT a.*, b.magencyacro 
		FROM cpdb_commitments a
		LEFT JOIN cpdb_projects b
		ON a.maprojid=b.maprojid) 

SELECT magencyacro, 
	SUM(citycost) AS citycost, 
	SUM(noncitycost) AS noncitycost, 
	SUM(totalcost) AS totalcost
FROM master
WHERE ((RIGHT(plancommdate,2) = '17' 
	AND LEFT(plancommdate,2)::double precision > '6') 
	OR (RIGHT(plancommdate,2) = '18' 
	AND LEFT(plancommdate,2)::double precision < '7'))
GROUP BY magencyacro
ORDER BY magencyacro