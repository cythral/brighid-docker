#!/bin/bash

set -eo pipefail

REPOSITORY_URI=$1

docker build -t $REPOSITORY_URI:latest .

if [ "$CODEBUILD_GIT_TAG" != "" ]; then
    docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$CODEBUILD_GIT_TAG;
fi