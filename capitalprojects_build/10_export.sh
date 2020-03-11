#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi
if [ -f version.env ]
then
  export $(cat version.env | sed 's/#.*//g' | xargs)
fi

source ./url_parse.sh $BUILD_ENGINE

# cpdb_dcpattributes
mkdir -p output/cpdb_dcpattributes_pts && 
    (cd output/cpdb_dcpattributes_pts
        pgsql2shp -u $BUILD_USER -h $BUILD_HOST -p $BUILD_PORT -P $BUILD_PWD -f cpdb_dcpattributes_pts $BUILD_DB \
        "SELECT * FROM cpdb_dcpattributes WHERE ccpversion = '$ccp_v' AND ST_GeometryType(geom)='ST_MultiPoint'"
        rm -f cpdb_dcpattributes_pts.zip
        echo "$ccp_v" > version.txt
        zip cpdb_dcpattributes_pts.zip *
        ls | grep -v cpdb_dcpattributes_pts.zip | xargs rm
    )

mkdir -p output/cpdb_dcpattributes_poly && 
    (cd output/cpdb_dcpattributes_poly
        pgsql2shp -u $BUILD_USER -h $BUILD_HOST -p $BUILD_PORT -P $BUILD_PWD -f cpdb_dcpattributes_poly $BUILD_DB \
        "SELECT * FROM cpdb_dcpattributes WHERE ccpversion = '$ccp_v' AND ST_GeometryType(geom)='ST_MultiPolygon'"
        rm -f cpdb_dcpattributes_poly.zip
        echo "$ccp_v" > version.txt
        zip cpdb_dcpattributes_poly.zip *
        ls | grep -v cpdb_dcpattributes_poly.zip | xargs rm
    )

#admin bounds
psql $BUILD_ENGINE -c "\copy (
    SELECT * FROM cpdb_adminbounds) TO stdout DELIMITER ',' CSV HEADER;" > output/cpdb_adminbounds.csv

# create flat file
#default to run on create data file from Capital Commitment Plan
psql $BUILD_ENGINE -v ccp_v=$ccp_v -f sql/attributes_combined_fisa.sql

psql $BUILD_ENGINE -c "\copy (
    SELECT * FROM cpdb_projects_combined) TO stdout DELIMITER ',' CSV HEADER;" > output/cpdb_projects_combined.csv

# Output individual helper tables
# cpdb_commitments
psql $BUILD_ENGINE -c "\copy (
    SELECT * FROM cpdb_commitments) TO stdout DELIMITER ',' CSV HEADER;" > output/cpdb_commitments.csv

# cpdb_projects
psql $BUILD_ENGINE -c "\copy (
    SELECT * FROM cpdb_projects) TO stdout DELIMITER ',' CSV HEADER;" > output/cpdb_projects.csv

# cpdb_budgets
psql $BUILD_ENGINE -c "\copy (
    SELECT * FROM cpdb_budgets) TO stdout DELIMITER ',' CSV HEADER;" > output/cpdb_budgets.csv

## cpdb_projects_spending_date
## outputs the maprojid and the sum of spending in each year.
psql $BUILD_ENGINE -v ccp_v=$ccp_v -f sql/projects_spending_byyear.sql

psql $BUILD_ENGINE -c "\copy (
    SELECT * FROM cpdb_projects_spending_byyear) TO stdout DELIMITER ',' CSV HEADER;" \
        > output/cpdb_projects_spending_byyear.csv