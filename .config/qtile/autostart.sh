#!/usr/bin/env sh

dunst &
flameshot &
nm-applet &
redshift-gtk &
caffeine &
blueman-applet &

autorandr -c

if [ "$(hostname)" = "minicora" ]; then
	xinput set-prop 14 --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
fi

feh --bg-scale /usr/share/backgrounds/wallpaper.png
