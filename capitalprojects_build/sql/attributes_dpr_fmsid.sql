-- Add DPR geometries to attributes table

WITH proj AS(
SELECT (CASE when lat = 0 then null 
        else ST_Multi(ST_Union(wkb_geometry)
        end) as geom,
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
