#!/usr/bin/env bash

docker compose up -d

echo ""
source ${DIR}/src/commands/logo.sh start
