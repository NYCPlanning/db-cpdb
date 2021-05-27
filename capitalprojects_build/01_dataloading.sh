#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
source $CURRENT_DIR/config.sh
max_bg_procs 5

# Spatial boundaries
import_public dcp_stateassemblydistricts &
import_public dcp_censustracts &
import_public dcp_congressionaldistricts &
import_public dcp_cdboundaries &
import_public dcp_statesenatedistricts &
import_public dcp_municipalcourtdistricts &
import_public dcp_school_districts &
import_public dcp_trafficanalysiszones &
import_public dcp_councildistricts &
import_public nypd_policeprecincts &
import_public fdny_firecompanies &

# Building and lot-level info
import_public dcp_mappluto &
import_public dcp_facilities &
import_public doitt_buildingfootprints &

# Projects
import_public capital_spending &
import_public fisa_capitalcommitments &
import_public dot_projects_intersections &
import_public dot_projects_streets &
import_public dot_projects_bridges &
import_public dpr_capitalprojects &
import_public dpr_parksproperties &
import_public edc_capitalprojects_ferry &
import_public edc_capitalprojects &
import_public dcp_cpdb_agencyverified &
import_public ddc_capitalprojects_infrastructure &
import_public ddc_capitalprojects_publicbuildings &

wait

echo "fixing dot_bridges"
docker run --rm\
    -v $(pwd)/python:/home/python\
    -w /home/python\
    -e BUILD_ENGINE=$BUILD_ENGINE\
    -e RECIPE_ENGINE=$RECIPE_ENGINE\
    nycplanning/cook:latest python3 dot_bridges.py