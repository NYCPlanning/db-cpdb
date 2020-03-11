#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

echo 'Starting to generate reports'
# Summary table by managing and sponsor agency
echo 'Creating summary tables by managing and sponsor agency'
psql $BUILD_ENGINE -f analysis/sql/projects_dollars_mapped_categorized_managing.sql
psql $BUILD_ENGINE -c "\copy cpdb_summarystats_magency TO stdout DELIMITER ',' CSV HEADER;" > analysis/output/cpdb_summarystats_magency.csv

psql $BUILD_ENGINE -f analysis/sql/projects_dollars_mapped_categorized_sponsor.sql
psql $BUILD_ENGINE -c "\copy cpdb_summarystats_sagency TO stdout DELIMITER ',' CSV HEADER;" > analysis/output/cpdb_summarystats_sagency.csv

# Planned commitments by community district
echo 'Creating reports by community district'
psql $BUILD_ENGINE -f analysis/sql/projects_by_communitydist.sql
psql $BUILD_ENGINE -c "\copy projects_by_communitydist TO stdout DELIMITER ',' CSV HEADER;" > analysis/output/projects_by_communitydistrict_commitments.csv

psql $BUILD_ENGINE -f analysis/sql/projects_by_communitydist_spending.sql
psql $BUILD_ENGINE -c "\copy projects_by_communitydist_spending TO stdout DELIMITER ',' CSV HEADER;" > analysis/output/projects_by_communitydistrict_spending.csv

psql $BUILD_ENGINE -f analysis/sql/projects_by_communitydist_spending_date.sql
psql $BUILD_ENGINE -c "\copy projects_by_communitydist_spending_date TO stdout DELIMITER ',' CSV HEADER;" > analysis/output/projects_by_communitydistrict_spending_2014.csv
# # Agency validated geoms summary table
echo 'Creating agency validated geoms summary table'
psql $BUILD_ENGINE -f analysis/sql/agency_validated_geoms_summary_table.sql
psql $BUILD_ENGINE -c "\copy agency_validated_geoms_summary_table TO stdout DELIMITER ',' CSV HEADER;" > analysis/output/agency_validated_geoms_summary_table.csv