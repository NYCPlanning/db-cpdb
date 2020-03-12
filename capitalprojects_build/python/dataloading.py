from cook import Importer
import os
import pandas as pd 
from sqlalchemy import create_engine
from multiprocessing import Pool, cpu_count

def ETL(table):
    RECIPE_ENGINE = os.environ.get('RECIPE_ENGINE', '')
    BUILD_ENGINE=os.environ.get('BUILD_ENGINE', '')
    importer = Importer(RECIPE_ENGINE, BUILD_ENGINE)
    importer.import_table(schema_name=table)
    
def LOAD(url, name):
    # dcp_agencylookup
    con = create_engine(os.environ.get('BUILD_ENGINE', ''))
    df = pd.read_csv(url, index_col=False, dtype=str)
    df.to_sql(con=con, name=name, if_exists='replace', index=False)

tables = ['dcp_stateassemblydistricts',
        'dcp_censustracts',
        'fisa_capitalcommitments',
        'dot_projects_intersections',
        'dcp_facilities',
        'fdny_firecompanies',
        'dcp_municipalcourtdistricts',
        'doitt_buildingfootprints',
        'dpr_parksproperties',
        'dcp_congressionaldistricts',
        'edc_capitalprojects_ferry',
        'ddc_capitalprojects_infrastructure',
        'ddc_capitalprojects_publicbuildings',
        'nypd_policeprecincts',
        'dcp_cdboundaries',
        'dcp_cpdb_agencyverified',
        'dot_projects_streets',
        'dcp_statesenatedistricts',
        'dcp_mappluto',
        'dcp_school_districts',
        'dpr_capitalprojects',
        'edc_capitalprojects',
        'dot_projects_bridges',
        'dcp_trafficanalysiszones',
        'capital_spending',
        'dcp_councildistricts']

if __name__ == "__main__":
    with Pool(processes=cpu_count()) as pool:
        pool.map(ETL, tables)

    LOAD('https://raw.githubusercontent.com/NYCPlanning/helper_datasets/master/dcp_projecttypes_agencies.csv', 'dcp_projecttypes_agencies')
    LOAD('https://raw.githubusercontent.com/NYCPlanning/helper_datasets/master/agencylookup.csv', 'dcp_agencylookup')
    LOAD('https://edm-recipes.nyc3.digitaloceanspaces.com/random/dcp_json.csv', 'dcp_json')
    LOAD('https://edm-recipes.nyc3.digitaloceanspaces.com/random/cpdb_geomsremove.csv', 'cpdb_badgeoms')
    LOAD('https://raw.githubusercontent.com/NYCPlanning/db-cpdb/master/capitalprojects_build/data/id_bin_map.csv', 'dcp_id_bin_map')