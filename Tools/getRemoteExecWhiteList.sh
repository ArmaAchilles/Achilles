#!/bin/bash

#white list file name
whitelist_file=cfgRemoteExec.hpp

#makes sure that cygwin commands are used on windows
if [[ "$(uname -s)" == "CYGWIN"* ]]; then
	PATH=/usr/bin:$PATH
fi

cd "../@AresModAchillesExpansion/addons"
script_list=$(find . -type f -name "*.sqf")
for script in $script_list; do
	echo Searching in $script...
	#extract keyword from remoteExec(Call) commands
	keywords=$(grep remoteExec $script | grep -o -P "remoteExec(\s*|Call\s*)\[\s*[\"\']?[0-9a-zA-Z_]*[\"\']?\s*," | grep -o -P "\[\s*[\"\']?[0-9a-zA-Z_]*[\"\']?\s*,")
	# remove quotation marks and change to lower case
	keywords=${keywords//\"/}
	keywords=${keywords//\'/}
	keywords=${keywords,,}
	for keyword in $keywords; do
		keyword=${keyword:1:-1}
		keyword=${keyword// /}
		if [[ $keyword == *"_fnc_"* ]]; then
			if [[ $fnc_list != *"$keyword"* ]]; then
				fnc_list+="$keyword "
			fi
		else
			if [[ $cmd_list != *"$keyword"* ]]; then
				cmd_list+="$keyword "
			fi
		fi
	done
done

#custom variable subsitution
cmd_list=${cmd_list/"_chat_type"/"globalChat vehicleChat commandChat"}

#print cfgRemotExec in keys folder
cd ../keys
printf "class cfgRemoteExec\n{\n\tclass Functions\n\t{\n\t\tmode = 1;\n\t\tjip = 1;\n\n" > $whitelist_file
for fnc in $fnc_list; do
	printf "\t\tclass $fnc;\n" >> $whitelist_file
done
printf "\t};\n\tclass Commands\n\t{\n\t\tmode = 1;\n\t\tjip = 1;\n\n" >> $whitelist_file
for cmd in $cmd_list; do
	printf "\t\tclass $cmd;\n" >> $whitelist_file
done
printf "\t};\n};" >> $whitelist_file
echo Printing $whitelist_file completed!
cd ../../tools