#!/bin/bash
LOGFILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').log";

/usr/bin/clamscan "$@" 2>&1 | tee "$LOGFILE";

# get the value of "Infected lines"
MALWARE=$(tail "$LOGFILE"|grep Infected|cut -d" " -f3);

if [ -z "$PUSHOVER_TOKEN" ] && [ -z "$PUSHOVER_TOKEN" ];then
	# if the value is not equal to zero, send an email with the log file attached
	if [ "$MALWARE" -ne "0" ];then
		if [ -z "$INSTANCE_NAME" ];then
			curl --data "token=$PUSHOVER_TOKEN" --data "user=$PUSHOVER_USER" --data "title=$INSTANCE_NAME - Malware Detected" --data "message=Clamscan detected malware, review logs immediately!" https://api.pushover.net/1/messages.json;
		else
			curl --data "token=$PUSHOVER_TOKEN" --data "user=$PUSHOVER_USER" --data "title=Malware Detected" --data "message=Clamscan detected malware, review logs immediately!" https://api.pushover.net/1/messages.json;
		fi
	fi
fi 

rm "$LOGFILE"

exit 0