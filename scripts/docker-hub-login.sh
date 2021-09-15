#!/bin/bash

set -eo pipefail

CWD=$(dirname ${BASH_SOURCE[0]})

$CWD/decrypt-secret.sh DockerHubToken | docker login -u cythral --password-stdin
