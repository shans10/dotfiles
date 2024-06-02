------------------------------------------------------------------------
---IMPORTS
------------------------------------------------------------------------
-- ColorScheme module (SET ONLY ONE!) --
-- Possible choice are:
-- Catppuccin
-- Tokyonight
--
import Colors.Catppuccin
-- Data --
--
import Data.Char (isSpace, toUpper)
import Data.Map qualified as M
import Data.Maybe (fromJust, isJust, isNothing)
import Data.Monoid
import Data.Tree
-- Base --
--
import System.Directory
import System.Exit (exitSuccess)
import System.IO (hClose, hPutStr, hPutStrLn)
import XMonad
-- Actions --
--
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D (..), WSType (..), doTo, moveTo, nextScreen, nextWS, prevScreen, prevWS, shiftTo, toggleWS')
import XMonad.Actions.EasyMotion
import XMonad.Actions.FloatKeys
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotAllDown, rotSlavesDown)
import XMonad.Actions.Search qualified as S
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (killAll, sinkAll)
-- Hooks --
--
import XMonad.Hooks.DynamicProperty
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks (ToggleStruts (..))
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isDialog, isFullscreen)
import XMonad.Hooks.RefocusLast (isFloat, refocusLastLayoutHook, refocusLastWhen, refocusingIsActive)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar (StatusBarConfig (..), defToggleStrutsKey, statusBarProp, withEasySB, xmonadPropLog)
import XMonad.Hooks.StatusBar.PP (PP (..), dynamicLogString, filterOutWsPP, shorten, wrap, xmobarColor)
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.WorkspaceHistory
-- Layouts --
--
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (decreaseLimit, increaseLimit, limitWindows)
import XMonad.Layout.MultiToggle (EOT (EOT), mkToggle, single, (??))
import XMonad.Layout.MultiToggle qualified as MT (Toggle (..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts qualified as T (ToggleLayout (Toggle), toggleLayouts)
import XMonad.Layout.TrackFloating
import XMonad.Layout.WindowArranger (WindowArrangerMsg (..), windowArrange)
import XMonad.Layout.WindowNavigation
-- Windows --
--
import XMonad.StackSet qualified as W
-- Utilities --
--
import XMonad.Util.ClickableWorkspaces (clickablePP)
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.Hacks (windowedFullscreenFixEventHook)
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare

------------------------------------------------------------------------
---VARIABLES
------------------------------------------------------------------------
myFont :: String
myFont = "xft:Iosevka Nerd Font" -- sets default font

myModMask :: KeyMask
myModMask = mod4Mask -- sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty" -- sets default terminal

myBrowser :: String
myBrowser = "google-chrome-stable" -- sets default browser

myEmacs :: String
myEmacs = "emacs" -- sets default emacs command

myEditor :: String
myEditor = myTerminal ++ " -e nvim" -- sets default editor

myBorderWidth :: Dimension
myBorderWidth = 2 -- sets border width for windows

myNormColor :: String -- border color of normal windows
myNormColor = colorBack -- this variable is imported from Colors.THEME

myFocusColor :: String -- border color of focused windows
myFocusColor = color13 -- this variable is imported from Colors.THEME

windowCount :: X (Maybe String) -- number of windows in current workspace
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

sysTray :: String -- sets default system tray command
sysTray =
  "trayer --edge top --align right --widthtype request --padding 5 --SetDockType true --SetPartialStrut true --expand true --monitor 0 --transparent false --alpha 0 "
    ++ colorTrayer
    ++ " --height 25"

font :: String -> Int -> String -- function to return myFont with specified weight and size
font weight size = myFont ++ ":" ++ weight ++ ":size=" ++ show size ++ ":antialias=true:hinting=true"

------------------------------------------------------------------------
---STARTUP
------------------------------------------------------------------------
myStartupHook :: X ()
myStartupHook = do
  spawn "killall trayer" -- kill current trayer on each restart
  spawnOnce "xfce4-power-manager --daemon" -- start power manager
  spawnOnce "picom -b" -- start compositor
  spawnOnce "xargs xwallpaper --stretch < ~/.cache/wall" -- set wallpaper
  spawnOnce "conky -c .config/conky/xmonad/catppuccin.conkyrc" -- start conky
  spawn ("sleep 2 && " ++ sysTray) -- start system tray
  setDefaultCursor xC_left_ptr -- set cursor theme for desktop(by default it displays 'x')
  setWMName "Xmonad"

------------------------------------------------------------------------
---LAYOUTS
------------------------------------------------------------------------
-- Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining layouts
-- limitWindows n sets maximum number of windows displayed for layout
-- mySpacing n sets the gap size around the windows
tall =
  renamed [Replace "tall"]
    . limitWindows 5
    . smartBorders
    . windowNavigation
    . mySpacing 3
    $ ResizableTall 1 (3 / 100) (1 / 2) []

monocle =
  renamed [Replace "monocle"]
    . smartBorders
    . windowNavigation
    $ Full

floats =
  renamed [Replace "floats"]
    . smartBorders
    $ simplestFloat

-- Theme for showWName which prints current workspace when you change workspaces
myShowWNameTheme :: SWNConfig
myShowWNameTheme =
  def
    { swn_font = font "bold" 55,
      swn_fade = 1.0,
      swn_bgcolor = color01,
      swn_color = colorFore
    }

myLayoutHook =
  mouseResize
    . windowArrange
    . T.toggleLayouts monocle
    . mkToggle (NBFULL ?? NOBORDERS ?? EOT)
    $ myDefaultLayout
  where
    myDefaultLayout =
      refocusLastLayoutHook . trackFloating $
        smartBorders tall
          ||| noBorders monocle
          ||| floats

------------------------------------------------------------------------
---WORKSPACES
------------------------------------------------------------------------
myWorkspaces :: [String]
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]

------------------------------------------------------------------------
---SCRATCHPADS
------------------------------------------------------------------------
myScratchPads :: [NamedScratchpad]
myScratchPads =
  [ NS "terminal" spawnTerm findTerm manageTerm,
    NS "calculator" spawnCalc findCalc manageCalc
  ]
  where
    spawnTerm = myTerminal ++ " -t scratchpad"
    findTerm = title =? "scratchpad"
    manageTerm = myCenterBig

    spawnCalc = "qalculate-gtk"
    findCalc = className =? "Qalculate-gtk"
    manageCalc = myCenter

------------------------------------------------------------------------
---WINDOW RULES
------------------------------------------------------------------------
myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "confirm" --> doFloat,
      className =? "dialog" --> doFloat,
      className =? "download" --> doFloat,
      className =? "error" --> doFloat,
      className =? "file_progress" --> doFloat,
      className =? "Gimp" --> doFloat,
      className =? "notification" --> doFloat,
      className =? "splash" --> doFloat,
      className =? "toolbar" --> doFloat,
      className =? "Lxappearance" --> myCenter,
      className =? "Sxiv" --> myCenterBig,
      className =? "Yad" --> doCenterFloat,
      title =? "Appearance" --> doCenterFloat,
      title =? "Bluetooth Devices" --> doCenterFloat,
      title =? "Network Connections" --> doCenterFloat,
      title =? "Display" --> doCenterFloat,
      title =? "Keyboard" --> doCenterFloat,
      title =? "Power Manager" --> doCenterFloat,
      title =? "Volume Control" --> doCenterFloat,
      -- Move discord to ws 8 and go there, also float it
      className
        =? "discord"
        --> doShift (myWorkspaces !! 7)
        <+> doF (W.greedyView $ myWorkspaces !! 7)
        <+> doFloat,
      -- Move telegram to ws 8 and go there, also float it
      className
        =? "TelegramDesktop"
        --> doShift (myWorkspaces !! 7)
        <+> doF (W.greedyView $ myWorkspaces !! 7)
        <+> doFloat,
      (className =? "firefox" <&&> resource =? "Dialog") --> doFloat, -- float firefox dialog
      isFullscreen --> doFullFloat,
      isDialog --> doCenterFloat <+> doF W.swapUp -- float dialog windows to centre and popup on top
    ]
    <+> namedScratchpadManageHook myScratchPads
    <+> insertPosition Below Newer -- insert new windows at the bottom of stack area

