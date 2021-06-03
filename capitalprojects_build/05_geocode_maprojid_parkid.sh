#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
source $CURRENT_DIR/config.sh

docker run --rm\
    -v $(pwd)/python:/home/python\
    -w /home/python\
    -e BUILD_ENGINE=$BUILD_ENGINE\
    -e RECIPE_ENGINE=$RECIPE_ENGINE\
    nycplanning/cook:latest bash -c "
      python3 attributes_maprojid_parkid.py"