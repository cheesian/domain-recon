#!/bin/bash
: '
[ABOUT]
This script cleans the results of sublist3r.sh to leave only the domain names in a file for ease of copy paste

[CUSTOMIZATION]
You will need to update the following variables
UPDATES_DIR => [OPTIONAL] This is the path to the directory where the cleaned files will be output

[HOW TO RUN]
./sublist3r_file_cleaner.sh tinder.com.results

'
UPDATES_DIR="./updates"

if [ -z $1 ] || [ ! -f $1 ]; then
	echo "Please supply the name of the file to be cleaned"
	exit
else
	LINE=$(grep -n "Total Unique Subdomains Found" $1 | cut -d : -f 1)
	if [ -z $LINE ]; then
		echo "No match in $1"
		exit
	fi
	if [ ! -d $UPDATES_DIR ]; then
		mkdir $UPDATES_DIR
	fi
	# The file input was from tee command and may contain special characters. Using cat ignores these characters
	cat $1 > $UPDATES_DIR/$1.tmp
	tail -n +$LINE $UPDATES_DIR/$1.tmp  > $UPDATES_DIR/$1 && rm $UPDATES_DIR/$1.tmp
fi
