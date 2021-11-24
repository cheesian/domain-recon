#!/bin/bash

: '
[ABOUT]
This script requires that you have a folder containing files with domain names to be enumerated.
It iterates through all the files in the directory while enumerating each of the domains in the files

[CUSTOMIZATION]
You will need to update the following variables
DOMAINS_FOLDER => This should point to the directory which contains files with domain names to be enumerated
SUBLIST3R_SCRIPT_PATH => This should point to the sublist3r.sh file

[HOW TO RUN]
./sublist3r_enumerate_all_domains.sh
'

FILENAME="sublist3r_enumerate_all_domains.sh"
DOMAINS_FOLDER="./domains"
SUBLIST3R_SCRIPT_PATH="./sublist3r.sh"

if [ ! -f $SUBLIST3R_SCRIPT_PATH ]; then
	echo "Please update the SUBLIST3R_SCRIPT_PATH variable in $FILENAME to match the path containing your sublist3r.sh"
	exit
fi

if [ -d $DOMAINS_FOLDER ]; then
	for file in $(ls $DOMAINS_FOLDER)
	do
		 $SUBLIST3R_SCRIPT_PATH $DOMAINS_FOLDER/$file
	done
else
	echo "Please update the DOMAINS_FOLDER variable in $FILENAME to match the path containing your domain files"
	exit
fi
