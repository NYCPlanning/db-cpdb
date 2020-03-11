-- remove faulty geometries from attributes table

-- create table of faulty geometries
DROP TABLE IF EXISTS cpdb_badgeoms;
CREATE TABLE cpdb_badgeoms (
maprojid text
);

-- Remove
UPDATE cpdb_dcpattributes
SET geom = NULL
WHERE maprojid in (SELECT DISTINCT maprojid FROM cpdb_badgeoms)
AND (geomsource <> 'dpr' OR geomsource <> 'dot' OR geomsource <> 'ddc')
;

-- Remove from agency data
UPDATE cpdb_dcpattributes
SET geom = NULL
WHERE maprojid IN (
SELECT DISTINCT maprojid
FROM dcp_cpdb_agencyverified
WHERE (mappable = 'No - Can be in future'
OR mappable = 'No - Can never be mapped')
)
AND geom IS NOT NULL
;