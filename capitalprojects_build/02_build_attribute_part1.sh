#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi
psql $BUILD_ENGINE -f sql/projects_fisa.sql
psql $BUILD_ENGINE -f sql/budget_fisa.sql
psql $BUILD_ENGINE -f sql/commitments_fisa.sql

# Attributs
start=$(date +'%T')
echo "Starting Attributes Table work at: $start"

# create the table
echo 'Creating Attributes Table'
psql $BUILD_ENGINE -f sql/attributes.sql

# categorize the projects
echo 'Categorizing projects'
psql $BUILD_ENGINE -f sql/projectscategorization.sql


## Geometries
### Old values can be overwritten later
# create old sprints table
echo 'Creating old sprints table'
psql $BUILD_ENGINE -c "
    CREATE TABLE sprints (
        maprojid text, 
        bbl text , 
        bin text,
        geomsource text, 
        geom geometry)"

psql $BUILD_ENGINE -f attributes/sprints.sql

# update cpdb_dcpattributes with geoms from sprints
echo 'Updating geometries from old sprints'
psql $BUILD_ENGINE -c "
    UPDATE cpdb_dcpattributes a 
    SET geomsource = b.geomsource, geom = b.geom 
    FROM sprints as b 
    WHERE a.maprojid = b.maprojid;" 

# These manual geometries may overwrite old sprints. That's good.
psql $BUILD_ENGINE -c "
      UPDATE cpdb_dcpattributes a
      SET geomsource = 'DCP_geojson', 
          geom = ST_SetSRID(ST_GeomFromText(ST_AsText(b.geom)), 4326)
      FROM dcp_json b
      WHERE b.maprojid = a.maprojid
      "
echo 'Loading geometries from id->bin->footprint mapping'
psql $BUILD_ENGINE -f attributes/geom_from_id_bin_map.sql

# agency geometries
# These should not be overwritten unless by ddc so ddc is last.
# These may overwrite old geometries from above.

# dot
echo 'Adding DOT geometries'
psql $BUILD_ENGINE -f sql/attributes_dot.sql

# dpr
echo 'Adding DPR geometries by FMS ID'
psql $BUILD_ENGINE -f sql/attributes_dpr_fmsid.sql

# edc
echo 'Adding EDC geometries'
psql $BUILD_ENGINE -f sql/attributes_edc.sql

# ddc
echo 'Adding DDC geometries'
psql $BUILD_ENGINE -f sql/attributes_ddc.sql

# agency verified Summer 2017
# create geoms for agency mapped projects
echo 'Creating geometries for agency verified data - Summer 2017'
psql $BUILD_ENGINE -f sql/attributes_agencyverified_geoms.sql