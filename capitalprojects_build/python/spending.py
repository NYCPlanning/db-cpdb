import xmltodict
import glob
import datetime
import sqlalchemy as sql
from sqlalchemy import create_engine
from pathlib import Path
import pandas as pd
import subprocess
import os

# connect to sql
engine = create_engine(os.environ.get('BUILD_ENGINE', ''))

# XML parser
def parse_spending(f):    
    # read in xml file
    with open(f) as fd:
        doc = xmltodict.parse(fd.read())
    # parse
    transactions = doc['response']['result_records']['spending_transactions']['transaction']
    cols = [k for k in transactions[0].keys()]
    file_transactions = pd.DataFrame()
    for t in transactions:
        new = pd.DataFrame()
        for c in cols:
            new[c] = [t[c]]
        file_transactions = pd.concat([file_transactions, new])
    return(file_transactions)

f = Path(__file__).parent.parent/'downloads/spending/spending.xml'
print('Parsing file at: ' + datetime.datetime.now().strftime('%H:%M:%S'))
df = parse_spending(f)
df.to_sql('capital_spending_old', engine, if_exists='append', index = False)
