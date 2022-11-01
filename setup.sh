#!/bin/bash

export PSQLPASS=postgres
export PSQLUSER=postgres
export PSQLDB=alices_rabbit_dev

project_dir=$(pwd)

echo "Make sure user is in the correct directory"
cd $project_dir
docker-compose up -d --build

