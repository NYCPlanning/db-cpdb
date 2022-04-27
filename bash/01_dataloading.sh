#!/bin/bash
source bash/config.sh

# Reference tables
psql $BUILD_ENGINE -f sql/_create.sql

# Spatial boundaries
import dcp_stateassemblydistricts &
import dcp_ct2020 &
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
import cpdb_capital_spending &
import fisa_capitalcommitments &
import dot_projects_intersections &
import dot_projects_streets &
import dot_projects_bridges &
import dpr_capitalprojects &
import dpr_parksproperties &
import edc_capitalprojects_ferry &
import edc_capitalprojects &
import ddc_capitalprojects_infrastructure &
import ddc_capitalprojects_publicbuildings &
wait

echo "fixing dot_bridges"
psql $BUILD_ENGINE -c "ALTER TABLE dot_projects_bridges RENAME COLUMN fmsid TO fms_id;"
psql $BUILD_ENGINE -c "DROP TABLE IF EXISTS capital_spending;"
psql $BUILD_ENGINE -c "ALTER TABLE cpdb_capital_spending RENAME TO capital_spending;"
python3 python/dot_bridges.py