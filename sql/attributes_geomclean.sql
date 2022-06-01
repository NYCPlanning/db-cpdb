--Update lines to be polygons
-- UPDATE cpdb_dcpattributes
-- SET geom=ST_Buffer(geom::geography, 15)::geometry
-- WHERE ST_GeometryType(geom) = 'ST_MultiLineString';


do $$
BEGIN
    FOR i IN 1..(SELECT(count(maprojid)) from cpdb_dcpattributes) by 100 LOOP 
        UPDATE cpdb_dcpattributes 
        SET geom=ST_Buffer(geom::geography, 15)::geometry
        WHERE ST_GeometryType(geom) = 'ST_MultiLineString' AND maprojid IN 
        (SELECT maprojid from cpdb_dcpattributes WHERE
         ST_GeometryType(geom) = 'ST_MultiLineString' LIMIT 100);
    END LOOP; 
--Update geom to be multi
UPDATE cpdb_dcpattributes
SET geom=ST_Multi(geom)
WHERE ST_GeometryType(geom) in ('ST_Polygon', 'ST_Point');
end; $$
