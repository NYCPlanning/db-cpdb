#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

docker run --rm\
    -v $(pwd)/python:/home/python\
    -w /home/python\
    -e BUILD_ENGINE=$BUILD_ENGINE\
    nycplanning/docker-geosupport:latest bash -c "
      python3 attributes_geom_agencyverified_geocode.py"