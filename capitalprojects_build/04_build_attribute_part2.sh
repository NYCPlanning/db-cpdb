#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
source $CURRENT_DIR/config.sh

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

################################
# attributes relational tables #
################################

# facilities relational table
echo 'Creating facilities relational table based on fuzzy string matching'
psql $BUILD_ENGINE -f sql/attributes_maprojid_facilities.sql

# and add geometries from FabDB based on that match above
psql $BUILD_ENGINE -f sql/attributes_facilities.sql
