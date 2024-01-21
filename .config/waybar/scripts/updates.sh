#!/usr/bin/bash

threshhold_green=0
threshhold_yellow=20
threshhold_red=50

if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
	updates_arch=0
fi

if ! updates_aur=$(yay -Qua | wc -l); then
	updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

# updates=120

css_class="green"

if [ "$updates" -gt $threshhold_yellow ]; then
	css_class="yellow"
fi

if [ "$updates" -gt $threshhold_red ]; then
	css_class="red"
fi

if [ "$updates" -gt $threshhold_green ]; then
	printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates", "class": "%s"}' "$updates" "$updates" "$updates" "$css_class"
else
	printf '{"text": "0", "alt": "0", "tooltip": "0 Updates", "class": "green"}'
fi
