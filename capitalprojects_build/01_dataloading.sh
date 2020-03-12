#!/bin/bash
echo "load data into BUILD_ENGINE"
docker run --rm\
            --network=host\
            -v `pwd`/python:/home/python\
            -w /home/python\
            --env-file .env\
            sptkl/cook:latest python3 dataloading.py

echo "fixing dot_bridges"
docker run --rm\
            --network=host\
            -v `pwd`/python:/home/python\
            -w /home/python\
            --env-file .env\
            sptkl/cook:latest python3 dot_bridges.py