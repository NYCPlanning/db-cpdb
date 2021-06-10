#!/bin/bash
source bash/config.sh


# cpdb_dcpattributes
psql $BUILD_ENGINE -v ccp_v=$ccp_v -f sql/_create_export.sql
psql $BUILD_ENGINE -v ccp_v=$ccp_v -f sql/attributes_combined_fisa.sql
python3 python/projects_spending_byyear.sql

mkdir -p output && (
    cd output
    SHP_export cpdb_dcpattributes_pts POINT &
    SHP_export cpdb_dcpattributes_poly MULTIPOLYGON &
    CSV_export cpdb_adminbounds &
    CSV_export cpdb_projects_combined &
    CSV_export cpdb_commitments &
    CSV_export cpdb_projects &
    CSV_export cpdb_projects_spending_byyear &
    wait 
    echo 
    echo "export complete"
    echo
)