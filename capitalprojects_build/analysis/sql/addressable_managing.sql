-- find geometries as buildings vs infrastructure

-- number of geometries that are addressable
WITH addressable as (
SELECT COUNT(*) as addressable,
       magencyacro
FROM cpdb_dcpattributes a
WHERE a.geom IS NOT NULL AND
      a.ccpversion = '2017_Apr' AND
      (a.bin IS NOT NULL OR
       a.bbl IS NOT NULL OR
       a.geomsource = 'Facilities database' OR
       a.geomsource = 'footprint_script' OR
       a.dataname = 'ddc_capitalprojects_publicbuildings'
      )
GROUP BY magencyacro
ORDER BY magencyacro), notaddressable as (
SELECT COUNT(*) as notaddressable,
       magencyacro
FROM cpdb_dcpattributes a
WHERE a.geom IS NOT NULL AND
      a.ccpversion = '2017_Apr' AND
      (a.segmentid IS NOT NULL OR
       (a.dataname <> 'ddc_capitalprojects_publicbuildings' AND
        a.dataname <> 'dpr_properties' AND
        a.dataname IS NOT NULL)
      )
GROUP BY magencyacro
ORDER BY magencyacro), parks as (
SELECT COUNT(*) as parks,
       magencyacro
FROM cpdb_dcpattributes a
WHERE a.geom IS NOT NULL AND
      a.ccpversion = '2017_Apr' AND
      a.bin IS NULL AND
      a.bbl IS NULL AND
      (a.parkid IS NOT NULL OR
       a.dataname = 'dpr_properties')
GROUP BY magencyacro
ORDER BY magencyacro)
SELECT a.magencyacro, a.addressable, b.notaddressable, c.parks
FROM addressable a FULL JOIN notaddressable b ON a.magencyacro = b.magencyacro FULL JOIN parks c ON a.magencyacro = c.magencyacro;

