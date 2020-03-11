-- to export results: pgsql2shp -f bpbyag.shp cpdb bpbyag

-- get points from multipoints

DROP VIEW IF EXISTS bpbyag_pts CASCADE;

CREATE VIEW bpbyag_pts AS (
WITH projects AS (
   SELECT a.maprojid, a.magencyacro, a.description,
          a.typecategory, a.dataname, a.ccpversion,
          (ST_DUMP(geom)).geom as geom, b.sagencyacro, b.totalcost::double precision
   FROM cpdb_dcpattributes a
   LEFT JOIN
     (SELECT DISTINCT maprojid, sagencyacro, SUM(totalcost::double precision) AS totalcost
      FROM cpdb_budgets
      WHERE ccpversion = '2017_Apr'
      GROUP BY maprojid, sagencyacro
      ) b
    ON a.maprojid=b.maprojid
    WHERE ccpversion = '2017_Apr' AND
          ST_GeometryType(geom) = 'ST_MultiPoint')
SELECT a.maprojid, a.sagencyacro, a.magencyacro,
       a.description, a.typecategory, a.geom
FROM projects a
WHERE geom IS NOT NULL AND
     (dataname IS NULL OR dataname = 'dpr_properties') AND
      ccpversion = '2017_Apr'
);

-- get all multipolygons and make them polygons and then points
DROP VIEW IF EXISTS bpbyag_poly;

CREATE VIEW bpbyag_poly AS (
WITH projects AS (
   SELECT a.maprojid, a.magencyacro, a.description,
          a.typecategory, a.dataname, a.ccpversion,
          (ST_DUMP(geom)).geom as geom, b.sagencyacro, b.totalcost::double precision
   FROM cpdb_dcpattributes a
   LEFT JOIN
     (SELECT DISTINCT maprojid, sagencyacro, SUM(totalcost::double precision) AS totalcost
      FROM cpdb_budgets
      WHERE ccpversion = '2017_Apr'
      GROUP BY maprojid, sagencyacro
      ) b
    ON a.maprojid=b.maprojid
    WHERE ccpversion = '2017_Apr' AND
          ST_GeometryType(geom) = 'ST_MultiPolygon')
SELECT a.maprojid, a.sagencyacro, a.magencyacro,
       a.description, a.typecategory, ST_SetSRID(ST_Centroid(a.geom), 4326) as geom
FROM projects a
WHERE geom IS NOT NULL AND
      (dataname IS NULL OR dataname = 'dpr_properties') AND
      ccpversion = '2017_Apr'
);

-- combine views

CREATE VIEW bpbyag AS (
SELECT * FROM bpbyag_pts
UNION
SELECT * FROM bpbyag_poly
);
