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
    WHERE c.projectid = p.projectid AND
    c.projectid = b.projectid
    )
SELECT s.*
FROM summary s);

DROP TABLE IF EXISTS cpdb_opendata_projects;
CREATE TABLE cpdb_opendata_projects AS (
    WITH summary AS (
    SELECT 
    FROM
    WHERE
SELECT s.*
FROM summary s);
    )
)
