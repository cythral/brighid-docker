#!/bin/sh

set -eo pipefail

wget $MIGRATIONS_BUNDLE_URL -O ./run-migrations
chmod +x ./run-migrations

export Database__Password=$(decrs $Encrypted__Database__Password) || exit 1
./run-migrations