#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

docker run --rm\
    -v $(pwd):/developments_build\
    -w /developments_build\
    -e BUILD_ENGINE=$BUILD_ENGINE\
    sptkl/docker-geosupport:latest bash -c "
      python3 attributes_geom_agencyverified_geocode.py"