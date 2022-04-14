---
name: Update
about: Master issue for CPDB releases
title: "{Version} CPDB Update"
labels: ''
assignees: ''

---

# Update source data
Read more about how to update a specific dataset (here)[https://github.com/NYCPlanning/db-cpdb/wiki/Maintenance]
## Received from agency partner and manually loaded into data libraries
-[ ] Capital Commitment Plan: fisa_capitalcommitments
-[ ] ddc_capitalprojects_infrastructure
-[ ] ddc_capitalprojects_publicbuildings
-[ ] dot_projects_bridges
-[ ] edc_capitalprojects - new data needs to be appended onto existing source dataset
-[ ] edc_capitalprojects_ferry - new data is often not received and this dataset is not updated with each release because nothing has changed.

## Automatically loaded into data libraries

# Projects
-[ ] (cpdb_capital_spending)[https://github.com/NYCPlanning/db-cpdb/actions/workflows/spending.yml] - updated with action
-[ ] dot_projects_intersections
-[ ] dot_projects_streets
-[ ] dpr_capitalprojects
-[ ] dpr_parksproperties
-[ ] dcp_cpdb_agencyverified (does not get updated)

# Building and lot-level info
-[ ] dcp_mappluto
-[ ] dcp_facilities
-[ ] doitt_buildingfootprints

# Spatial boundaries
Come from (Geosupport update)[https://github.com/NYCPlanning/db-data-library/actions/workflows/quaterly-updates.yml]
-[ ] dcp_stateassemblydistricts
-[ ] dcp_ct2020
-[ ] dcp_congressionaldistricts
-[ ] dcp_cdboundaries
-[ ] dcp_statesenatedistricts
-[ ] dcp_municipalcourtdistricts
-[ ] dcp_school_districts
-[ ] dcp_trafficanalysiszones
-[ ] dcp_councildistricts
-[ ] nypd_policeprecincts
-[ ] fdny_firecompanies
