#bin/bash

#usage
function usage {
	echo 'Usage : 
 enable : Enable the charghe threshold
 disable: Disable the charghe threshold
 help   : Display this message
 '
}

STR="$@"

if [ "$STR" = "enable" ]; then
	echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode > /dev/null
elif [ "$STR" = "disable" ]; then
	echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode > /dev/null
elif [ "$STR" = "help" ]; then
	usage
else
	echo "bad argument"
	usage
fi
