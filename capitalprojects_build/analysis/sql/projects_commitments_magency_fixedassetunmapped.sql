-- Managing agency: Summary table of # of project and total $s in CPDB for projects that are categorized by Fixed Asset and unmapped
COPY(
WITH projects AS (
	SELECT a.*, b.totalcost 
	FROM cpdb_dcpattributes a
	LEFT JOIN cpdb_projects b
	ON a.maprojid=b.maprojid
	WHERE typecategory = 'Fixed Asset'
	AND geom IS NULL)

SELECT DISTINCT a.magencyacro,
	b.count as projectslessthan1m,
	b.sum as commitlessthan1m,
	c.count as projects1and5m,
	c.sum as commit1and5m,
	d.count as projects5and10m,
	d.sum as commit5and10m,
	e.count as projects10and20m,
	e.sum as commit10and20m,
	f.count as projectsgreaterthan20m,
	f.sum as commitgreaterthan20m,
	g.count as projectstotal,
	g.sum as committotal
FROM projects a

LEFT JOIN(
	SELECT magencyacro, 
	COUNT(*),
	SUM (totalcost)
	FROM projects
	WHERE totalcost<1000000 
	GROUP BY magencyacro
	) AS b 
ON a.magencyacro=b.magencyacro

LEFT JOIN(
	SELECT magencyacro, 
	COUNT(*),
	SUM (totalcost)
	FROM projects
	WHERE totalcost>=1000000 AND totalcost <5000000
	GROUP BY magencyacro
	) AS c 
ON a.magencyacro=c.magencyacro

LEFT JOIN(
	SELECT magencyacro, 
	COUNT(*),
	SUM (totalcost)
	FROM projects
	WHERE totalcost>=5000000 AND totalcost <10000000
	GROUP BY magencyacro
	) AS d
ON a.magencyacro=d.magencyacro

LEFT JOIN(
	SELECT magencyacro, 
	COUNT(*),
	SUM (totalcost)
	FROM projects
	WHERE totalcost>=10000000 AND totalcost <20000000
	GROUP BY magencyacro
	) AS e
ON a.magencyacro=e.magencyacro

LEFT JOIN(
	SELECT magencyacro, 
	COUNT(*),
	SUM (totalcost)
	FROM projects
	WHERE totalcost>=20000000
	GROUP BY magencyacro
	) AS f
ON a.magencyacro=f.magencyacro

LEFT JOIN(
	SELECT magencyacro, 
	COUNT(*),
	SUM (totalcost)
	FROM projects
	GROUP BY magencyacro
	) AS g
ON a.magencyacro=g.magencyacro

ORDER BY a.magencyacro

) TO '/home/capitalprojects_build/analysis/output/cpdb_summarystats_magency_fixedassetunmapped.csv' DELIMITER ',' CSV HEADER;
