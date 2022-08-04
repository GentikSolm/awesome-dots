#!/bin/bash
batteryFile="/sys/class/leds/asus::screenpad/brightness"

# For testing
# batteryFile="$HOME/.config/awesome/scripts/config.txt"
value=`cat $batteryFile`
if [ -z "$1" ];
then
	echo "
	Requires amount for brightness change
	"
    exit 1
fi

if ((($value + $1) < 0)) || ((($value + $1) > 255)) ;
then
    exit 0
fi

echo $(("$value" + $1)) > $batteryFile

