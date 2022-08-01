--create tabular cpdb commitments table
DROP TABLE IF EXISTS cpdb_opendata_commitments;
WITH commit_proj as (
SELECT 
c.maprojid, 
c.magency,
c.projectid,
p.description, 
c.budgetline,
c.plancommdate,
c.commitmentdescription,
c.commitmentcode,
c.typc,
c.typcname,
c.ccnonexempt,
c.ccexempt,
p.citycost AS totalcityplannedcommit,
c.nccstate,
c.nccfederal, 
c.nccother,
p.noncitycost AS totalnoncityplannedcommit,
p.totalcost AS totalplannedcommit,
p.magencyacro, 
p.magencyname, 
c.ccpversion
FROM cpdb_commitments as c,
    cpdb_projects as p
WHERE c.maprojid = p.maprojid)
SELECT 
c.*,
b.projecttype, 
b.sagencyacro, 
b.sagencyname
INTO cpdb_opendata_commitments
FROM commit_proj as c, cpdb_budgets as b
WHERE
c.budgetline = b.budgetline
and c.maprojid = b.maprojid;

--Create tabular cpdb projects table
DROP TABLE IF EXISTS cpdb_opendata_projects;
WITH proj AS (
SELECT 
p.maprojid,
p.magency, 
p.projectid, 
p.description, 
p.ccnonexempt,
p.ccexempt, 
p.citycost AS totalcityplannedcommit,
p.nccstate, 
p.nccfederal, 
p.nccother, 
p.noncitycost AS totalnoncityplannedcommit, 
p.totalcost AS totalplannedcommit, 
pc.totalspend,
pc.maxdate, 
pc.mindate,
p.magencyacro,
p.magencyname,
pc.typecategory,
p.ccpversion
FROM cpdb_projects as p,
    cpdb_projects_combined as pc
WHERE p.maprojid = pc.maprojid)
SELECT p.*
INTO cpdb_opendata_projects
FROM proj as p;

DROP TABLE IF EXISTS cpdb_opendata_projects_pts;
WITH proj_pts AS (
SELECT 
p.maprojid,
p.magency, 
p.projectid, 
p.description, 
p.ccnonexempt,
p.ccexempt, 
p.citycost AS totalcityplannedcommit,
p.nccstate, 
p.nccfederal, 
p.nccother, 
p.noncitycost AS totalnoncityplannedcommit, 
p.totalcost AS totalplannedcommit, 
pc.totalspend,
pc.maxdate, 
pc.mindate,
p.magencyacro,
p.magencyname,
pc.typecategory,
p.ccpversion,
d.geom
FROM cpdb_projects as p,
cpdb_projects_combined as pc, 
cpdb_dcpattributes as d
WHERE 
p.maprojid = pc.maprojid AND
p.maprojid = d.maprojid AND
ST_GeometryType(geom)= 'ST_MultiPoint')
SELECT p.*
INTO cpdb_opendata_projects_pts
FROM proj_pts as p;


DROP TABLE IF EXISTS cpdb_opendata_projects_poly;
WITH proj_poly AS (
SELECT 
p.maprojid,
p.magency, 
p.projectid, 
p.description, 
p.ccnonexempt,
p.ccexempt, 
p.citycost AS totalcityplannedcommit,
p.nccstate, 
p.nccfederal, 
p.nccother, 
p.noncitycost AS totalnoncityplannedcommit, 
p.totalcost AS totalplannedcommit, 
pc.totalspend,
pc.maxdate, 
pc.mindate,
p.magencyacro,
p.magencyname,
pc.typecategory,
p.ccpversion,
d.geom
FROM cpdb_projects as p,
cpdb_projects_combined as pc, 
cpdb_dcpattributes as d
WHERE 
p.maprojid = pc.maprojid AND
p.maprojid = d.maprojid AND
ST_GeometryType(geom)= 'ST_MultiPolygon')
SELECT p.*
INTO cpdb_opendata_projects_poly
FROM proj_poly as p;
