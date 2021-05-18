from .checkbooknyc import CheckbookNYC
from .utils import psql_insert_copy
import pandas as pd
import os
from sqlalchemy import create_engine
from multiprocessing import Pool, cpu_count

BUILD_ENGINE = create_engine(os.environ.get('BUILD_ENGINE'))


def get_project_records(projectid: str):
    """
    Given projectid (maprojid) this function will 
    return a dataframe of capital spending records
    """
    search_criteria = {"capital_project_code": f"{projectid}"}
    c = CheckbookNYC(type_name="Spending", search_criteria=search_criteria)
    raw_results = c()

    if len(raw_results) == 0:
        return None

    results = []
    for r in raw_results:
        if r:
            try:
                transaction = r["response"]["result_records"]["spending_transactions"]["transaction"]
                results += transaction
            except:
                pass

    if len(results) > 0:
        df = pd.DataFrame(results, dtype=str)
        df.to_sql(
            'capital_spending',
            con=BUILD_ENGINE,
            if_exists="append",
            index=False,
            method=psql_insert_copy,
        )


def get_all_projectids():
    """
    this function will get all project ids from fisa_capitalcommitments
    """
    df = pd.read_sql("""
    SELECT 
        DISTINCT LPAD(p.managing_agcy_cd, 3, '0')||REPLACE(p.project_id,' ','') AS maprojid
    FROM fisa_capitalcommitments p
    """, con=BUILD_ENGINE)
    print(df.shape)
    return df.maprojid.to_list()


if __name__ == "__main__":
    BUILD_ENGINE.execute("""DROP TABLE IF EXISTS capital_spending;""")
    projectids = get_all_projectids()
    with Pool(cpu_count()*2) as p:
        p.map(get_project_records, projectids)
