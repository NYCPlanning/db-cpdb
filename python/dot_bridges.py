import pandas as pd
from sqlalchemy import create_engine
import os
from utils import psql_insert_copy

# connect to postgres db
engine = create_engine(os.environ.get("BUILD_ENGINE", ""))

# helper function


def fms_parse(x):
    # case 1: comma separated fms ids
    if "," in x.fms_id:
        fms_ids = x.fms_id.split(",")
        fms_ids = [i.strip() for i in fms_ids]
        row = x.to_frame().T
        rows = x.to_frame().T
        while len(rows) < len(fms_ids):
            rows = rows.append(row)
        rows["fms_id"] = fms_ids
    # case 2: / delimited fms ids
    elif "/" in x.fms_id:
        fms_ids = x.fms_id.split("/")
        fms_ids[1:] = [fms_ids[0][0:-1] + i for i in fms_ids[1:]]
        row = x.to_frame().T
        rows = x.to_frame().T
        while len(rows) < len(fms_ids):
            rows = rows.append(row)
        rows["fms_id"] = fms_ids
    else:
        rows = x.T
    return rows


# makes selection
bridges = pd.read_sql_query(
    "SELECT * FROM dot_projects_bridges WHERE fms_id is not NULL", engine
)

# fms_id cleaning
bridges_cleaned = pd.DataFrame()
for i in range(len(bridges)):
    bridges_cleaned = bridges_cleaned.append(fms_parse(bridges.iloc[i, :]))

bridges_cleaned["ogc_fid"] = bridges_cleaned["ogc_fid"].astype("str")

# write new table to postgres
bridges_cleaned.to_sql(
    "dot_projects_bridges_byfms",
    engine,
    if_exists="replace",
    index=False,
    method=psql_insert_copy,
)
