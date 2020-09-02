#!/bin/bash

# NOTE: Assumes your work dir is inside the directory where your source code lives.
# NOTE: 'docker run -v ...' will create the dir on the host if it doesn't exist
# NOTE: $1 should be a param passed to the script from CLI that contains the path to a dataset.

# if [ $# -eq 0 ]
#   then
#     echo "ERROR: No argument supplied for path to data to mount as readonly"
#     exit 1
# fi

# docker run -it --rm --gpus all -v $(pwd):/src -v $1:/data:ro --user $(id -u):$(id -g) sg2:1.0 bash
docker run -it --rm --gpus all -v $(pwd):/src --user $(id -u):$(id -g) sg2:1.0 bash
