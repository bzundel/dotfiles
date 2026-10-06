#!/bin/sh

case "$(uname -n)" in
	teleya)
		config="$HOME/.config/xmobar/xmobarrc-teleya"
		;;
	*)
		config="$HOME/.config/xmobar/xmobarrc"
		;;
esac

exec xmobar "$config" 
