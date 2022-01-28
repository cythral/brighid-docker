#!/bin/sh

set -eo pipefail

wget $MIGRATIONS_BUNDLE_URL -O ./run-migrations
chmod +x ./run-migrations

Database__Password=$(decrs $ENCRYPTED_DATABASE_PASSWORD) || exit 1
./run-migrations