#!/bin/bash
source bash/config.sh

function sql {
    shift;
    psql $BUILD_ENGINE $@
}

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
        archive public.cpdb_budgets cpdb.cpdb_budgets &
        archive public.cpdb_projects_spending_byyear cpdb.cpdb_projects_spending_byyear &
        archive public.cpdb_capital_spending cpdb.cpdb_capital_spending&
        archive public.fisa_capitalcommitments cpdb.fisa_capitalcommitments&
        archive public.dot_projects_intersections cpdb.dot_projects_intersections&
        archive public.dot_projects_streets cpdb.dot_projects_streets&
        archive public.dot_projects_bridges cpdb.dot_projects_bridges&
        archive public.dpr_capitalprojects cpdb.dpr_capitalprojects&
        archive public.dpr_parksproperties cpdb.dpr_parksproperties &
        archive public.edc_capitalprojects_ferry cpdb.edc_capitalprojects_ferry&
        archive public.edc_capitalprojects cpdb.edc_capitalprojects&
        archive public.dcp_cpdb_agencyverified cpdb.dcp_cpdb_agencyverified&
        archive public.ddc_capitalprojects_infrastructure cpdb.ddc_capitalprojects_infrastructure&
        archive public.ddc_capitalprojects_publicbuildings cpdb.ddc_capitalprojects_publicbuildings&
        wait
        echo "Archive Complete"
        ;;
    *) archive $@ ;;
    esac
}

function cpdb_upload {
    local branchname=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    local DATE=$(date "+%Y-%m-%d")
    local SPACES="spaces/edm-private/db-cpdb/$branchname"
    local HASH=$(git describe --always)
    mc rm -r --force $SPACES/latest
    mc rm -r --force $SPACES/$DATE
    mc rm -r --force $SPACES/$HASH
    mc cp --attr acl=private -r output $SPACES/latest
    mc cp --attr acl=private -r output $SPACES/$DATE
    mc cp --attr acl=private -r output $SPACES/$HASH
}

function share {
    shift;
    case $1 in
        --help )
            echo
            echo "This command will generate a sharable url for a private file (Expiration 7 days)"
            echo "Usage: ./cpdb.sh share {{ branch }} {{ version }} {{ filename }}" 
            echo "e.g. : ./cpdb.sh share main latest output.zip"
            echo
        ;;
        *)
            local branch=${1:-main}
            local version=${2:-latest}
            local file=${3:-output.zip}
            mc share download spaces/edm-private/db-cpdb/$branch/$version/output/$file
        ;;
    esac
}

case $1 in 
    dataloading ) ./bash/01_dataloading.sh ;;
    attribute ) ./bash/02_build_attribute.sh ;;
    adminbounds ) ./bash/03_adminbounds.sh ;;
    analysis ) ./bash/04_analysis.sh ;;
    export ) ./bash/05_export.sh ;;
    archive ) cpdb_archive $@ ;;
    upload ) cpdb_upload ;;
    share ) share $@ ;;
    sql) sql $@;;
esac