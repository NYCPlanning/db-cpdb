from cook import Importer
import os
import pandas as pd 
from sqlalchemy import create_engine

def ETL():
    RECIPE_ENGINE = os.environ.get('RECIPE_ENGINE', '')
    BUILD_ENGINE=os.environ.get('BUILD_ENGINE', '')

    importer = Importer(RECIPE_ENGINE, BUILD_ENGINE)

    importer.import_table(schema_name='dcp_mappluto')
    importer.import_table(schema_name='dcp_facilities')
    importer.import_table(schema_name='dcp_cdboundaries')
    importer.import_table(schema_name='doitt_buildingfootprints')
    importer.import_table(schema_name='dcp_censustracts')
    importer.import_table(schema_name='dcp_congressionaldistricts')
    importer.import_table(schema_name='dcp_councildistricts')
    importer.import_table(schema_name='fdny_firecompanies')
    importer.import_table(schema_name='dcp_municipalcourtdistricts')
    importer.import_table(schema_name='nypd_policeprecincts')
    importer.import_table(schema_name='dcp_school_districts')
    importer.import_table(schema_name='dcp_stateassemblydistricts')
    importer.import_table(schema_name='dcp_statesenatedistricts')
    importer.import_table(schema_name='dcp_trafficanalysiszones')
    importer.import_table(schema_name='dpr_parksproperties')
    importer.import_table(schema_name='dpr_capitalprojects')
    importer.import_table(schema_name='dot_projects_bridges') #
    importer.import_table(schema_name='dot_projects_streets') #
    importer.import_table(schema_name='dot_projects_intersections') #
    importer.import_table(schema_name='ddc_capitalprojects_infrastructure') #
    importer.import_table(schema_name='ddc_capitalprojects_publicbuildings') #
    importer.import_table(schema_name='edc_capitalprojects') #?
    importer.import_table(schema_name='edc_capitalprojects_ferry') #?
    importer.import_table(schema_name='sca_bluebook', version='2019') 
    importer.import_table(schema_name='capital_spending') #?
    importer.import_table(schema_name='doe_lcgms', version='2019_new')
    importer.import_table(schema_name='dcp_school_districts')
    importer.import_table(schema_name='fisa_capitalcommitments') #? 
    importer.import_table(schema_name='dcp_cpdb_agencyverified')
    
def LOAD(url, name):
    # dcp_agencylookup
    con = create_engine(os.environ.get('BUILD_ENGINE', ''))
    df = pd.read_csv(url, index_col=False, dtype=str)
    df.to_sql(con=con, name=name, if_exists='replace', index=False)

if __name__ == "__main__":
    ETL()
    LOAD('https://raw.githubusercontent.com/NYCPlanning/helper_datasets/master/dcp_projecttypes_agencies.csv', 'dcp_projecttypes_agencies')
    LOAD('https://raw.githubusercontent.com/NYCPlanning/helper_datasets/master/agencylookup.csv', 'dcp_agencylookup')
    LOAD('https://edm-recipes.nyc3.digitaloceanspaces.com/random/dcp_json.csv', 'dcp_json')
    LOAD('https://edm-recipes.nyc3.digitaloceanspaces.com/random/cpdb_geomsremove.csv', 'cpdb_badgeoms')