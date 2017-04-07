#!/bin/bash

script="$0"
FOLDER="$(pwd)/$(dirname $script)"

source $FOLDER/utils.sh
PROJECT_ROOT="$(abspath $FOLDER/..)"
echo "project root folder $PROJECT_ROOT"

echo "build docker image"
/bin/bash $FOLDER/build.sh

##### CONFIG #####

TEMPLATE_DIR=$PROJECT_ROOT/templates
OUTPUT_DIR=$PROJECT_ROOT/outputs

##### RUN #####
echo "Starting container..."

docker run --rm \
           -it \
           -v $OUTPUT_DIR:/out \
           -v $TEMPLATE_DIR:/data \
           -e TEMPLATE=test.json.j2 \
         	 -e OUT_FILE=/out/test.json \
           dominicbreuker/jinja_docker:latest message='welt'
