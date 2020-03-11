#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi
docker run --rm\
        --network=host\
        -v `pwd`/python:/home/python\
        -w /home/python\
        --env-file .env\
        sptkl/docker-geosupport:latest bash -c "python3 attributes_geom_agencyverified_geocode.py"