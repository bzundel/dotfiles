import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.NamedScratchpad
import qualified XMonad.StackSet as W
import XMonad.Layout (Tall, Full)
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Fullscreen
import System.Exit (exitSuccess)
import System.IO (hPutStrLn)

main :: IO ()
main = do
	xmproc <- spawnPipe "sh ~/.config/xmobar/launch.sh"
	xmonad $ ewmhFullscreen . ewmh $ docks def
		--{ layoutHook = avoidStruts $ layoutHook def
		{ layoutHook = avoidStruts $ definedLayoutHook
		, logHook 	= dynamicLogWithPP $ filterOutWsPP ["NSP"] $ xmobarPP
			{ ppOutput 	= hPutStrLn xmproc
			, ppTitle 	= xmobarColor "#aaccff" "" . shorten 80
			, ppCurrent	= xmobarColor "#6aa4fc" "" . wrap "<" ">"
			, ppVisible	= wrap "(" ")"
			, ppHidden	= id
			, ppHiddenNoWindows = xmobarColor "#666666" ""
			}
		, startupHook = definedStartupHook
		, terminal 	= "alacritty"
		, modMask	= mod1Mask
		, workspaces	= definedWorkspaces
		, normalBorderColor = "#000000"
		, focusedBorderColor = "#aaccff"
		, manageHook = namedScratchpadManageHook definedScratchpads <+> insertPosition Below Newer
		}
		`removeKeysP`
		[ "M-S-p"
		, "M-S-c"
		, "M-S-r"
		, "M-S-m"
		]
		`additionalKeysP`
		[ ("M-S-q", kill)
		, ("M-S-e", io exitSuccess)
		, ("M-C-t", namedScratchpadAction definedScratchpads "tray")
		, ("M-C-b", namedScratchpadAction definedScratchpads "monitor")
		]

definedWorkspaces = ["term","www","dev","rdp","misc","opt","msg","media","mail"]

definedLayoutHook =
	smartBorders $
	Tall 1 (10/100) (60/100)
	||| noBorders Full

definedStartupHook :: X()
definedStartupHook = do
	spawn "xset r rate 200 50"
	spawnOnce "picom"
	spawnOnce "sxhkd"
	spawnOnce "dunst"
	spawnOnce "protonmail-bridge --no-window"
	spawnOnce "xsetroot -solid \"#000000\""
	spawn "setxkbmap eu"
	--spawnOnce "feh --bg-fill /usr/share/backgrounds/wallpaper.jpg"

definedScratchpads :: NamedScratchpads
definedScratchpads =
    [ NS "tray"
        "stalonetray --window-type normal --window-strut none --icon-size 32"
        (className =? "stalonetray")
        (customFloating $ W.RationalRect 0.70 0.05 0.25 0.06)
		, NS "monitor"
				"alacritty --class ScratchMonitor -e btop"
				(className =? "ScratchMonitor")
				(customFloating $ W.RationalRect 0.10 0.10 0.80 0.80)
    ]
