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

if ((($value + $1) > 255)) ;
then
	echo "255" > $batteryFile
    exit 0
fi

if ((($value + $1) < 0));
then
	echo "0" > $batteryFile
    exit 0
fi

echo $(("$value" + $1)) > $batteryFile

