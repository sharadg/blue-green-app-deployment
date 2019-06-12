#!/bin/bash

set -xe

pwd
env

cf api $PWS_API --skip-ssl-validation

cf login -u $PWS_USER -p $PWS_PWD -o "$PWS_ORG" -s "$PWS_SPACE"

cf apps

set +e
cf apps | grep "main-$PWS_APP_SUFFIX" | grep "$APP_VERSION"
echo "$APP_VERSION" > ./current-app-info/current-app.txt
set -xe

echo "Main application route points to app instance $(cat ./current-app-info/current-app.txt)"
