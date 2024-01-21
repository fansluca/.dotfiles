#!/usr/bin/bash

kitty --title system_updates sh -c 'yay -Syu' && notify-send "Update complete"

pkill -RTMIN+8 waybar
