  -- get actual and projected spending by council district for individual projects
  COPY(
  WITH fms_bud AS (
     SELECT typ_category,
            LPAD(managing_agcy_cd, 3, '0')||project_id as maprojid,
            budget_proj_type,
            short_descr,
            SUM(fcst_cnx_amt + fcst_cex_amt + fcst_st_amt +
                         fcst_fd_amt + fcst_pv_amt) as amt
     FROM fms
     GROUP BY typ_category,
              LPAD(managing_agcy_cd, 3, '0')||project_id,
              budget_proj_type,
              short_descr
     ),
  fmsmerge AS (
     SELECT a.*,
            b.geom
     FROM fms_bud a,
          cpdb_dcpattributes b
     WHERE b.ccpversion = 'fisa_2017' AND
           a.maprojid = b.maprojid
     ORDER BY maprojid
     ),
  per_pt AS (
     SELECT maprojid,
            typ_category as typc,
            budget_proj_type,
            short_descr,
            SUM(amt)/ST_NumGeometries(geom) as amt_per_pt,
            (ST_Dump(geom)).geom as geom
     FROM fmsmerge
     WHERE geom IS NOT NULL AND
           ST_GeometryType(geom)='ST_MultiPoint'
     GROUP BY maprojid,
              typ_category,
              budget_proj_type,
              short_descr,
              geom
     ),
  cd_pt AS ( -- join community districts with point and sum spending
             -- assumes equal spending at each point
     SELECT a.coundist,
            b.maprojid,
            b.typc,
            b.budget_proj_type,
            b.short_descr,
            SUM(b.amt_per_pt) as amt_pt
     FROM dcp_councildistricts a 
     LEFT JOIN per_pt b ON ST_Within(b.geom, a.geom)
     GROUP BY a.coundist, b.maprojid, b.typc, b.budget_proj_type, b.short_descr
    ),
  per_poly AS (
     SELECT maprojid,
            typ_category as typc,
            budget_proj_type,
            short_descr,
            SUM(amt) as total_amt,
            ST_Area(geom) total_area,
            (ST_Dump(geom)).geom as geom
     FROM fmsmerge
     WHERE geom IS NOT NULL AND
           ST_GeometryType(geom)='ST_MultiPolygon'
     GROUP BY maprojid,
              typ_category,
              budget_proj_type,
              short_descr,
              geom
     ),
  cd_poly AS( -- join community districts with polygons and sum spending
              -- divides spending proportional to size of the multiple site polygons
              -- then if there is a polygon that crosses multiple community districts
              -- divides that spending again proportional to size of each intersection
     SELECT a.coundist,
            c.maprojid,
            c.typc,
            c.budget_proj_type,
            c.short_descr,
            SUM(c.total_amt *
            (ST_Area(c.geom) / c.total_area) *
            ST_Area(ST_Intersection(c.geom, a.geom)) / ST_Area(c.geom)) as amt_poly
     FROM dcp_councildistricts a
     LEFT JOIN per_poly c ON ST_Intersects(c.geom, a.geom)
     WHERE ST_IsValid(a.geom) = 't' AND
           ST_IsValid(c.geom) = 't'
     GROUP BY a.coundist,
              c.maprojid,
              c.typc,
              c.budget_proj_type,
              c.short_descr
     ),
  cd_all AS (
    SELECT coundist,
           maprojid,
           typc,
           budget_proj_type,
           short_descr,
           amt_pt as amt
    FROM cd_pt
    UNION
    SELECT coundist,
           maprojid,
           typc,
           budget_proj_type,
           short_descr,
           amt_poly as amt
    FROM cd_poly
      )

  SELECT a.*,
         b.typecategory,
         b.geomsource,
         b.dataname,
         b.datasource
         --ST_Multi(ST_Buffer(b.geom, 10)) AS geom
  FROM cd_all a
  LEFT JOIN (
    SELECT DISTINCT maprojid, typecategory, geomsource, dataname, datasource
    FROM cpdb_dcpattributes WHERE ccpversion = 'fisa_2017') b 
    ON a.maprojid=b.maprojid
)TO '/tmp/projects_by_councildistrict_commitments.csv' DELIMITER ',' CSV HEADER;