-- Custom centered floating window normal size
myCenter :: ManageHook
myCenter = customFloating $ W.RationalRect fromLeft fromTop width height
  where
    height = 1 / 2
    width = 1 / 2
    fromLeft = (1 - width) / 2
    fromTop = (1 - height) / 2

-- Custom centered floating window big size
myCenterBig :: ManageHook
myCenterBig = customFloating $ W.RationalRect fromLeft fromTop width height
  where
    height = 0.9
    width = 0.9
    fromLeft = 0.95 - width
    fromTop = 0.95 - height

------------------------------------------------------------------------
---WINDOW EVENTS
------------------------------------------------------------------------
myEventHook :: Event -> X All
myEventHook =
  refocusLastWhen (refocusingIsActive <||> isFloat) -- refocus last focused window when floating window is closed
    <> swallowEventHook (className =? "Alacritty" <||> className =? "kitty" <||> className =? "XTerm") (return True) -- hide terminal when external program is run in terminal

-- Move spotify to workspace 7 after launch and go there
myHandleEventHook :: Event -> X All
myHandleEventHook =
  dynamicPropertyChange
    "WM_NAME"
    ( title
        =? "Spotify"
        --> doShift (myWorkspaces !! 6)
        <+> doF (W.greedyView $ myWorkspaces !! 6)
        <+> myCenterBig
    )

