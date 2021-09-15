#!/bin/bash

set -eo pipefail

REPOSITORY_URI=$1

if [ "$CODEBUILD_GIT_TAG" != "" ]; then
    docker push $REPOSITORY_URI:latest;
    docker push $REPOSITORY_URI:$CODEBUILD_GIT_TAG;
fi