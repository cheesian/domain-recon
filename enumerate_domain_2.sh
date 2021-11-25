#!/bin/bash
: '
[ABOUT]
This script is for dns enumeration using dnsenum

[CUSTOMIZATION]
You will need to update the following variables
NUM_THREADS => This is the number of threads to run simultaneously
DELAY => This is the time interval between enumeration of different domain names
DNS => This is the dns server you want to use

[HOW TO RUN]
./enumerate_domain.sh domains/chime.domains
'
FILE_NAME=`basename "$0"`
NUM_THREADS=5
DELAY_SECS=30
MAX_SUBDOMAINS_TO_SCRAP_FROM_GOOGLE=20
DNS=1.1.1.1
INPUT_FILE_PATH=$1

if [ -z "$1" ] || [ ! -f $INPUT_FILE_PATH ]; then
	echo "Please supply a valid input filename for the file containing domain names to the script: $FILE_NAME"
	exit
else
	for domain in $(cat $INPUT_FILE_PATH)
	do
		dnsenum --dnsserver $DNS -d $DELAY_SECS --private --threads $NUM_THREADS -o $domain.results_2 -s $MAX_SUBDOMAINS_TO_SCRAP_FROM_GOOGLE $domain
	done
fi
