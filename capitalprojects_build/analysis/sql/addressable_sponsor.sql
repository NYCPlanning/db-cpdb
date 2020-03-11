-- find geometries as buildings vs infrastructure

-- number of geometries that are addressable
WITH addressable as (
SELECT COUNT(*) as addressable,
       b.sagencyacro
FROM cpdb_dcpattributes a
LEFT JOIN
( SELECT DISTINCT maprojid, sagencyacro
  FROM cpdb_budgets
  GROUP BY maprojid, sagencyacro
 ) b
 ON a.maprojid = b.maprojid
WHERE a.geom IS NOT NULL AND
      a.ccpversion = '2017_Apr' AND
      (a.bin IS NOT NULL OR
       a.bbl IS NOT NULL OR
       a.geomsource = 'Facilities database' OR
       a.geomsource = 'footprint_script' OR
       a.dataname = 'ddc_capitalprojects_publicbuildings'
      )
GROUP BY sagencyacro
ORDER BY sagencyacro), notaddressable as (
SELECT COUNT(*) as notaddressable,
       b.sagencyacro
FROM cpdb_dcpattributes a
LEFT JOIN
(SELECT DISTINCT maprojid, sagencyacro FROM cpdb_budgets
 GROUP BY maprojid, sagencyacro
 ) b
 ON a.maprojid = b.maprojid
WHERE a.geom IS NOT NULL AND
      a.ccpversion = '2017_Apr' AND
      (a.segmentid IS NOT NULL OR
       (a.dataname <> 'ddc_capitalprojects_publicbuildings' AND
        a.dataname <> 'dpr_properties' AND
        a.dataname IS NOT NULL)
      )
GROUP BY sagencyacro
ORDER BY sagencyacro), parks as (
SELECT COUNT(*) as parks,
       b.sagencyacro
FROM cpdb_dcpattributes a
LEFT JOIN
(SELECT DISTINCT maprojid, sagencyacro, SUM(totalcost::double precision) AS totalcost FROM cpdb_budgets
 GROUP BY maprojid, sagencyacro
 ) b
 ON a.maprojid = b.maprojid
WHERE a.geom IS NOT NULL AND
      a.ccpversion = '2017_Apr' AND
      a.bin IS NULL AND
      a.bbl IS NULL AND
      (a.parkid IS NOT NULL OR
       a.dataname = 'dpr_properties')
GROUP BY sagencyacro
ORDER BY sagencyacro)
SELECT a.sagencyacro, a.addressable, b.notaddressable, c.parks
FROM addressable a FULL JOIN notaddressable b ON a.sagencyacro = b.sagencyacro FULL JOIN parks c ON a.sagencyacro = c.sagencyacro;
