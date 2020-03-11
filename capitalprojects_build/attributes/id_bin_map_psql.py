from sqlalchemy import create_engine
import pandas as pd
import subprocess
import os
import json

# connect to postgres db
engine = create_engine(os.environ.get('BUILD_ENGINE', ''))

# read in data from csv
bb = pd.read_csv('id_bin_map.csv')

# push to psql
bb.to_sql('dcp_id_bin_map', engine, if_exists='replace', index=False)
