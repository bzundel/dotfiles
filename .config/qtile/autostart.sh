#!/usr/bin/env sh

dunst &
flameshot &
nm-applet &
redshift-gtk &
caffeine &
blueman-applet &

autorandr -c
feh --bg-scale /usr/share/backgrounds/wallpaper.png
