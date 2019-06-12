#!/bin/bash

set -e

echo "Installing artillery for load tests: https://artillery.io/docs/getting-started/"

npm install -g artillery@"1.6.0-24"

export APP_URL=http://$APP_VERSION-$PWS_APP_SUFFIX.$PWS_APP_DOMAIN/

echo "Running artillery load tests..."

artillery quick --duration 10 --rate 10 $APP_URL
