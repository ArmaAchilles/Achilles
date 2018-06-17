#!/bin/bash

> list_unsafe_remote_exec.log
logFolder="$PWD"

cd "../../@AresModAchillesExpansion/addons"
script_list=$(find . -type f -name "*.sqf" -printf '%p;')
IFS=$';'
for script in $script_list; do
	echo Searching in $script...
	keywords=($(grep remoteExec "$script" | grep -o -P "(?i)remoteExec(\s*|Call\s*)\[\s*[\"\']?(bis_fnc_call|bis_fnc_spawn|call|spawn)[\"\']?\s*,"))
	if [[ ${#keywords[@]} -gt 0 ]]; then
		printf "$script\r\n" >> "$logFolder/list_unsafe_remote_exec.log"
	fi
done
