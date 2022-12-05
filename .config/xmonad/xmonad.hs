------------------------------------------------------------------------
---IMPORTS
------------------------------------------------------------------------
-- Base
import XMonad
import System.Directory
import System.IO (hClose, hPutStr, hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (toggleWS', Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S
import XMonad.Actions.FloatKeys

-- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isDialog, isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.DynamicProperty

-- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))
import XMonad.Hooks.InsertPosition

-- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.Hacks (windowedFullscreenFixEventHook, javaHack, trayerAboveXmobarEventHook, trayAbovePanelEventHook, trayerPaddingXmobarEventHook, trayPaddingXmobarEventHook, trayPaddingEventHook)
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

-- ColorScheme module (SET ONLY ONE!)
  -- Possible choice are:
  -- Catppuccin
  -- Tokyonight
import Colors.Catppuccin

------------------------------------------------------------------------
---VARIABLES
------------------------------------------------------------------------
myFont :: String
myFont = "xft:Iosevka Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myBrowser :: String
myBrowser = "google-chrome-stable"  -- Sets google-chrome as browser

myEmacs :: String
myEmacs = "emacs"  -- Makes emacs keybindings easier to type

myEditor :: String
myEditor = "nvim-qt"  -- Sets neovim as editor

myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String       -- Border color of normal windows
myNormColor   = colorBack   -- This variable is imported from Colors.THEME

myFocusColor :: String      -- Border color of focused windows
myFocusColor  = color13     -- This variable is imported from Colors.THEME

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
---STARTUP
------------------------------------------------------------------------
myStartupHook :: X ()
myStartupHook = do
  -- spawn "killall trayer"  -- kill current trayer on each restart

  -- Set resolution for all displays
  -- spawnOnce "xrandr --output HDMI-1 --mode 1920x1080 --rate 120.00 --output eDP-1 --off"

  -- spawnOnce "xfsettingsd --daemon"                                  -- Start settings daemon
  -- spawnOnce "xfce4-power-manager --daemon"                          -- Start power manager
  spawnOnce "lxsession -s Xmonad"                                      -- Start session manager
  -- spawnOnce "xss-lock -- betterlockscreen -l --off 30"              -- Autolock screen on display off
  -- spawnOnce "picom"                                                 -- Start compositor
  -- spawnOnce "nm-applet"                                             -- Start tray network applet
  -- spawnOnce "blueman-applet"                                        -- Start tray bluetooth applet
  spawnOnce "xsetroot -cursor_name left_ptr"                        -- Set cursor
  -- spawn "/usr/bin/emacs --daemon"                                   -- emacs daemon for the emacsclient
  -- spawnOnce "dunst"                                                 -- Start notifications daemon
  -- spawnOnce "xset r rate 500 35"                                    -- Keyboard settings

  -- System tray for xmobar
  -- spawn ("sleep 2 && trayer --edge top --align right --widthtype request --padding 5 --SetDockType true --SetPartialStrut true --expand true --monitor 0 --transparent false --alpha 0 " ++ colorTrayer ++ " --height 25")

  -- Set wallpaper
  spawnOnce "xargs xwallpaper --stretch < ~/.cache/wall"
  -- spawnOnce "~/.fehbg &"  -- set last saved feh wallpaper
  -- spawnOnce "feh --randomize --bg-fill ~/Pictures/Wallpapers/*"  -- feh set random wallpaper
  -- spawnOnce "nitrogen --restore &"   -- if you prefer nitrogen to feh

  setWMName "Xmonad"

------------------------------------------------------------------------
---SCRATCHPADS
------------------------------------------------------------------------
myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "calculator" spawnCalc findCalc manageCalc
                , NS "spotify" spawnSpot findSpot manageSpot
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.55
                 w = 0.45
                 t = 0.75 -h
                 l = 0.70 -w
    spawnSpot  = "spotify"
    findSpot   = resource =? "spotify"
    manageSpot = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

-- Float spotify scratchpad
myHandleEventHook :: Event -> X All
myHandleEventHook = dynamicPropertyChange "WM_NAME" (title =? "Spotify" --> doCenterFloat)

------------------------------------------------------------------------
---LAYOUTS
------------------------------------------------------------------------
-- Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining layouts.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ limitWindows 5
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ mySpacing 3
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ simplestFloat
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = color15
                 , inactiveColor       = color08
                 , activeBorderColor   = color15
                 , inactiveBorderColor = colorBack
                 , activeTextColor     = colorBack
                 , inactiveTextColor   = color16
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
  { swn_font              = "xft:Iosevka:bold:size=55"
  , swn_fade              = 1.0
  , swn_bgcolor           = "#45475a"
  , swn_color             = "#cdd6f4"
  }

