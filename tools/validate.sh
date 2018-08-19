#!/bin/bash
success=0
python3 travis/sqf_validator.py
success=$(($success | $?))
python3 travis/config_style_checker.py
success=$(($success | $?))
sqflint -d ../@AresModAchillesExpansion/addons
success=$(($success | $?))

if [ -t 1 ]; then
	RED="\033[0;31m"
	GREEN="\033[0;32m"
	NC="\033[0m"
fi

if [ $success -eq 0 ]; then
	printf "\n${GREEN}Validation was successful${NC}\n"
else
	printf "\n${RED}Validation failed${NC}\n"
fi
