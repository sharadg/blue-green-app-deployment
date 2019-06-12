#!/bin/bash

set -xe

cd concourse-pipeline-samples/bgd-app
npm install
mocha tests --recursive
