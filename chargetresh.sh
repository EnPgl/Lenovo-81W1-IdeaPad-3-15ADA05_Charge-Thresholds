#!/bin/bash

#stop execution on error
set -o errexit

#usage
function usage {
	echo 'Usage : 
 enable : Enable the charghe threshold
 disable: Disable the charghe threshold
 status:  Display charghe threshold  and battery status
 help   : Display this message
 '
}

function status {
	STAT=$(sudo cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
	echo "Charge threshold status (0 disabled, 1 enabled)"
	echo "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode: $STAT"
	CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
	echo "Charge[%]: $CHARGE"
	BAT_STAT=$(cat /sys/class/power_supply/BAT0/status)
	echo "Battery status: $BAT_STAT"
}

function change_thres {
	echo $1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode > /dev/null
}



STR="$@"

if [ "$STR" = "enable" ]; then
	change_thres 1
elif [ "$STR" = "disable" ]; then
	change_thres 0
elif [ "$STR" = "status" ]; then
	status
elif [ "$STR" = "help" ]; then
	usage
else
	echo "bad argument"
	usage
fi
