-- create summary tables for planned commitments ($) by geography 
-- and exlude projects based on criteria in fy18_27_typc_allocations_exclusions

SELECT borocd, SUM(amt) --relace borocd with coundist for council district level analysis
FROM adoyle.planned_commitments_by_proj_budget_typc_communitydist
--remove WHERE clause if you do not want to exclude projects
WHERE REPLACE(typc||budget_proj_type, ' ','')
IN (SELECT DISTINCT REPLACE(typ_category||project_type, ' ','') AS typ_project 
FROM adoyle.fy18_27_typc_allocations_exclusions b --this table is in Carto
WHERE include_in_cpdb_analytics = 'Yes' )
GROUP BY borocd