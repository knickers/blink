#!/bin/bash
set -e

if [ -z "$1" ]; then
	echo "Usage: $0 <GPIO Pin Number> [sleep duration]"
	echo
	echo 'Optional sleep duration defaults to 1 second.'
	echo
	man sleep | head -n 15
	exit
fi

PIN="$(printf '%.0f' $1)"

if [ -n "$2" ]; then
	SLEEP="${@:2}"
else
	SLEEP=1
fi

while true; do
	gpio-toggle $PIN 1
	echo -ne "\rHIGH"

	sleep $SLEEP

	gpio-toggle $PIN 0
	echo -ne "\rLOW "

	sleep $SLEEP
done
