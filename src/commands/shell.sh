#!/usr/bin/env bash

declare -A containerList
containerList=( [go]=myGolang [php]=myPhp [web]=myWeb [postgres]=myPostgres)

for key in ${!containerList[@]}; do
	if [[ "$2" == ${key} ]]; then
		start_shell ${containerList[${key}]}
		break
	fi
done
