#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

echo 'Creating maprojid --> parkid relational table'
psql $BUILD_ENGINE -f sql/attributes_maprojid_parkid.sql

###########################
# final geometry clean-up #
###########################

# geometry cleaning -- lines to polygons and all geoms to multi
echo 'Cleaning geometries: lines to polygons and geoms to multi'
psql $BUILD_ENGINE -f sql/attributes_geomclean.sql

# remove faulty geometries
echo 'Removing bad geometries'
psql $BUILD_ENGINE -f sql/attributes_badgeoms.sql
# psql $BUILD_ENGINE -c "\copy cpdb_badgeoms FROM '/home/capitalprojects_build/cpdb_geomsremove.csv' DELIMITER ',' CSV;"

# complete
end=$(date +'%T')
echo "Finished with Attributes Table at: $end"
