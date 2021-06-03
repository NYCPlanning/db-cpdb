#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
source $CURRENT_DIR/config.sh
max_bg_procs 5

# Spatial boundaries
import dcp_stateassemblydistricts &
import dcp_censustracts &
import dcp_congressionaldistricts &
import dcp_cdboundaries &
import dcp_statesenatedistricts &
import dcp_municipalcourtdistricts &
import dcp_school_districts &
import dcp_trafficanalysiszones &
import dcp_councildistricts &
import nypd_policeprecincts &
import fdny_firecompanies &

# Building and lot-level info
import dcp_mappluto &
import dcp_facilities &
import doitt_buildingfootprints &

# Projects
import capital_spending &
import fisa_capitalcommitments &
import dot_projects_intersections &
import dot_projects_streets &
import dot_projects_bridges &
import dpr_capitalprojects &
import dpr_parksproperties &
import edc_capitalprojects_ferry &
import edc_capitalprojects &
import dcp_cpdb_agencyverified &
import ddc_capitalprojects_infrastructure &
import ddc_capitalprojects_publicbuildings &

wait

echo "fixing dot_bridges"
docker run --rm\
    -v $(pwd)/python:/home/python\
    -w /home/python\
    -e BUILD_ENGINE=$BUILD_ENGINE\
    -e RECIPE_ENGINE=$RECIPE_ENGINE\
    nycplanning/cook:latest python3 dot_bridges.py