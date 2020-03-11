-- Add DPR geometries to attributes table

WITH proj AS(
SELECT ST_Multi(ST_Union(wkb_geometry)) as geom,
       replace(fmsid, ' ', '') as fmsid
FROM dpr_capitalprojects
GROUP BY fmsid
)
UPDATE cpdb_dcpattributes
SET geom = proj.geom,
    maprojid = proj.fmsid,
    dataname = 'dpr_capitalprojects',
    datasource = 'dpr',
    geomsource = 'dpr'
FROM proj
WHERE cpdb_dcpattributes.maprojid = proj.fmsid;
