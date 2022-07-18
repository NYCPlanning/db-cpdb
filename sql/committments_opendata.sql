DROP VIEW IF EXISTS cpdb_commitments_opendata;
CREATE TABLE cpdb_commitments_opendata AS(
    WITH summary AS (
    SELECT p.ccpversion, --p.ccpversion nesessary?
    LPAD(p.managingagency,3,'0')||p.projectid AS maprojid,
    LPAD(p.managingagency,3,'0')AS magency,
    p.projectid, 
    --PROJECT DESCRIPTION?
    p.budgetline,
    --PROJECT TYPE?, 
    p.plancommdate, 
    p.commitmentdescription, 
    p.commitmentcode,
    --TYPC (ten year plan category),
    --TYPCNAME,
    --CCNONEXEMPT,
    --CCEXEMPT,
    --TOTALCITYPLANNEDCOMMIT,
    --NCCSTATE,
    --NCCFEDERAL,
    --NCOTHER

    
    )
)