# db-cpdb

## Instructions: 
1. Edit `capitalprojects_build/version.env` to include the latest version name. e.g. `fisa_{year}`. Also edit the `sql/projects_spending_byyear.sql` file to reflect the current year. 
2. Git add and commit with `[build]` in commit message to trigger a build. Note that this build will incorporate the previous `capital_spending` table from last build. 
3. Since the checkbook NYC script needs the latest `maprojid` to do the request, we will run the scraping process after `[build]` 
and in order to trigger a scraping process, do a git commit with `[scrape]` in the commit message
4. The scrpaing process will take about 4 ~ 5 hours, after it's done, run build again by doing a git commit with `[build]` in the commit message to in corporate the latest `capital_spending` table scraped from checkbook NYC