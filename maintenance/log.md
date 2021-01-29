# Build Logs

## 2021/01/29 -- Molly
+ Rebuild using FISA and scraped data from 2021/01/27
+ New data for ddc and edc
+ Rebuild after fixing edc data (data previously loaded was meant to get appended to 2020/12/28 version)

## 2021/01/27 -- Molly
+ Rebuild with updated FISA data (fisa_capitalcommitments."2021/01/26")
+ Scraping for capital_spending
+ Round 2 build

## 2021/01/19 -- Molly
+ Rebuild with updated FISA data (fisa_capitalcommitments."2021/01/19")
+ Scraping for capital_spending
+ Round 2 build

## 2021/01/13 -- Molly
+ Set SRID for manual geometries

## 2021/01/12 -- Molly
+ Rebuild with bad geoms step
+ Try again with modified cleanup step

## 2020/12/31 -- Molly
+ Rebuild without bad geoms step and correcting attributes for zero coord records
+ Remove 2020 manual geoms

## 2020/12/30 -- Molly
+ Rebuild
+ Rebuild to troubleshoot cases with non-NULL geomsource and NULL geoms

## 2020/12/29 -- Molly
+ Rebuild with 2020 manual geoms -- PR #22

## 2020/12/28 -- Molly
+ Data for edc_capitalprojects is in corrected projection in recipes
+ Data for dot_project_intersections is in corrected projection in recipes

## 2020/12/23 -- Molly
+ Addresses issues #1, #4, #14, #15
+ Data for dcp_capitalprojects is fixed in recipes

## 2020/12/09 -- Baiyue
+ Incorporate a freshly scraped capital_spending table

## 2020/12/08 -- Baiyue
+ Build after re-loading fisa_capitalcommitments
+ Scraping for capital_spending

## 2020/12/08 -- Molly
+ Build after re-loading census tract data to recipes

## 2020/12/02 -- Molly
+ Kick off second round of build to incorporate latest scrape
+ Kick off a build -- baiyue

## 2020/11/30 -- Molly
+ Initial build complete
+ Kicking off scraper -- didn't successfully run until 2020/12/02 with increased timeout

## 2020/04/29 -- Baiyue
+ kicking off a new build
+ kicking off capital spending scraping process
+ kicking off new build and incorporate the latest scraping
