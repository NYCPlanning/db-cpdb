--Update lines to be polygons
UPDATE cpdb_dcpattributes SET geom = ST_SnapToGrid(geom, .001);
UPDATE cpdb_dcpattributes
SET geom=ST_Buffer(geom::geography, 15)::geometry
WHERE ST_GeometryType(geom) = 'ST_MultiLineString';

--Update geom to be multi
UPDATE cpdb_dcpattributes
SET geom=ST_Multi(geom)
WHERE ST_GeometryType(geom) in ('ST_Polygon', 'ST_Point');

echo 'make geom valid'
--Make the geom valid
UPDATE cpdb_dcpattributes
SET geom=ST_MakeValid(geom)
WHERE ST_IsValid(geom) = FALSE