-- The layout hook
myLayoutHook = avoidStruts
               $ mouseResize
               $ windowArrange
               $ T.toggleLayouts monocle
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout = smartBorders tall
                      ||| noBorders monocle
                      ||| floats
                      ||| noBorders tabs

------------------------------------------------------------------------
---WORKSPACES
------------------------------------------------------------------------
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
-- myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

------------------------------------------------------------------------
---WINDOW RULES
------------------------------------------------------------------------
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
  -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
  -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
  -- I'm doing it this way because otherwise I would have to write out the full
  -- name of my workspaces and the names would be very long if using clickable workspaces.
  [ className =? "confirm"         --> doFloat
  , className =? "dialog"          --> doFloat
  , className =? "download"        --> doFloat
  , className =? "error"           --> doFloat
  , className =? "file_progress"   --> doFloat
  , className =? "Gimp"            --> doFloat
  , className =? "notification"    --> doFloat
  , className =? "pinentry-gtk-2"  --> doFloat
  , className =? "splash"          --> doFloat
  , className =? "toolbar"         --> doFloat
  , className =? "Lxappearance"    --> doCenterFloat
  , className =? "Yad"             --> doCenterFloat
  , title =? "Appearance"          --> doCenterFloat
  , title =? "Bluetooth Devices"   --> doCenterFloat
  , title =? "Network Connections" --> doCenterFloat
  , title =? "Display"             --> doCenterFloat
  , title =? "Keyboard"            --> doCenterFloat
  , title =? "Power Manager"       --> doCenterFloat
  , title =? "Volume Control"      --> doCenterFloat
  , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
  , isFullscreen -->  doFullFloat
  , isDialog --> doCenterFloat <+> doF W.swapUp                                                                     -- Float Dialog Windows to Centre
  ] 
  <+> namedScratchpadManageHook myScratchPads
  <+> insertPosition Below Newer                    -- Insert New Windows at the Bottom of Stack Area

------------------------------------------------------------------------
---KEYBINDINGS
------------------------------------------------------------------------
subtitle' ::  String -> ((KeyMask, KeySym), NamedAction)
subtitle' x = ((0,0), NamedAction $ map toUpper
                      $ sep ++ "\n-- " ++ x ++ " --\n" ++ sep)
  where
    sep = replicate (6 + length x) '-'

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe $ "yad --text-info --fontname=\"Cantarell 12\" --geometry=1366x768 --title \"XMonad keybindings\""
  --hPutStr h (unlines $ showKm x) -- showKM adds ">>" before subtitles
  hPutStr h (unlines $ showKmSimple x) -- showKmSimple doesn't add ">>" to subtitles
  hClose h
  return ()

myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
  let subKeys str ks = subtitle' str : mkNamedKeymap c ks in
  -- Xmonad Essentials
  subKeys "Xmonad Essentials"
  [ ("M-C-r", addName "Recompile XMonad"       $ spawn "xmonad --recompile")
  , ("M-S-r", addName "Restart XMonad"         $ spawn "xmonad --restart")
  , ("M-C-q", addName "Quit XMonad"            $ io exitSuccess)
  , ("M-q", addName "Kill focused window"      $ kill1)
  , ("M-r", addName "Run prompt"               $ spawn "rofi -show run")
  , ("M-S-a", addName "Kill all windows on WS" $ killAll)
  , ("M-<Escape>", addName "Logout menu"       $ spawn "dm-logout")]

  -- Switch to workspace
  ^++^ subKeys "Switch to workspace"
  [ ("M-1", addName "Switch to workspace 1"    $ (windows $ W.greedyView $ myWorkspaces !! 0))
  , ("M-2", addName "Switch to workspace 2"    $ (windows $ W.greedyView $ myWorkspaces !! 1))
  , ("M-3", addName "Switch to workspace 3"    $ (windows $ W.greedyView $ myWorkspaces !! 2))
  , ("M-4", addName "Switch to workspace 4"    $ (windows $ W.greedyView $ myWorkspaces !! 3))
  , ("M-5", addName "Switch to workspace 5"    $ (windows $ W.greedyView $ myWorkspaces !! 4))
  , ("M-6", addName "Switch to workspace 6"    $ (windows $ W.greedyView $ myWorkspaces !! 5))
  , ("M-7", addName "Switch to workspace 7"    $ (windows $ W.greedyView $ myWorkspaces !! 6))
  , ("M-8", addName "Switch to workspace 8"    $ (windows $ W.greedyView $ myWorkspaces !! 7))
  , ("M-9", addName "Switch to workspace 9"    $ (windows $ W.greedyView $ myWorkspaces !! 8))
  , ("M-<Tab>", addName "Toggle between recent WS excluding NSP" $ toggleWS' ["NSP"])]

  -- Send window to workspace
  ^++^ subKeys "Send window to workspace"
  [ ("M-S-1", addName "Send to workspace 1"    $ (windows $ W.shift $ myWorkspaces !! 0))
  , ("M-S-2", addName "Send to workspace 2"    $ (windows $ W.shift $ myWorkspaces !! 1))
  , ("M-S-3", addName "Send to workspace 3"    $ (windows $ W.shift $ myWorkspaces !! 2))
  , ("M-S-4", addName "Send to workspace 4"    $ (windows $ W.shift $ myWorkspaces !! 3))
  , ("M-S-5", addName "Send to workspace 5"    $ (windows $ W.shift $ myWorkspaces !! 4))
  , ("M-S-6", addName "Send to workspace 6"    $ (windows $ W.shift $ myWorkspaces !! 5))
  , ("M-S-7", addName "Send to workspace 7"    $ (windows $ W.shift $ myWorkspaces !! 6))
  , ("M-S-8", addName "Send to workspace 8"    $ (windows $ W.shift $ myWorkspaces !! 7))
  , ("M-S-9", addName "Send to workspace 9"    $ (windows $ W.shift $ myWorkspaces !! 8))]

  -- Move window to WS and go there
  ^++^ subKeys "Move window to WS and go there"
  [ ("M-S-<Page_Up>", addName "Move window to next WS"   $ shiftTo Next nonNSP >> moveTo Next nonNSP)
  , ("M-S-<Page_Down>", addName "Move window to prev WS" $ shiftTo Prev nonNSP >> moveTo Prev nonNSP)]

  -- Window navigation
  ^++^ subKeys "Window navigation"
  [ ("M-j", addName "Move focus to next window"                $ windows W.focusDown)
  , ("M1-<Tab>", addName "Move focus to next window"           $ windows W.focusDown)
  , ("M-k", addName "Move focus to prev window"                $ windows W.focusUp)
  , ("M1-S-<Tab>", addName "Move focus to prev window"         $ windows W.focusUp)
  , ("M-m", addName "Move focus to master window"              $ windows W.focusMaster)
  , ("M-S-j", addName "Swap focused window with next window"   $ windows W.swapDown)
  , ("M-S-k", addName "Swap focused window with prev window"   $ windows W.swapUp)
  , ("M-S-m", addName "Swap focused window with master window" $ windows W.swapMaster)
  , ("M-<Backspace>", addName "Move focused window to master"  $ promote)
  , ("M-S-,", addName "Rotate all windows except master"       $ rotSlavesDown)
  , ("M-S-.", addName "Rotate all windows in current stack"    $ rotAllDown)]

  -- Dmenu/Rofi scripts (dmscripts)
  ^++^ subKeys "Dmenu scripts"
  [ ("M-d a", addName "Applications menu"      $ spawn "rofi -show drun")
  , ("M-d b", addName "Set background"         $ spawn "dm-setbg")
  , ("M-d c", addName "Pick color from scheme" $ spawn "dm-colpick")
  , ("M-d e", addName "Edit config files"      $ spawn "dm-confedit")
  , ("M-d k", addName "Kill processes"         $ spawn "dm-kill")
  , ("M-d m", addName "View manpages"          $ spawn "dm-man")
  , ("M-d n", addName "View wifi networks"     $ spawn "dm-wifi")
  , ("M-d p", addName "Switch audio output"    $ spawn "dm-audio-out-switcher")
  , ("M-d q", addName "Logout Menu"            $ spawn "dm-logout")
  , ("M-d r", addName "Run program"            $ spawn "rofi -show run")
  , ("M-d s", addName "Take a screenshot"      $ spawn "dm-maim")
  , ("M-d t", addName "Show weather"           $ spawn "dm-weather")
  , ("M-d w", addName "Switch window"          $ spawn "rofi -show window")]

  -- Favorite programs
  ^++^ subKeys "Favorite programs"
  [ ("M-<Return>", addName "Launch terminal"   $ spawn (myTerminal))
  , ("M-b", addName "Launch web browser"       $ spawn (myBrowser))
  , ("M-e", addName "Launch emacs"             $ spawn (myEmacs))
  , ("M-f", addName "Launch file manager"      $ spawn "thunar")
  , ("M-S-f", addName "Launch firefox"         $ spawn "firefox")
  , ("M-n", addName "Launch neovim"            $ spawn (myEditor))
  , ("M-v", addName "Launch vscode"            $ spawn "code")]

  -- Settings
  ^++^ subKeys "Settings"
  [ ("M-c a", addName "Appearance settings"        $ spawn "lxappearance")
  , ("M-c b", addName "Bluetooth settings"         $ spawn "blueman-manager")
  , ("M-c d", addName "Display settings"           $ spawn "lxrandr")
  , ("M-c m", addName "System monitor"             $ spawn "system-monitoring-center")
  , ("M-c n", addName "NM connection editor"       $ spawn "nm-connection-editor")
  , ("M-c p", addName "Power manager settings"     $ spawn "xfce4-power-manager -c")
  , ("M-c s", addName "Sound settings"             $ spawn "pavucontrol")
  , ("M-c w", addName "Change wallpaper"           $ spawn "sxiv -t ~/Pictures/Wallpapers")]

  -- Monitors
  ^++^ subKeys "Monitors"
  [ ("M-.", addName "Switch focus to next monitor" $ nextScreen)
  , ("M-,", addName "Switch focus to prev monitor" $ prevScreen)]

  -- Switch layouts
  ^++^ subKeys "Switch layouts"
  [ ("M-C-<Tab>", addName "Switch to next layout" $ sendMessage NextLayout)
  , ("M-M1-m", addName "Toggle monocle layout"    $ sendMessage (T.Toggle "monocle"))
  , ("M-<Space>", addName "Toggle noborders/full" $ sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)]

  -- Window resizing
  ^++^ subKeys "Window resizing"
  [ ("M-h", addName "Shrink window"               $ sendMessage Shrink)
  , ("M-l", addName "Expand window"               $ sendMessage Expand)
  , ("M-M1-j", addName "Shrink window vertically" $ sendMessage MirrorShrink)
  , ("M-M1-k", addName "Expand window vertically" $ sendMessage MirrorExpand)]

  -- Floating windows
  ^++^ subKeys "Floating windows"
  [ ("M-t", addName "Sink a floating window"                  $ withFocused $ windows . W.sink)
  , ("M-S-t", addName "Sink all floated windows"              $ sinkAll)
  , ("M-C-f", addName "Toggle floating state of a window"     $ withFocused toggleFloat)
  , ("M-M1-<Up>", addName "Move window up"                    $ withFocused (keysMoveWindow (0,-10)))
  , ("M-M1-<Down>", addName "Move window down"                $ withFocused (keysMoveWindow (0,10)))
  , ("M-M1-<Right>", addName "Move window right"              $ withFocused (keysMoveWindow (10,0)))
  , ("M-M1-<Left>", addName "Move window left"                $ withFocused (keysMoveWindow (-10,0)))
  , ("M-S-<Up>", addName "Increase window size to up"         $ withFocused (keysResizeWindow (0,10) (0,1)))
  , ("M-S-<Down>", addName "Increase window size to down"     $ withFocused (keysResizeWindow (0,10) (0,0)))
  , ("M-S-<Right>", addName "Increase window size to right"   $ withFocused (keysResizeWindow (10,0) (0,1)))
  , ("M-S-<Left>", addName "Increase window size to left"     $ withFocused (keysResizeWindow (10,0) (1,1)))
  , ("M-C-<Up>", addName "Decrease window size from up"       $ withFocused (keysResizeWindow (0,-10) (0,1)))
  , ("M-C-<Down>", addName "Decrease window size from down"   $ withFocused (keysResizeWindow (0,-10) (0,0)))
  , ("M-C-<Right>", addName "Decrease window size from right" $ withFocused (keysResizeWindow (-10,0) (0,1)))
  , ("M-C-<Left>", addName "Decrease window size from left"   $ withFocused (keysResizeWindow (-10,0) (1,1)))]

  -- Increase/decrease windows in the master pane or the stack
  ^++^ subKeys "Increase/decrease windows in master pane or the stack"
  [ ("M-S-i", addName "Increase clients in master pane"    $ sendMessage (IncMasterN 1))
  , ("M-S-d", addName "Decrease clients in master pane"    $ sendMessage (IncMasterN (-1)))
  , ("M-=", addName "Increase max # of windows for layout" $ increaseLimit)
  , ("M--", addName "Decrease max # of windows for layout" $ decreaseLimit)]

  -- Sublayouts
  -- This is used to push windows to tabbed sublayouts, or pull them out of it.
  ^++^ subKeys "Sublayouts"
  [ ("M-C-h", addName "pullGroup L"           $ sendMessage $ pullGroup L)
  , ("M-C-l", addName "pullGroup R"           $ sendMessage $ pullGroup R)
  , ("M-C-k", addName "pullGroup U"           $ sendMessage $ pullGroup U)
  , ("M-C-j", addName "pullGroup D"           $ sendMessage $ pullGroup D)
  , ("M-C-m", addName "MergeAll"              $ withFocused (sendMessage . MergeAll))
  , ("M-C-u", addName "UnMerge"               $ withFocused (sendMessage . UnMerge))
  , ("M-C-/", addName "UnMergeAll"            $  withFocused (sendMessage . UnMergeAll))
  , ("M-C-.", addName "Switch focus next tab" $  onGroup W.focusUp')
  , ("M-C-,", addName "Switch focus prev tab" $  onGroup W.focusDown')]

  -- Scratchpads
  -- Toggle show/hide these programs. They run on a hidden workspace.
  -- When you toggle them to show, it brings them to current workspace.
  -- Toggle them to hide and it sends them back to hidden workspace (NSP).
  ^++^ subKeys "Scratchpads"
  [ ("M-s t", addName "Toggle scratchpad terminal"    $ namedScratchpadAction myScratchPads "terminal")
  , ("M-s c", addName "Toggle scratchpad calculator"  $ namedScratchpadAction myScratchPads "calculator")
  , ("M-s s", addName "Toggle scratchpad spotify"     $ namedScratchpadAction myScratchPads "spotify")]

  -- Multimedia Keys
  ^++^ subKeys "Multimedia keys"
  [ ("<XF86AudioMute>", addName "Toggle audio mute"           $ spawn "~/.bin/audio mute")
  , ("<XF86AudioRaiseVolume>", addName "Raise volume"         $ spawn "~/.bin/audio up")
  , ("<XF86AudioLowerVolume>", addName "Lower volume"         $ spawn "~/.bin/audio down")
  , ("<XF86MonBrightnessUp>", addName "Increase brightness"   $ spawn "~/.bin/brightness up")
  , ("<XF86MonBrightnessDown>", addName "Decrease brightness" $ spawn "~/.bin/brightness down")
  , ("<Print>", addName "Take screenshot (dmscripts)"         $ spawn "dm-maim")
  ]
  -- The following lines are needed for named scratchpads.
    where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
          nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

          -- Function to toggle floating state on focused window.
          toggleFloat w = windows (\s -> if M.member w (W.floating s)
                          then W.sink w s
                          else (W.float w (W.RationalRect (1/6) (1/6) (2/3) (2/3)) s))

------------------------------------------------------------------------
---MAIN
------------------------------------------------------------------------
main :: IO ()
main = do
  -- Launching two instances of xmobar on their monitors.
  -- xmproc0 <- spawnPipe ("xmobar -x 0 $HOME/.config/xmobar/" ++ colorScheme ++ "-xmobarrc")
  xmproc1 <- spawnPipe ("xmobar -x 1 $HOME/.config/xmobar/" ++ colorScheme ++ "-xmobarrc")

  -- the xmonad, ya know...what the WM is named after!
  xmonad $ addDescrKeys' ((mod4Mask, xK_grave), showKeybindings) myKeys $ ewmh $ docks $ def
    { manageHook         = myManageHook <+> manageDocks
    , handleEventHook    = windowedFullscreenFixEventHook <> swallowEventHook (className =? "Alacritty"  <||> className =? "kitty" <||> className =? "XTerm") (return True) <> trayerPaddingXmobarEventHook <+> myHandleEventHook
    , modMask            = myModMask
    , terminal           = myTerminal
    , startupHook        = myStartupHook
    , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    , logHook = dynamicLogWithPP $  filterOutWsPP [scratchpadWorkspaceTag] $ xmobarPP
        { ppOutput = \x -> hPutStrLn xmproc1 x   -- xmobar on external monitor
                        -- >> hPutStrLn xmproc0 x   -- xmobar on laptop
        , ppCurrent = xmobarColor color06 "" . wrap
                      ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
          -- Visible but not current workspace
        , ppVisible = xmobarColor color06 "" . clickable
          -- Hidden workspace
        , ppHidden = xmobarColor color05 "" . wrap
                     ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>" . clickable
          -- Hidden workspaces (no windows)
        , ppHiddenNoWindows = xmobarColor color09 ""  . clickable
          -- Title of active window
        , ppTitle = xmobarColor color16 "" . shorten 60
          -- Separator character
        , ppSep =  "<fc=" ++ color01 ++ "> <fn=1>|</fn> </fc>"
          -- Urgent workspace
        , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
          -- Current layout
        , ppLayout = xmobarColor color02 "" . wrap "[" "]"
          -- Adding # of windows on current workspace to the bar
        , ppExtras  = [windowCount]
          -- order of things in xmobar
        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
        }
    }
