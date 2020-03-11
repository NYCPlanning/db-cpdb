-- Summary of $s commitments by budgetline by fiscal year for data extracted published on open data (used for comparative anaysis to verfy data extracted from CPDB)
SELECT budget_line,
	SUM(fy2017)*1000 AS fy2017,
	SUM(fy2018)*1000 AS fy2018,
	SUM(fy2019)*1000 AS fy2019,
	SUM(fy2020)*1000 AS fy2020,
	SUM(fy2021)*1000 AS fy2021
FROM capital_commitments_exec
GROUP BY budget_line
ORDER BY budget_line

-- Identifying the budget lines where $s over the FYs do not match between data extracted from CCP vs data published on open data
WITH mismatch AS (
SELECT a.budgetline,
	a.fy2017 AS ccp2017,
	a.fy2018 AS ccp2018,
	a.fy2019 AS ccp2019,
	a.fy2020 AS ccp2020,
	a.fy2021 AS ccp2021,
	b.budget_line,
	b.fy2017,
	b.fy2018, 
	b.fy2019, 
	b.fy2020, 
	b.fy2021
FROM budgetlinesummarycommitmentplan a
JOIN budgetlinesummaryopendata b
	ON replace(a.budgetline, '-', '') = b.budget_line
	WHERE a.fy2017<>b.fy2017 OR a.fy2018<>b.fy2018 OR a.fy2019<>b.fy2019 OR a.fy2020<>b.fy2020 OR a.fy2021<>b.fy2021
	)
SELECT COUNT(*) FROM mismatch

-- Comparing $s commitments in FYs between data extracted from CCP vs data published on open data
SELECT 
  SUM(a.fy2017) AS ccp2017,
  SUM(a.fy2018) AS ccp2018, 
  SUM(a.fy2019) AS ccp2019,
  SUM(a.fy2020) AS ccp2020,
  SUM(a.fy2021) AS ccp2021,
  SUM(a.fy2017+a.fy2018+a.fy2019+a.fy2020+a.fy2021) AS ccptotal,
  SUM(b.fy2017) AS od2017,
  SUM(b.fy2018) AS od2018,
  SUM(b.fy2019) AS od2019, 
  SUM(b.fy2020) AS od2020, 
  SUM(b.fy2021) AS od2021,
  SUM(b.fy2017+b.fy2018+b.fy2019+b.fy2020+b.fy2021) AS odtotal
FROM budgetlinesummarycommitmentplan a
JOIN budgetlinesummaryopendata b
	ON replace(a.budgetline, '-', '') = b.budget_line

	