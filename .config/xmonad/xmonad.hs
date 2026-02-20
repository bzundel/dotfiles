import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Layout (Tall, Full)
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Fullscreen
import System.Exit (exitSuccess)
import System.IO (hPutStrLn)

main :: IO ()
main = do
	xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
	xmonad $ ewmhFullscreen . ewmh $ docks def
		--{ layoutHook = avoidStruts $ layoutHook def
		{ layoutHook = avoidStruts $ definedLayoutHook
		, logHook 	= dynamicLogWithPP $ xmobarPP
			{ ppOutput 	= hPutStrLn xmproc
			, ppTitle 	= xmobarColor "#aaccff" "" . shorten 80
			, ppCurrent	= xmobarColor "#6aa4fc" "" . wrap "<" ">"
			, ppVisible	= wrap "(" ")"
			, ppHidden	= id
			, ppHiddenNoWindows = xmobarColor "#666666" ""
			}
		, terminal 	= "alacritty"
		, modMask	= mod1Mask
		, workspaces	= definedWorkspaces
		, normalBorderColor = "#000000"
		, focusedBorderColor = "#aaccff"
		, manageHook = insertPosition Below Newer
		}
		`additionalKeysP`
		[ ("M-S-q", kill)
		, ("M-S-e", io exitSuccess)
		]

definedWorkspaces = ["term","www","dev","rdp","misc","opt","msg","media","mail"]

definedLayoutHook =
	smartBorders $
	Tall 1 (10/100) (60/100)
	||| noBorders Full
