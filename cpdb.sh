#!/bin/bash
source bash/config.sh

function cpdb_archive {
    shift;
    case $1 in
    --all)
        archive public.cpdb_summarystats_magency cpdb.cpdb_summarystats_magency &
        archive public.cpdb_summarystats_sagency cpdb.cpdb_summarystats_sagency &
        archive public.projects_by_communitydist cpdb.projects_by_communitydist &
        archive public.projects_by_communitydist_spending cpdb.projects_by_communitydist_spending
        archive public.projects_by_communitydist_spending_date cpdb.projects_by_communitydist_spending_date &
        archive public.agency_validated_geoms_summary_table cpdb.agency_validated_geoms_summary_table &
        archive public.cpdb_dcpattributes_pts cpdb.cpdb_dcpattributes_pts &
        archive public.cpdb_dcpattributes_poly cpdb.cpdb_dcpattributes_poly &
        archive public.cpdb_adminbounds cpdb.cpdb_adminbounds &
        archive public.cpdb_projects_combined cpdb.cpdb_projects_combined &
        archive public.cpdb_commitments cpdb.cpdb_commitments &
        archive public.cpdb_projects cpdb.cpdb_projects &
        archive public.cpdb_projects_spending_byyear cpdb.cpdb_projects_spending_byyear
        wait
        echo "Archive Complete"
        ;;
    *) archive $@ ;;
    esac
}

case $1 in 
    dataloading ) ./bash/01_dataloading.sh ;;
    attribute ) ./bash/02_build_attribute.sh ;;
    adminbounds ) ./bash/03_adminbounds.sh ;;
    analysis ) ./bash/04_analysis.sh ;;
    archive ) cpdb_archive $@ ;;
esac