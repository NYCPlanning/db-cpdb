import pandas as pd
import numpy as np
import os
import re
import sqlalchemy as sql
from sqlalchemy import create_engine
from geosupport import Geosupport, GeosupportError
from multiprocessing import Pool, cpu_count
import usaddress

g = Geosupport()

# connect to postgres db
engine = create_engine(os.environ.get("BUILD_ENGINE", ""))

# read in dcp_cpdb_agencyverified table
dcp_cpdb_agencyverified = pd.read_sql_query(
    "SELECT address, borough, maprojid FROM dcp_cpdb_agencyverified WHERE geom IS NULL AND address IS NOT NULL AND borough IS NOT NULL;",
    engine,
)


def quick_clean(address):
    address = (
        "-".join([i.strip() for i in address.split("-")]) if address is not None else ""
    )
    result = [
        k
        for (k, v) in usaddress.parse(address)
        if not v in ["OccupancyIdentifier", "OccupancyType"]
    ]
    return re.sub(r"[,\%\$\#\@\!\_\.\?\`\"\(\)]", "", " ".join(result))


def get_hnum(address):
    result = (
        [k for (k, v) in usaddress.parse(address) if re.search("Address", v)]
        if address is not None
        else ""
    )
    return " ".join(result)


def get_sname(address):
    result = (
        [k for (k, v) in usaddress.parse(address) if re.search("Street", v)]
        if address is not None
        else ""
    )
    return " ".join(result)


# get the geo data
def geocode(inputs):
    address = inputs.pop("address")
    borough = inputs.pop("borough")
    maprojid = inputs.pop("maprojid")

    address = quick_clean(address)
    hnum = get_hnum(address)
    sname = get_sname(address)

    if "/" in borough:
        borough = borough.split("/")[0].strip()
    try:
        geo = g["1b"](house_number=hnum, street_name=sname, borough=borough)
        geo = parse_output(geo)
    except GeosupportError as e:
        geo = parse_output(e.result)
    geo.update(dict(maprojid=maprojid))
    return geo


def parse_output(geo):
    return dict(
        bin=geo.get(
            "Building Identification Number (BIN) of Input Address or NAP", np.nan
        ),
        lat=geo.get("Latitude", np.nan),
        lon=geo.get("Longitude", np.nan),
    )


records = dcp_cpdb_agencyverified.to_dict("records")

locs = []
for i in records:
    try:
        locs.append(geocode(i))
    except:
        print(i)
locs = pd.DataFrame(locs).replace("", np.nan)
# # update the dcp_cpdb_agencyverified geom based on bin
locs.to_sql("dcp_cpdb_agencyverified_geo", con=engine, if_exists="replace")
