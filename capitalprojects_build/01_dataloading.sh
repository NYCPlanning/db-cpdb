#!/bin/bash
echo "load data into BUILD_ENGINE"
docker run --rm\
    -v $(pwd)/python:/home/python\
    -w /home/python\
    -e BUILD_ENGINE=$BUILD_ENGINE\
    -e RECIPE_ENGINE=$RECIPE_ENGINE\
    nycplanning/cook:latest python3 dataloading.py

echo "fixing dot_bridges"
docker run --rm\
    -v $(pwd)/python:/home/python\
    -w /home/python\
    -e BUILD_ENGINE=$BUILD_ENGINE\
    -e RECIPE_ENGINE=$RECIPE_ENGINE\
    nycplanning/cook:latest python3 dot_bridges.py