#!/bin/bash

set -eo pipefail

SECRET=$1
SECRET_VALUE=$(cat pipeline-secrets.json | jq -r ".$SECRET")

tempFile=$(mktemp)
echo $SECRET_VALUE | base64 --decode > $tempFile
aws kms decrypt --ciphertext-blob fileb://$tempFile --output text --query Plaintext | base64 --decode
rm $tempFile