------------------------------------------------------------------------
---EASY MOTION
------------------------------------------------------------------------
emConf :: EasyMotionConfig
emConf =
  def
    { txtCol = color03,
      bgCol = color01,
      borderCol = color01,
      cancelKey = xK_Escape,
      emFont = font "bold" 55,
      overlayF = textSize,
      borderPx = 30
    }

------------------------------------------------------------------------
---KEYBINDINGS
------------------------------------------------------------------------
subtitle' :: String -> ((KeyMask, KeySym), NamedAction)
subtitle' x =
  ( (0, 0),
    NamedAction $
      map toUpper $
        sep ++ "\n-- " ++ x ++ " --\n" ++ sep
  )
  where
    sep = replicate (6 + length x) '-'

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe "yad --text-info --fontname=\"Cantarell 12\" --geometry=1366x768 --title \"XMonad keybindings\""
  -- hPutStr h (unlines $ showKm x) -- showKM adds ">>" before subtitles
  hPutStr h (unlines $ showKmSimple x) -- showKmSimple doesn't add ">>" to subtitles
  hClose h
  return ()

myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
  let subKeys str ks = subtitle' str : mkNamedKeymap c ks
   in -- Xmonad essentials
      subKeys
        "Xmonad Essentials"
        [ ("M-C-r", addName "Recompile XMonad" $ spawn "xmonad --recompile"),
          ("M-S-r", addName "Restart XMonad" $ spawn "xmonad --restart"),
          ("M-C-q", addName "Quit XMonad" $ io exitSuccess),
          ("M-q", addName "Kill focused window" $ kill1),
          ("M-r", addName "Run applications" $ spawn "rofi -show drun"),
          ("M-S-a", addName "Kill all windows on WS" $ killAll),
          ("M-<Escape>", addName "Shutdown menu" $ spawn "dm-shutdown")
        ]
        -- Switch to workspace (exclude NSP)
        ^++^ subKeys
          "Switch to workspace"
          [ ("M-1", addName "Switch to workspace 1" $ (windows $ W.greedyView $ myWorkspaces !! 0)),
            ("M-2", addName "Switch to workspace 2" $ (windows $ W.greedyView $ myWorkspaces !! 1)),
            ("M-3", addName "Switch to workspace 3" $ (windows $ W.greedyView $ myWorkspaces !! 2)),
            ("M-4", addName "Switch to workspace 4" $ (windows $ W.greedyView $ myWorkspaces !! 3)),
            ("M-5", addName "Switch to workspace 5" $ (windows $ W.greedyView $ myWorkspaces !! 4)),
            ("M-6", addName "Switch to workspace 6" $ (windows $ W.greedyView $ myWorkspaces !! 5)),
            ("M-7", addName "Switch to workspace 7" $ (windows $ W.greedyView $ myWorkspaces !! 6)),
            ("M-8", addName "Switch to workspace 8" $ (windows $ W.greedyView $ myWorkspaces !! 7)),
            ("M-9", addName "Switch to workspace 9" $ (windows $ W.greedyView $ myWorkspaces !! 8)),
            ("M-]", addName "Switch to next WS" $ nextWS),
            ("M-[", addName "Switch to prev WS" $ prevWS),
            ("M-.", addName "Switch to next non-empty WS" $ moveTo Next nonEmptyNonNSP),
            ("M-,", addName "Switch to prev non-empty WS" $ moveTo Prev nonEmptyNonNSP),
            ("M-C-.", addName "Switch to next empty WS" $ moveTo Next emptyNonNSP),
            ("M-C-,", addName "Switch to prev empty WS" $ moveTo Prev emptyNonNSP),
            ("M-<Tab>", addName "Toggle between recent WS" $ toggleWS' ["NSP"])
          ]
        -- Send window to workspace
        ^++^ subKeys
          "Send window to workspace"
          [ ("M-S-1", addName "Send to workspace 1" $ (windows $ W.shift $ myWorkspaces !! 0)),
            ("M-S-2", addName "Send to workspace 2" $ (windows $ W.shift $ myWorkspaces !! 1)),
            ("M-S-3", addName "Send to workspace 3" $ (windows $ W.shift $ myWorkspaces !! 2)),
            ("M-S-4", addName "Send to workspace 4" $ (windows $ W.shift $ myWorkspaces !! 3)),
            ("M-S-5", addName "Send to workspace 5" $ (windows $ W.shift $ myWorkspaces !! 4)),
            ("M-S-6", addName "Send to workspace 6" $ (windows $ W.shift $ myWorkspaces !! 5)),
            ("M-S-7", addName "Send to workspace 7" $ (windows $ W.shift $ myWorkspaces !! 6)),
            ("M-S-8", addName "Send to workspace 8" $ (windows $ W.shift $ myWorkspaces !! 7)),
            ("M-S-9", addName "Send to workspace 9" $ (windows $ W.shift $ myWorkspaces !! 8))
          ]
        -- Move window to WS and go there (exclude NSP)
        ^++^ subKeys
          "Move window to WS and go there"
          [ ("M-S-]", addName "Move window to next WS" $ shiftTo Next nonNSP >> moveTo Next nonNSP),
            ("M-S-[", addName "Move window to prev WS" $ shiftTo Prev nonNSP >> moveTo Prev nonNSP),
            ("M-S-n", addName "Move window to next empty WS" $ doTo Next emptyNonNSP getSortByIndex (\ws -> withFocused (\w -> windows (W.view ws . W.shiftWin ws w)))),
            ("M-S-p", addName "Move window to prev empty WS" $ doTo Prev emptyNonNSP getSortByIndex (\ws -> withFocused (\w -> windows (W.view ws . W.shiftWin ws w))))
          ]
        -- Window navigation
        ^++^ subKeys
          "Window navigation"
          [ ("M-j", addName "Move focus to next window" $ windows W.focusDown),
            ("M1-<Tab>", addName "Move focus to next window" $ windows W.focusDown),
            ("M-k", addName "Move focus to prev window" $ windows W.focusUp),
            ("M1-S-<Tab>", addName "Move focus to prev window" $ windows W.focusUp),
            ("M-m", addName "Move focus to master window" $ windows W.focusMaster),
            ("M-S-j", addName "Swap focused window with next window" $ windows W.swapDown),
            ("M-S-k", addName "Swap focused window with prev window" $ windows W.swapUp),
            ("M-S-m", addName "Swap focused window with master window" $ windows W.swapMaster),
            ("M-<Backspace>", addName "Move focused window to master" $ promote),
            ("M-S-,", addName "Rotate all windows except master" $ rotSlavesDown),
            ("M-S-.", addName "Rotate all windows in current stack" $ rotAllDown)
          ]
        -- Switch layouts
        ^++^ subKeys
          "Switch layouts"
          [ ("M-C-<Tab>", addName "Switch to next layout" $ sendMessage NextLayout),
            ("M-M1-m", addName "Toggle monocle layout" $ sendMessage (T.Toggle "monocle")),
            ("M-<Space>", addName "Toggle noborders/full" $ sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)
          ]
        -- Window resizing
        ^++^ subKeys
          "Window resizing"
          [ ("M-h", addName "Shrink window" $ sendMessage Shrink),
            ("M-l", addName "Expand window" $ sendMessage Expand),
            ("M-M1-j", addName "Shrink window vertically" $ sendMessage MirrorShrink),
            ("M-M1-k", addName "Expand window vertically" $ sendMessage MirrorExpand)
          ]
        -- Floating windows
        ^++^ subKeys
          "Floating windows"
          [ ("M-t", addName "Sink a floating window" $ withFocused $ windows . W.sink),
            ("M-S-t", addName "Sink all floated windows" $ sinkAll),
            ("M-C-f", addName "Toggle floating state of a window" $ withFocused toggleFloat),
            ("M-M1-<Up>", addName "Move window up" $ withFocused (keysMoveWindow (0, -10))),
            ("M-M1-<Down>", addName "Move window down" $ withFocused (keysMoveWindow (0, 10))),
            ("M-M1-<Right>", addName "Move window right" $ withFocused (keysMoveWindow (10, 0))),
            ("M-M1-<Left>", addName "Move window left" $ withFocused (keysMoveWindow (-10, 0))),
            ("M-S-<Up>", addName "Increase window size to up" $ withFocused (keysResizeWindow (0, 10) (0, 1))),
            ("M-S-<Down>", addName "Increase window size to down" $ withFocused (keysResizeWindow (0, 10) (0, 0))),
            ("M-S-<Right>", addName "Increase window size to right" $ withFocused (keysResizeWindow (10, 0) (0, 1))),
            ("M-S-<Left>", addName "Increase window size to left" $ withFocused (keysResizeWindow (10, 0) (1, 1))),
            ("M-C-<Up>", addName "Decrease window size from up" $ withFocused (keysResizeWindow (0, -10) (0, 1))),
            ("M-C-<Down>", addName "Decrease window size from down" $ withFocused (keysResizeWindow (0, -10) (0, 0))),
            ("M-C-<Right>", addName "Decrease window size from right" $ withFocused (keysResizeWindow (-10, 0) (0, 1))),
            ("M-C-<Left>", addName "Decrease window size from left" $ withFocused (keysResizeWindow (-10, 0) (1, 1)))
          ]
        -- Increase/decrease windows in the master pane or the stack
        ^++^ subKeys
          "Increase/decrease windows in master pane or the stack"
          [ ("M-S-i", addName "Increase clients in master pane" $ sendMessage (IncMasterN 1)),
            ("M-S-d", addName "Decrease clients in master pane" $ sendMessage (IncMasterN (-1))),
            ("M-=", addName "Increase max # of windows for layout" $ increaseLimit),
            ("M--", addName "Decrease max # of windows for layout" $ decreaseLimit)
          ]
        -- Monitors
        ^++^ subKeys
          "Monitors"
          [ ("M-M1-.", addName "Switch focus to next monitor" $ nextScreen),
            ("M-M1-,", addName "Switch focus to prev monitor" $ prevScreen)
          ]
        -- Scratchpads
        ^++^ subKeys
          "Scratchpads"
          [ ("M-s t", addName "Toggle scratchpad terminal" $ namedScratchpadAction myScratchPads "terminal"),
            ("M-s c", addName "Toggle scratchpad calculator" $ namedScratchpadAction myScratchPads "calculator")
          ]
        -- EasyMotion
        ^++^ subKeys
          "EasyMotion"
          [ ("M-z", addName "Switch focus to a window" $ selectWindow emConf >>= (`whenJust` windows . W.focusWindow)),
            ("M-x", addName "Kill a window" $ selectWindow emConf >>= (`whenJust` killWindow))
          ]
        -- Dmenu/Rofi scripts (dmscripts)
        ^++^ subKeys
          "Dmenu scripts"
          [ ("M-d a", addName "Applications menu" $ spawn "rofi -show drun"),
            ("M-d b", addName "Set background" $ spawn "dm-setbg"),
            ("M-d c", addName "Pick color from scheme" $ spawn "dm-colpick"),
            ("M-d e", addName "Edit config files" $ spawn "dm-confedit"),
            ("M-d k", addName "Kill processes" $ spawn "dm-kill"),
            ("M-d m", addName "View manpages" $ spawn "dm-man"),
            ("M-d n", addName "View wifi networks" $ spawn "dm-wifi"),
            ("M-d p", addName "Switch audio output" $ spawn "dm-audio-out-switcher"),
            ("M-d q", addName "Shutdown menu" $ spawn "dm-shutdown"),
            ("M-d r", addName "Run program" $ spawn "rofi -show run -no-show-icons"),
            ("M-d s", addName "Take a screenshot" $ spawn "dm-screenshot"),
            ("M-d t", addName "Show weather" $ spawn "dm-weather"),
            ("M-d w", addName "Switch window" $ spawn "rofi -show window")
          ]
        -- Settings/Configuration tools
        ^++^ subKeys
          "Settings"
          [ ("M-c a", addName "Appearance settings" $ spawn "lxappearance"),
            ("M-c b", addName "Bluetooth settings" $ spawn "blueman-manager"),
            ("M-c d", addName "Display settings" $ spawn "lxrandr"),
            ("M-c m", addName "System monitor" $ spawn "alacritty -t 'System Monitor' -e btop"),
            ("M-c n", addName "NM connection editor" $ spawn "nm-connection-editor"),
            ("M-c p", addName "Power manager settings" $ spawn "xfce4-power-manager -c"),
            ("M-c s", addName "Sound settings" $ spawn "pavucontrol"),
            ("M-c w", addName "Change wallpaper" $ spawn "sxiv -t ~/Pictures/Wallpapers")
          ]
        -- Favorite programs
        ^++^ subKeys
          "Favorite programs"
          [ ("M-<Return>", addName "Launch terminal" $ spawn myTerminal),
            ("M-S-<Return>", addName "Launch kitty" $ spawn "kitty"),
            ("M-e", addName "Launch emacs" $ spawn myEmacs),
            ("M-f", addName "Launch file manager" $ spawn "thunar"),
            ("M-S-f", addName "Launch firefox" $ spawn "firefox"),
            ("M-n", addName "Launch neovim" $ spawn myEditor),
            ("M-v", addName "Launch vscode" $ spawn "code"),
            ("M-S-v", addName "Launch vscode insiders" $ spawn "code-insiders"),
            ("M-w", addName "Launch web browser" $ spawn myBrowser)
          ]
        -- Multimedia applications
        ^++^ subKeys
          "Multimedia applications"
          [ ("M-a d", addName "Launch discord" $ spawn "discord"),
            ("M-a s", addName "Launch spotify" $ spawn "spotify"),
            ("M-a t", addName "Launch telegram" $ spawn "telegram-desktop")
          ]
        -- Multimedia keys
        ^++^ subKeys
          "Multimedia keys"
          [ ("<XF86AudioMute>", addName "Toggle mute" $ spawn "~/.bin/audio mute"),
            ("<XF86AudioRaiseVolume>", addName "Raise volume" $ spawn "~/.bin/audio up"),
            ("<XF86AudioLowerVolume>", addName "Lower volume" $ spawn "~/.bin/audio down"),
            ("<XF86MonBrightnessUp>", addName "Increase brightness" $ spawn "~/.bin/brightness up"),
            ("<XF86MonBrightnessDown>", addName "Decrease brightness" $ spawn "~/.bin/brightness down"),
            ("<Print>", addName "Take a screenshot" $ spawn "dm-screenshot")
          ]
        -- Trayer
        ^++^ subKeys
          "Trayer toggle"
          [ ("M-C-t s", addName "Start trayer" $ spawn sysTray),
            ("M-C-t k", addName "Kill trayer" $ spawn "killall trayer")
          ]
  where
    nonNSP = WSIs (return (\ws -> W.tag ws /= "NSP")) -- skip NSP workspace
    nonEmptyNonNSP = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP")) -- skip empty and NSP workspaces
    emptyNonNSP = WSIs (return (\ws -> isNothing (W.stack ws) && W.tag ws /= "NSP")) -- skip non-empty and NSP workspaces

    -- Function to toggle floating state on focused window.
    toggleFloat w =
      windows
        ( \s ->
            if M.member w (W.floating s)
              then W.sink w s
              else W.float w (W.RationalRect (1 / 6) (1 / 6) (2 / 3) (2 / 3)) s
        )

------------------------------------------------------------------------
---XMOBAR
------------------------------------------------------------------------
myXmobarPP :: PP
myXmobarPP =
  def
    { -- Currently focused workspace
      ppCurrent =
        xmobarColor color06 ""
          . wrap
            ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">")
            "</box>",
      -- Visible but not current workspace
      ppVisible = xmobarColor color06 "",
      -- Hidden workspace
      ppHidden =
        xmobarColor color05 ""
          . wrap
            ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">")
            "</box>",
      -- Hidden workspaces (no windows)
      ppHiddenNoWindows = xmobarColor color09 "",
      -- Title of active window
      ppTitle = xmobarColor color16 "" . shorten 60,
      -- Separator character
      ppSep = "<fc=" ++ color01 ++ "> | </fc>",
      -- Urgent workspace
      ppUrgent = xmobarColor color02 "" . wrap "!" "!",
      -- Current layout
      ppLayout = xmobarColor color02 "" . wrap "[" "]",
      -- Adding # of windows on current workspace to the bar
      ppExtras = [windowCount],
      -- Order of things in xmobar
      ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
    }

