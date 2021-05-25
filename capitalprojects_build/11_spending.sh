#!/bin/bash
source config.sh

# Import fisa_capitalcommitments to database
version=$(get_version fisa_capitalcommitments)
location=US

function import {
    echo "version: $version"
    import_private fisa_capitalcommitments $version
}

# Loading the latest fisa_capitalcommitments to bigquery
function fisa {
    mkdir -p .output && (
        cd .output
        local dataset=fisa_capitalcommitments
        local tablename=$dataset.$version
        echo "$dataset"
        CSV_export $dataset
        bq mk \
            --location=$location\
            --dataset $dataset
        bq mk $tablename
        bq load \
            --location=$location\
            --autodetect\
            --skip_leading_rows 1\
            --replace\
            $tablename ./$dataset.csv
    )
    echo 
    echo "Creating table $tablename complete"
    echo 
}
# Get Capital Spending based the latest fisa_capitalcommitments
function calculate {
    local dataset=cpdb_capital_spending
    local tablename=$dataset.$version
    mkdir -p .output && (
        cd .output
        bq mk \
            --location=$location\
            --dataset $dataset
        bq query\
            --location=$location\
            --replace\
            --destination_table $tablename \
            --use_legacy_sql=false "
            SELECT * FROM \`checkbooknyc_capital_spending.*\` 
            WHERE CAST(TRIM(LEFT(capital_project,12)) AS STRING) IN (
                SELECT LPAD(CAST(managing_agcy_cd AS STRING), 3, '0')||REPLACE(project_id,' ','')
                FROM \`fisa_capitalcommitments.$version\`);"
    )
    echo 
    echo "Creating table $tablename complete"
    echo 
}

function export_data {
    local dataset=cpdb_capital_spending
    local tablename=$dataset.$version
    mkdir -p .output && (
        cd .output
        bq extract \
            --location=$location\
            --destination_format CSV \
            --field_delimiter ',' \
            --print_header \
            $tablename gs://edm-temporary/$dataset/$version/$dataset.csv
        gsutil cp gs://edm-temporary/$dataset/$version/$dataset.csv .
    )
    echo 
    echo "export complete"
    echo 
}

function all {
    import
    fisa
    calculate
    export_data
}

# Execution of All commands:
case $1 in 
    import | fiss | calculate | export_data) $1;;
    *) all;;
esac