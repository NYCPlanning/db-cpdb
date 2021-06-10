#!/bin/bash
source bash/config.sh


psql $BUILD_ENGINE -f sql/projects_fisa.sql
psql $BUILD_ENGINE -f sql/budget_fisa.sql
psql $BUILD_ENGINE -f sql/commitments_fisa.sql

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
    DROP TABLE IF EXISTS sprints;
    CREATE TABLE sprints (
        maprojid text, 
        bbl text, 
        bin text,
        geomsource text, 
        geom geometry)"

psql $BUILD_ENGINE -f sql/sprints.sql

# update cpdb_dcpattributes with geoms from sprints
echo 'Updating geometries from old sprints'
psql $BUILD_ENGINE -c "
    UPDATE cpdb_dcpattributes a 
    SET geomsource = b.geomsource, geom = b.geom 
    FROM sprints as b 
    WHERE a.maprojid = b.maprojid
    AND b.geom IS NOT NULL;" 

# These manual geometries may overwrite old sprints. That's good.
psql $BUILD_ENGINE -c "
      UPDATE cpdb_dcpattributes a
      SET geomsource = 'DCP_geojson', 
          geom = ST_SetSRID(ST_GeomFromText(ST_AsText(b.geom)), 4326)
      FROM dcp_json b
      WHERE b.maprojid = a.maprojid
      AND b.geom IS NOT NULL;
      "
echo 'Loading geometries from id->bin->footprint mapping'
psql $BUILD_ENGINE -f sql/geom_from_id_bin_map.sql

# Create 2020 manual geometry table

echo 'Creating 2020 manual geometry table'
cat 'data/edcgeoms_2021-01-08.csv' |
psql $BUILD_ENGINE -c "
    DROP TABLE IF EXISTS manual_geoms_2020;
    CREATE TABLE manual_geoms_2020 (
        cartoid text, 
        maprojid text,
        project_discription text,
        footprint_project_id text,
        footprint_project_geomsource text,
        geom geometry);
    COPY manual_geoms_2020 FROM STDIN DELIMITER ',' CSV HEADER;
    UPDATE manual_geoms_2020 a
        SET footprint_project_geomsource = 'EP 2020'
        WHERE a.footprint_project_geomsource ~* 'AD Sprint';
    SELECT UpdateGeometrySRID('manual_geoms_2020','geom',4326);"

psql $BUILD_ENGINE -c "
    UPDATE cpdb_dcpattributes a 
    SET geomsource = b.footprint_project_geomsource, geom = b.geom 
    FROM manual_geoms_2020 as b 
    WHERE a.maprojid = b.maprojid
    AND b.geom IS NOT NULL;" 


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

# geocode agencyverified
docker run --rm\
    --network host\
    -v $(pwd)/python:/home/python\
    -w /home/python\
    -e BUILD_ENGINE=$BUILD_ENGINE\
    nycplanning/docker-geosupport:latest bash -c "
      python3 attributes_geom_agencyverified_geocode.py"

# These may overwrite any geometry from above
echo 'Adding agency verified geometries'
psql $BUILD_ENGINE -f sql/attributes_agencyverified.sql

# String matching should never overwrite a geometry from above

# dpr -- fuzzy string on park id
echo 'Adding DPR geometries based on string matching for park id'
psql $BUILD_ENGINE -f sql/attributes_dpr_string_id.sql

# dpr -- fuzzy string on park name
echo 'Adding DPR geometries based on string matching for park name'
psql $BUILD_ENGINE -f sql/attributes_dpr_string_name.sql

echo
echo "################################"
echo "# attributes relational tables #"
echo "################################"
echo

# facilities relational table
echo 'Creating facilities relational table based on fuzzy string matching'
psql $BUILD_ENGINE -f sql/attributes_maprojid_facilities.sql

# and add geometries from FabDB based on that match above
psql $BUILD_ENGINE -f sql/attributes_facilities.sql

# 05_geocode_maprojid_parkid
python3 attributes_maprojid_parkid.py

echo 'Creating maprojid --> parkid relational table'
psql $BUILD_ENGINE -f sql/attributes_maprojid_parkid.sql

echo
echo "###########################"
echo "# final geometry clean-up #"
echo "###########################"
echo

# geometry cleaning -- lines to polygons and all geoms to multi
echo 'Cleaning geometries: lines to polygons and geoms to multi'
psql $BUILD_ENGINE -f sql/attributes_geomclean.sql

# remove faulty geometries	
echo 'Removing bad geometries'	
psql $BUILD_ENGINE -f sql/attributes_badgeoms.sql	
# psql $BUILD_ENGINE -c "\copy cpdb_badgeoms FROM '/home/capitalprojects_build/cpdb_geomsremove.csv' DELIMITER ',' CSV;"
