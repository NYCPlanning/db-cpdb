#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

echo 'Creating maprojid --> parkid relational table'
psql $BUILD_ENGINE -f sql/attributes_maprojid_parkid.sql

# Add c3p geometries
(
    cd db-cpdb-c3p
    # build c3p inputs in python
    ./_runner.sh build
    # loading new geometry table
    ./_runner.sh create
    # creating new mapped flag
    ./_runner.sh flag_geo
)

###########################
# final geometry clean-up #
###########################

# geometry cleaning -- lines to polygons and all geoms to multi
echo 'Cleaning geometries: lines to polygons and geoms to multi'
psql $BUILD_ENGINE -f sql/attributes_geomclean.sql

# complete
end=$(date +'%T')
echo "Finished with Attributes Table at: $end"
