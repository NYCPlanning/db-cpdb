#!/bin/bash
source config.sh

## Import fisa_capitalcommitments to database
import_private fisa_capitalcommitments

# ## Install python dependencies
python3 -m pip install -r python/requirements.txt

## Run Capital Projects Scrape
python3 -m python.capital_spending

## Output Table and Archive tp Data Library
mkdir -p .output && (
    cd .output
    CSV_export capital_spending
)