#!/bin/bash

#stop execution on error
set -o errexit

#usage
function usage {
	echo 'Usage : 
 enable : Enable the charge threshold
 disable: Disable the charge threshold
 status:  Display charge threshold  and battery status
 help   : Display this message
 '
}

#print the battery status
function status {
	#find if the conservation mode/charge threshold is enabled from /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
	STATUS=$([[ $(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode) == 0 ]] && echo "disabled" || echo "enabled")
	echo "Conservation mode/charge threshold status: $STATUS"
	
	#get the battery capacity from /sys/class/power_supply/BAT0/capacity
	echo "Charge[%]: $(cat /sys/class/power_supply/BAT0/capacity)"
	
	#get the battery status from /sys/class/power_supply/BAT0/status
	echo "Battery status: $(cat /sys/class/power_supply/BAT0/status)"
}

#enable/disable the threshold/Conservation mode
function change_thres {
	echo $1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode > /dev/null
}


#get the input
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
