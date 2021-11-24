#!/bin/bash

: '
[ABOUT]
This script takes as input a file containing various domains
The script uses sublist3r, hence it requires you to have cloned the following github repository
https://github.com/aboul3la/Sublist3r.git
The script runs sublist3r on all domains to discover sub-domains

[CUSTOMIZATION]
You will need to update the following variables
SUBLIST3R_PATH => This should match the path to sublist3r.py which is inside your cloned repository from the link in the [ABOUT] section
SLEEP_DURATION => [OPTIONAL] This is the time interval between enumeration of the domains in the file you provided

[HOW TO RUN]
./sublist3r.sh file_containing_domain_names

'

FILENAME="sublist3r.sh"
SUBLIST3R_PATH="$HOME/Documents/CcHub/recon/Sublist3r/sublist3r.py"
SLEEP_DURATION=30

if [ ! -f $SUBLIST3R_PATH ]; then
	echo "Please update the SUBLIST3R_PATH variable in $FILENAME to match the path to your sublist3r.py"
	exit
fi

if [ -z "$1" ] && [ -f $1 ]; then
	echo "Please supply the name of the file containing domains"
	exit
else
	for domain in $(head -n 5 $1)
	do
		python3 $SUBLIST3R_PATH -d $domain | tee $domain.results
		echo "Output for $domain has been stored in $domain.results"
		echo "Sleeping for $SLEEP_DURATION seconds before continuing. You can change the SLEEP_DURATION variable in $FILENAME to reduce this interval"
		sleep $SLEEP_DURATION
	done
fi
