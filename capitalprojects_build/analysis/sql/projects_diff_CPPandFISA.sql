--projects that are in FISA data and not in scrapped CPP
COPY(
SELECT DISTINCT LPAD(managing_agcy_cd, 3, '0')||REPLACE(project_id, ' ', '') as maprojid,
	short_descr as description,
	SUM(fcst_cnx_amt+fcst_cex_amt+fcst_st_amt+fcst_fd_amt+fcst_pv_amt) as totalplannedcommitment
FROM fisa_capitalcommitments
WHERE LPAD(managing_agcy_cd, 3, '0')||REPLACE(project_id, ' ', '') NOT IN (
	SELECT DISTINCT maprojid FROM cpdb_dcpattributes WHERE ccpversion = '2017_Apr')
GROUP BY LPAD(managing_agcy_cd, 3, '0'),REPLACE(project_id, ' ', ''), short_descr
)TO '/tmp/projects_inFISA_notCPP.csv' DELIMITER ',' CSV HEADER;

--projects that are in scrapped CPP data and not in FISA data
COPY(
SELECT maprojid,
description, 
totalcost
FROM cpdb_projects
WHERE ccpversion = '2017_Apr' AND maprojid NOT IN (
SELECT DISTINCT LPAD(managing_agcy_cd, 3, '0')||REPLACE(project_id, ' ', '')
FROM fisa_capitalcommitments)
)TO '/tmp/projects_inCPP_notFISA.csv' DELIMITER ',' CSV HEADER;