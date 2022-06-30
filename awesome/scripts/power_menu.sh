#!/usr/bin/bash

declare -A actions=( ["Poweroff"]="poweroff" ["Reboot"]="reboot" ["Logout"]="kill -9 -1" )
cmd=$(echo -e "Poweroff\nReboot\nLogout" | rofi -lines 3 -theme-str 'entry { enabled: false;}' -dmenu -p "Boot Menu")
[ ! -z $cmd ] && ${actions[$cmd]}
