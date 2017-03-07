import XMonad 
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import XMonad.Actions.GridSelect
import XMonad.Util.Paste
import XMonad.Actions.NoBorders
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts

import qualified Data.Map as M

import qualified XMonad.Layout.Magnifier as Mag
import XMonad.Layout.Reflect       -- (13) ability to reflect layouts
import XMonad.Layout.MultiToggle   -- (14) apply layout modifiers dynamically
import XMonad.Layout.MultiToggle.Instances
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Grid          -- (6)  grid layout
import XMonad.Layout.TwoPane
import XMonad.Layout.Accordion
import XMonad.Layout.Gaps
import XMonad.Layout.Combo
import XMonad.Layout.ResizableTile
import XMonad.Layout.Named
import XMonad.Layout.Cross
import XMonad.Layout.MosaicAlt
import XMonad.Layout.Combo
import XMonad.Hooks.InsertPosition
import XMonad.Actions.FloatKeys

main = do
  h <- spawnPipe "xmobar -d"  
  xmonad $ ewmh defaultConfig
    { terminal = "urxvt"
    , startupHook = setWMName "LG3D"
    , workspaces = myWorkspaces
    , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
    , layoutHook = myLayoutHook
    , modMask  = mod4Mask
    , manageHook = myManageHook
    , logHook = dynamicLogWithPP xmobarPP
        {
            ppOutput = hPutStrLn h   ,
            ppTitle = xmobarColor "green" "" . shorten 160
        }   
    } `additionalKeys` [
        -- Volume Control
        ((0, 0x1008FF13), spawn "~/code/thinkpad-buttons/volup.sh")
      , ((0, 0x1008FF11), spawn "~/code/thinkpad-buttons/voldown.sh")
      , ((0, 0x1008FF12), spawn "~/code/thinkpad-buttons/mute-toggle.sh")
      , ((0, 0x1008FFB2), spawn "~/code/thinkpad-buttons/mute-mic-toggle.sh")
      , ((0, 0x1008FF03), spawn "~/code/thinkpad-buttons/bright_down.sh")
      , ((0, 0x1008FF02), spawn "~/code/thinkpad-buttons/bright_up.sh")
      , ((0, 0x1008FF59), spawn "~/code/thinkpad-buttons/xrandr_add_monitor.sh")
    ] `additionalKeysP` [
        ("<Print>", spawn "xfce4-screenshooter")
      , ("<XF86ScreenSaver>", spawn "i3lock-wrapper")
      , ("<XF86Launch1>", spawn "nmcli_dmenu")
      , ("M-z", spawnSelected' [
            ("Firefox", "firefox")
          , ("Chromium", "chromium")
          , ("Tor", "tor-browser-de")
          , ("viFM", "urxvt -e 'vifm'")
      ])
      , ("M-S-<Backspace>", spawn "chromium")
      , ("M-v", pasteSelection)
      , ("M-b", withFocused toggleBorder)
      , ("M-z", withFocused (keysMoveWindowTo (0,0) (0,0)))
    ] 
    
myManageHook :: ManageHook
myManageHook = insertPosition End Newer <+> manageWindows
    <+> manageDocks <+>
        manageHook def

manageWindows :: ManageHook
manageWindows = composeAll
    [ className =? "Gimp" --> doFloat
    , appName =? "sysctrl" --> doShift "9:sys"
    , appName =? "keeweb" --> doShift "8:pw"
    ]

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf = defaultGSConfig


myLayoutHook = avoidStruts 
                 $ smartBorders $
	reflectHoriz resizableTile ||| (Mirror resizableTile)
    ||| Full
  where
    resizableTile = ResizableTall nmaster delta ratio []
    nmaster = 1
    ratio = toRational (2/(1+sqrt(5)::Double))
    delta = 3/100


myWorkspaces = ["1:main", "2:side", "3:else", "4", "5", "6", "7", "8:pw", "9:sys"]
