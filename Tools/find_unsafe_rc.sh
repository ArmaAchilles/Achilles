#!/bin/bash

#makes sure that cygwin commands are used on windows
if [[ "$(uname -s)" == "CYGWIN"* ]]; then
	PATH=/usr/bin:$PATH
fi

> unsafe_rc.log

cd "../@AresModAchillesExpansion/addons"
script_list=$(find . -type f -name "*.sqf")
for script in $script_list; do
	echo Searching in $script...
	keywords=($(grep remoteExec $script | grep -o -P "(?i)remoteExec(\s*|Call\s*)\[\s*[\"\']?(bis_fnc_call|bis_fnc_spawn|call|spawn)[\"\']?\s*,"))
	if [[ ${#keywords[@]} -gt 0 ]]; then
		printf "$script\r\n" >> ../../tools/unsafe_rc.log
	fi
done
