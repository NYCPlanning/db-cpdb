-- get spending by council district for individual projects
COPY (

WITH spending_merged AS (
  SELECT TRIM(LEFT(capital_project,12)) AS maprojid,
       SUM(check_amount::double precision) AS total_spend
  FROM capital_spending
 -- WHERE LEFT(issue_date, 4)::double precision >= 2014
  GROUP BY TRIM(LEFT(capital_project,12))
    ),
  fmsmerge AS (
     SELECT a.*,
        b.description,
            b.geom
     FROM spending_merged a,
          cpdb_dcpattributes b
     WHERE b.ccpversion = 'fisa_2017' AND
           a.maprojid = b.maprojid
     ORDER BY maprojid
     ),
  per_pt AS (
     SELECT maprojid,
            description,
            SUM(total_spend)/ST_NumGeometries(geom) as amt_per_pt,
            (ST_Dump(geom)).geom as geom
     FROM fmsmerge
     WHERE geom IS NOT NULL AND
           ST_GeometryType(geom)='ST_MultiPoint'
     GROUP BY maprojid,
        description,
              geom
     ),
  cd_pt AS ( -- join community districts with point and sum spending
             -- assumes equal spending at each point
     SELECT a.coundist,
            b.maprojid,
            b.description,
            SUM(b.amt_per_pt) as amt_pt
     FROM dcp_councildistricts a
     LEFT JOIN per_pt b ON ST_Within(b.geom, a.geom)
     GROUP BY a.coundist, b.maprojid, b.description
     ),
  per_poly AS (
     SELECT maprojid,
            description,
            SUM(total_spend) as total_amt,
            ST_Area(geom) as total_area,
            (ST_Dump(geom)).geom as geom
     FROM fmsmerge
     WHERE geom IS NOT NULL AND
           ST_GeometryType(geom)='ST_MultiPolygon'
     GROUP BY maprojid,
              description,
              geom
     ),
  cd_poly AS( -- join community districts with polygons and sum spending
              -- divides spending proportional to size of the multiple site polygons
              -- then if there is a polygon that crosses multiple community districts
              -- divides that spending again proportional to size of each intersection
     SELECT a.coundist,
            c.maprojid,
            c.description,
            SUM(c.total_amt *
            (ST_Area(c.geom) / c.total_area) *
            ST_Area(ST_Intersection(c.geom, a.geom)) / ST_Area(c.geom)) as amt_poly
     FROM dcp_councildistricts a
     LEFT JOIN per_poly c ON ST_Intersects(c.geom, a.geom)
     WHERE ST_IsValid(a.geom) = 't' AND
           ST_IsValid(c.geom) = 't'
     GROUP BY a.coundist,
              c.maprojid,
              c.description
     ),
  cd_all AS (
    SELECT coundist,
           maprojid,
           description,
           amt_pt as amt
    FROM cd_pt
    UNION
    SELECT coundist,
           maprojid,
           description,
           amt_poly as amt
    FROM cd_poly
      )

  SELECT a.*,
         b.magencyacro,
         b.typecategory,
         b.geomsource,
         b.dataname,
         b.datasource
         --ST_Multi(ST_Buffer(b.geom, 10)) AS geom
  FROM cd_all a
  LEFT JOIN (
    SELECT DISTINCT maprojid, magencyacro, typecategory, geomsource, dataname, datasource
    FROM cpdb_dcpattributes WHERE ccpversion = 'fisa_2017') b 
    ON a.maprojid=b.maprojid
    -- WHERE b.magencyacro = 'DPR'
    -- AND a.maprojid NOT IN (
    --   SELECT maprojid 
    --   FROM cpdb_dcpattributes a, dcp_ntaboundaries b 
    --   WHERE ST_Within(a.geom, b.geom)
    --   AND (b.ntacode LIKE '%99%'
    --     OR b.ntacode LIKE '%98%')
    --   )
  )TO '/tmp/projects_by_councildistrict_spending.csv' DELIMITER ',' CSV HEADER;
