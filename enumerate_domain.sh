#!/bin/bash
: '
[ABOUT]
This script requires that you have amass, sublist3r, and knockpy installed. You can git clone them using the following urls
https://github.com/OWASP/Amass.git
https://github.com/aboul3la/Sublist3r.git
https://github.com/guelfoweb/knock.git

[CUSTOMIZATION]
You will need to update the following variables
SUBLIST3R_PATH => This should match the path to sublist3r.py inside the cloned repository for sublist3r (Link in [ABOUT] section)
KNOCK_PATH => This should match the path to knockpy.py inside the cloned repository for knock (Link in [ABOUT] section)
SLEEP_DURATION => [OPTIONAL] This is the time interval between enumeration of different domain names
DNS => [OPTIONAL] This is the dns server you want to use

[HOW TO RUN]
./enumerate_domain.sh domains/chime.domains
'

FILENAME="enumerate_domain.sh"
SUBLIST3R_PATH="$HOME/Documents/CcHub/recon/Sublist3r/sublist3r.py"
KNOCK_PATH="$HOME/Documents/CcHub/recon/knock/knockpy.py"
SLEEP_DURATION=30
DNS=8.8.8.8

if [ ! -f $SUBLIST3R_PATH ]; then
	echo "Please update the SUBLIST3R_PATH variable in $FILENAME to match the path to your sublist3r.py"
	exit
fi

if [ ! command -v amass ]; then
	echo "Please install Amass first"
	exit
fi

if [ ! -f $KNOCK_PATH ]; then
	echo "Please update the KNOCK_PATH variable in $FILENAME to match the path to your knockpy.py"
	exit
fi

if [ -z "$1" ] || [ ! -f $1 ]; then
	echo "Please supply the name of the file containing your domains"
	exit
else
	for domain in $(cat $1)
	do
		python3 $SUBLIST3R_PATH -d $domain | tee $domain.results.sublist3r
		echo "Sublist3r output for $domain has been stored in $domain.results.sublist3r"
		python3 $KNOCK_PATH $domain | tee $domain.results.knockpy
		echo "Knockpy output for $domain has been stored in $domain.results.knockpy"
		amass enum -r $DNS -d $domain | tee $domain.results.amass
		echo "Amass output for $domain has been stored in $domain.results.amass"
		echo "Sleeping for $SLEEP_DURATION seconds before continuing. You can change the SLEEP_DURATION variable in $FILENAME to reduce this interval"
		sleep $SLEEP_DURATION
	done
fi
