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
        archive public.cpdb_projects_spending_byyear cpdb.cpdb_projects_spending_byyear
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