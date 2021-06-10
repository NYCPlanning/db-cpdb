# db-cpdb

![capital spending](https://github.com/NYCPlanning/db-cpdb/workflows/capital%20spending/badge.svg) ![CI test](https://github.com/NYCPlanning/db-cpdb/workflows/CI%20test/badge.svg)

## Instructions

1. All the relavent commands for running cpdb is wrapped in the cli bash script `./cpdb.sh`, please read the file for more details.
2. The capital spending scraping process should be done right after we load `fisa_capitalcommitments` to data library. A seperate bash script will import  `fisa_capitalcommitments` to bigquery and we will create export the capital spending table `cpdb_capital_spending` via a bigquery command (see `bash/11_spending.sh` for more details)

> Note that this process is triggered via workflow dispatch

3. Make sure to edit the `version.env` file to reflect the current fiscal year.

> Note that a cpdb build is triggered by a push event to the repo. The output files will be stored in subfolders named after branches.

4. Since cpdb is still a private database. You can generate a pre-signed sharable link using the `./cpdb.sh share` command. Run `./cpdb.sh share --help` to see instructions.

> Note: the url will only be valid for 7 days.
