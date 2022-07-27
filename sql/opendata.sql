--create tabular cpdb commitments table
DROP TABLE IF EXISTS cpdb_opendata_commitments;
CREATE TABLE cpdb_opendata_commitments AS (
    WITH summary AS (
    SELECT c.maprojid, 
    c.magency,
    c.projectid,
    p.description, 
    c.budgetline,
    b.projecttype, 
    c.plancommdate,
    c.commitmentdescription,
    c.commitmentcode,
    c.typc,
    c.typcname,
    c.ccnonexempt,
    c.ccexempt,
    p.citycost AS totalcityplannedcommit
    c.nccstate,
    c.nccfederal, 
    c.nccother,
    p.noncitycost AS totalnoncityplannedcommit,
    p.totalcost AS totalplannedcommit,
    b.sagencyacro, 
    b.sagencyname,
    p.magencyacro, 
    p.magencyname, 
    c.ccpversion
    FROM cpdb_commitments as c,
        cpdb_budgets as b, 
        cpdb_projects as p
    WHERE c.maprojid = p.maprojid AND
    c.maprojid = b.maprojid
    )
SELECT s.*
FROM summary s);

--Create tabular cpdb projects table
DROP TABLE IF EXISTS cpdb_opendata_projects;
CREATE TABLE cpdb_opendata_projects AS (
    WITH summary AS (
    SELECT p.maprojid,
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
    WHERE p.maprojid = pc.maprojid
    )
SELECT s.*
FROM summary s);

DROP TABLE IF EXISTS cpdb_opendata_projects_pts;
CREATE TABLE cpdb_opendata_projects_pts AS (
    WITH summary AS (
    SELECT p.maprojid,
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
    g.geom
    FROM cpdb_projects as p,
    cpdb_projects_combined as pc, 
    cpdb_dcpattributes_pts as g
    WHERE p.maprojid = pc.maprojid AND
    p.maprojid = g.maprojid
    )
SELECT S.*
FROM summary s);

DROP TABLE IF EXISTS cpdb_opendata_projects_poly;
CREATE TABLE cpdb_opendata_projects_poly AS (
    WITH summary AS (
    SELECT p.maprojid,
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
    g.geom
    FROM cpdb_projects as p,
    cpdb_projects_combined as pc, 
    cpdb_dcpattributes_poly as g
    WHERE p.maprojid = pc.maprojid AND
    p.maprojid = g.maprojid
    )
SELECT S.*
FROM summary s);