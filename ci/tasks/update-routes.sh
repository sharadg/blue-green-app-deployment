#!/bin/bash

set -xe

pwd
env

cf api $PWS_API --skip-ssl-validation

cf login -u $PWS_USER -p $PWS_PWD -o "$PWS_ORG" -s "$PWS_SPACE"

cf apps

cf routes

export PWS_DOMAIN_NAME=$PWS_APP_DOMAIN
export MAIN_ROUTE_HOSTNAME=$PWS_APP_SUFFIX

export NEXT_APP_HOSTNAME=$SWITCH_TO_APP_VERSION-$PWS_APP_SUFFIX
export CURRENT_APP_HOSTNAME=$SWITCH_FROM_APP_VERSION-$PWS_APP_SUFFIX

echo "Mapping main app route to point to $NEXT_APP_HOSTNAME instance"
cf map-route $NEXT_APP_HOSTNAME $PWS_DOMAIN_NAME --hostname $MAIN_ROUTE_HOSTNAME

cf routes

echo "Removing previous main app route that pointed to $CURRENT_APP_HOSTNAME instance"

set +e
cf unmap-route $CURRENT_APP_HOSTNAME $PWS_DOMAIN_NAME --hostname $MAIN_ROUTE_HOSTNAME
set -e

echo "Routes updated"

cf routes
