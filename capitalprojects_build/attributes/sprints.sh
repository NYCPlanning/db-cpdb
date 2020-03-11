#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# create the sprints table
sudo -u postgres psql cpdb -c "CREATE TABLE sprints as SELECT maprojid, bbl, bin, geomsource, geom FROM dcpattributescommitments WHERE geomsource in ('AD Sprint', 'DCP Sprint');"

# backup the sprints table to sql code
sudo -u postgres pg_dump -a -O -x -t sprints --column-inserts cpdb > ./attributes/sprints.sql

# update dcp_attributestaging with geoms from sprints
sudo -u postgres psql cpdb -c "UPDATE dcp_attributestaging a SET bbl = b.bbl, bin = b.bin, geomsource = b.geomsource, geom = b.geom FROM sprints as b WHERE a.maprojid = b.maprojid;" 



# drop the sprints table to avoid cluttering psql
#sudo -u postgres psql cpdb -c "DROP TABLE sprints;"

# in sprints.sql, replace sprints (table name) with dcpattributescommitments
#sed -i 's/sprints/dcpattributescommitments/g' ./attributes/sprints.sql 

