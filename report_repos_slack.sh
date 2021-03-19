#!/usr/bin/env
FILE=git-log-`date -I`.txt
if [ -f "$FILE" ] && [ $# -eq 2 ]; then
	cat < git-log-`date -I`.txt | ~/./slack chat send --channel "$1"
else
	echo "No report found or no channel/id provided."
fi
