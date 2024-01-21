#!/usr/bin/env bash
# Constants
divider="---------"
goback="Back"
dir="$HOME/.config/rofi/wifi/type-1"
theme='style-8'

bssid=$(nmcli device wifi list | sed -n '1!P' | cut -b 9- | rofi -dmenu -theme ${dir}/${theme}.rasi -p " " -lines 10 | awk '{print $1}')
[ -z "$bssid" ] && exit 1
nmcli device wifi connect $bssid
notify-send "📶 WiFi Connected"
