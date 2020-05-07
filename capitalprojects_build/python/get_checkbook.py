from checkbook_nyc import checkbook_nyc
from helper import psycopg2_connect
import sqlalchemy as sql
from sqlalchemy import create_engine
from multiprocessing import Pool, cpu_count
from pathlib import Path
import pandas as pd
import os
import io
import psycopg2
from datetime import datetime

# connect to sql
engine = create_engine(os.environ.get("BUILD_ENGINE"))
recipe = create_engine(os.environ.get("RECIPE_ENGINE"))

engine.execute(
    """
DROP TABLE IF EXISTS capital_spending;
CREATE TABLE capital_spending (
    agency text,
    associated_prime_vendor text,
    capital_project text,
    "contract_ID" text,
    contract_purpose text,
    check_amount text,
    department text,
    document_id text,
    expense_category text,
    fiscal_year text,
    industry text,
    issue_date text,
    mwbe_category text,
    payee_name text,
    spending_category text,
    sub_contract_reference_id text,
    sub_vendor text
);
"""
)


def get_records(input):
    maprojid = input.get("maprojid", "")
    try:
        search_criteria = {
            "Spending": {
                "fiscal_year": "",
                "payee_name": "",
                "payee_code": "",
                "document_id": "",
                "agency_code": "",
                "department_code": "",
                "expense_category": "",
                "contract_id": "",
                "capital_project_code": f"{maprojid}",
                "spending_category": "",
                "budget_name": "",
                "commodity_line": "",
                "entity_contract_number": "",
                "other_government_entities_code": "",
                "mwbe_category": "",
                "industry_type_id": "",
                "issue_date": [],
                "check_amount": [],
            }
        }
        checkbook_nyc_api = checkbook_nyc(
            search_criteria=search_criteria, type_name="Spending"
        )
        result = checkbook_nyc_api.formatted_data()
        db_connection = psycopg2_connect(engine.url)
        db_cursor = db_connection.cursor()
        str_buffer = io.StringIO()

        if result.shape[0] == 0:
            pass
        else:
            result.to_csv(str_buffer, sep="|", header=False, index=False)
            str_buffer.seek(0)
            db_cursor.copy_from(str_buffer, "capital_spending", sep="|", null="")
            db_cursor.connection.commit()
            print("copied")
            str_buffer.close()
            db_cursor.close()
            db_connection.close()
    except:
        print(maprojid)


df = pd.read_sql("select distinct maprojid from cpdb_projects", con=engine)
records = df.to_dict("records")

# get data
with Pool(processes=cpu_count()) as pool:
    pool.map(get_records, records, 1000)

# export to recipe engine
df = pd.read_sql("SELECT * FROM capital_spending", con=engine)
recipe.execute(
    """
CREATE SCHEMA IF NOT EXISTS capital_spending;
DROP TABLE IF EXISTS capital_spending.latest;
CREATE TABLE capital_spending.latest (
    agency text,
    associated_prime_vendor text,
    capital_project text,
    "contract_ID" text,
    contract_purpose text,
    check_amount text,
    department text,
    document_id text,
    expense_category text,
    fiscal_year text,
    industry text,
    issue_date text,
    mwbe_category text,
    payee_name text,
    spending_category text,
    sub_contract_reference_id text,
    sub_vendor text
);
"""
)

db_connection = psycopg2_connect(recipe.url)
db_cursor = db_connection.cursor()
str_buffer = io.StringIO()
df.to_csv(str_buffer, sep="|", header=False, index=False)
str_buffer.seek(0)
db_cursor.copy_from(str_buffer, "capital_spending.latest", sep="|", null="")
db_cursor.connection.commit()
str_buffer.close()
db_cursor.close()
db_connection.close()

version = datetime.today().strftime("%Y/%m/%d")
recipe.execute(
    f"""
DROP TABLE IF EXISTS capital_spending."{version}";
CREATE TABLE capital_spending."{version}" as (
   SELECT * FROM capital_spending.latest
);
"""
)
