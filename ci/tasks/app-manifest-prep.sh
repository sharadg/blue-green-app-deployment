#!/bin/bash

set -xe

cat ./current-app-info/current-app.txt

sed "s/APPNAME/$(cat ./current-app-info/current-app.txt)-$PWS_APP_SUFFIX/" ./concourse-pipeline-samples/manifests/manifest.yml > ./app-manifest-output/manifest.yml

cat ./app-manifest-output/manifest.yml
