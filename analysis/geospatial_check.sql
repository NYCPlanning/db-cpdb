DROP TABLE IF EXISTS geospatial_check_table;
CREATE TABLE IF NOT EXISTS geospatial_check_table(
    v character varying,
    result character varying
);

DELETE FROM geospatial_check_table
WHERE v = :'ccp_v';

INSERT INTO geospatial_check_table (
select :'ccp_v' as v, 	 
        jsonb_agg(t) as result
from (
    select jsonb_agg(json_build_object('projectid', tmp.projectid, 'magencyacr',tmp.magencyacr, 
                              'typecatego', tmp.typecatego)) as values, 
                              'projects_not_within_NYC' as field
	from (SELECT a.projectid, a.magencyacr, a.typecatego
          FROM cpdb_dcpattributes_poly a, 
               (SELECT ST_Union(wkb_geometry) geom
               FROM dcp_boroboundaries_wi) combined 
          WHERE NOT ST_WITHIN(a.geom, combined.geom)) tmp
    )t
)