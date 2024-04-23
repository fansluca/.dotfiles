#!/bin/bash
files=(~/Pictures/Wallpaper/*)
selected_file=${files[RANDOM % ${#files[@]}]}
hyprctl hyprpaper wallpaper "eDP-1,$selected_file"
