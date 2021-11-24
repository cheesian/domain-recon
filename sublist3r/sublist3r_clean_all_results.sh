#!/bin/bash

: '
[ABOUT]
This script is to be run in the directory where you have the results of enumeration from using the sublist3r.sh script (.result files)
It cleans the data to only extract the domain names for ease of copy paste

[CUSTOMIZATION]
You will need to update the following variables
CLEANER_SCRIPT_PATH => The path to sublist3r_file_cleaner.sh

[HOW TO RUN]
./sublist3r_clean_all_results.sh
'

CLEANER_SCRIPT_PATH="./sublist3r_file_cleaner.sh"

for file in $(ls ./*.results)
do
	 $CLEANER_SCRIPT_PATH $file
done