------------------------------------------------------------------------
---POLYBAR
------------------------------------------------------------------------
-- myPolybar :: StatusBarConfig
-- myPolybar =
--   def
--     { sbLogHook =
--         xmonadPropLog
--           =<< dynamicLogString myPolybarPP,
--       sbStartupHook = spawn "~/.config/polybar/launch.sh",
--       sbCleanupHook = spawn "killall polybar"
--     }
--
-- myPolybarPP :: PP
-- myPolybarPP =
--   def
--     { -- Current layout
--       ppLayout = textColor color02 . wrap "[" "]",
--       -- Order of things in xmobar
--       ppOrder = \(_ : l : _ : _) -> [l]
--     }
--
-- textColor :: String -> String -> String
-- textColor color = wrap ("%{F" <> color <> "}") " %{F-}"

------------------------------------------------------------------------
---MAIN
------------------------------------------------------------------------
main :: IO ()
main = do
  xmonad
    . withEasySB (statusBarProp xmobar $ clickablePP myXmobarPP) defToggleStrutsKey
    -- . withEasySB myPolybar defToggleStrutsKey
    . ewmh
    . addDescrKeys' ((mod4Mask, xK_F1), showKeybindings) myKeys
    $ def
      { manageHook = myManageHook,
        handleEventHook = windowedFullscreenFixEventHook <+> myEventHook <+> myHandleEventHook,
        modMask = myModMask,
        terminal = myTerminal,
        startupHook = myStartupHook,
        layoutHook = showWName' myShowWNameTheme myLayoutHook,
        workspaces = myWorkspaces,
        borderWidth = myBorderWidth,
        normalBorderColor = myNormColor,
        focusedBorderColor = myFocusColor
      }
  where
    -- Choose xmobar config based on selected colorscheme
    xmobar = "xmobar -x 1 $HOME/.config/xmobar/" ++ colorScheme ++ "-xmobarrc"
