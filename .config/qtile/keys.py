from libqtile.config import KeyChord, Key
from libqtile.lazy import lazy
from groups import groups
from variables import mod, myBrowser, myTerm
import os

##########################################################################
### USER FUNCTIONS
##########################################################################
# Resize floating windows
@lazy.function
def resize_floating_window(qtile, width: int = 0, height: int = 0):
    w = qtile.current_window
    w.cmd_set_size_floating(w.width + width, w.height + height)


# Move floating windows
@lazy.function
def move_floating_window(qtile, x: int = 0, y: int = 0):
    w = qtile.current_window
    new_x = w.float_x + x
    new_y = w.float_y + y
    w.cmd_set_position_floating(new_x, new_y)


# Move focused window to previous group
@lazy.function
def window_to_prev_group(qtile):
    i = qtile.groups.index(qtile.current_group)
    if qtile.current_window is not None and i != 0:
        qtile.current_window.togroup(qtile.groups[i - 1].name, switch_group=True)


# Move focused window to next group
@lazy.function
def window_to_next_group(qtile):
    i = qtile.groups.index(qtile.current_group)
    if qtile.current_window is not None and i != 6:
        qtile.current_window.togroup(qtile.groups[i + 1].name, switch_group=True)


# Toggle floating state on a window
@lazy.function
def toggle_floating(qtile, center=False, resolution=(1920, 1080), scale=0.85):
    window = qtile.current_window
    if center:
        # if not window.floating:
        window.toggle_floating()
        if window.floating:
            window.cmd_set_size_floating(
                int(resolution[0] * scale), int(resolution[1] * scale)
            )
            window.cmd_center()
            # bar height + margin + border
            # window.cmd_set_position_floating(window.x, window.y + (40 + 10 + 10) // 2)
    else:
        window.toggle_floating()


# Bring focused floating window to front
@lazy.function
def float_to_front(qtile):
    w = qtile.current_window
    if w.floating:
        w.cmd_bring_to_front()


##########################################################################
### KEYBINDINGS
##########################################################################
keys = [
    # The essentials
    Key([mod], "Escape", lazy.spawn("dm-shutdown"), desc="Shutdown menu"),
    Key([mod], "r", lazy.spawn("rofi -show run -no-show-icons"), desc="Run prompt"),
    Key([mod], "Tab", lazy.screen.toggle_group()),
    Key([mod, "control"], "Tab", lazy.next_layout(), desc="Toggle through layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill active window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Workspace navigation
    Key(
        [mod],
        "comma",
        lazy.screen.prev_group(),
        desc="Switch to prev group",
    ),
    Key(
        [mod],
        "period",
        lazy.screen.next_group(),
        desc="Switch to next group",
    ),
    Key(
        [mod],
        "bracketleft",
        lazy.screen.prev_group(skip_empty=True),
        desc="Switch to prev non-empty group",
    ),
    Key(
        [mod],
        "bracketright",
        lazy.screen.next_group(skip_empty=True),
        desc="Switch to next non-empty group",
    ),
    Key(
        [mod, "shift"],
        "comma",
        window_to_prev_group(),
        desc="Move window to prev group",
    ),
    Key(
        [mod, "shift"],
        "period",
        window_to_next_group(),
        desc="Move window to next group",
    ),
    # Window controls
    Key([mod], "j", lazy.group.prev_window(), desc="Move focus to prev window"),
    Key([mod], "k", lazy.group.next_window(), desc="Move focus to next window"),
    Key(["mod1"], "Tab", lazy.group.next_window(), desc="Cycle focus"),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc="Move windows down in current stack",
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc="Move windows up in current stack",
    ),
    Key(
        [mod],
        "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc="Shrink window (MonadTall), decrease number in master pane (Tile)",
    ),
    Key(
        [mod],
        "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc="Expand window (MonadTall), increase number in master pane (Tile)",
    ),
    Key(
        [mod, "control"],
        "n",
        lazy.layout.reset(),
        desc="Normalize window size ratios",
    ),
    Key(
        [mod, "control"],
        "m",
        lazy.layout.maximize(),
        desc="Toggle window between minimum and maximum sizes",
    ),
    Key([mod], "space", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod, "control"], "f", toggle_floating(center=True), desc="Toggle floating"),
    # Stack controls
    Key(
        [mod, "shift"],
        "Tab",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc="Switch which side main pane occupies (XmonadTall)",
    ),
    Key(
        [mod],
        "grave",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack",
    ),
    Key(
        [mod, "shift"],
        "grave",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Floating windows
    Key([mod], "right", resize_floating_window(width=10), desc="Increase width by 10"),
    Key([mod], "left", resize_floating_window(width=-10), desc="Decrease width by 10"),
    Key([mod], "up", resize_floating_window(height=10), desc="Increase height by 10"),
    Key(
        [mod], "down", resize_floating_window(height=-10), desc="Decrease height by 10"
    ),
    Key([mod, "shift"], "right", move_floating_window(x=10), desc="Move window right"),
    Key([mod, "shift"], "left", move_floating_window(x=-10), desc="Move window left"),
    Key([mod, "shift"], "up", move_floating_window(y=-10), desc="Move window up"),
    Key([mod, "shift"], "down", move_floating_window(y=10), desc="Move window down"),
    Key([mod, "shift"], "c", lazy.window.center(), desc="Centre floating window"),
    Key(
        [mod, "shift"],
        "b",
        float_to_front(),
        desc="Bring floating window to front",
    ),
    # Favourite programs
    Key([mod], "Return", lazy.spawn(myTerm), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn("wezterm"), desc="Launch wezterm"),
    Key([mod], "e", lazy.spawn("emacsclient -cn -a emacs"), desc="Launch emacs"),
    Key([mod], "f", lazy.spawn("thunar"), desc="Launch file manager"),
    Key([mod, "shift"], "f", lazy.spawn("firefox"), desc="Launch firefox"),
    Key([mod], "n", lazy.spawn("alacritty -e nvim"), desc="Launch neovim"),
    Key([mod], "v", lazy.spawn("code"), desc="Launch vscode"),
    Key([mod], "w", lazy.spawn(myBrowser), desc="Launch web browser"),
    # Multimedia controls
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn(os.path.expanduser("~/.bin/audio mute")),
        desc="Toggle mute",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn(os.path.expanduser("~/.bin/audio up")),
        desc="Raise volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn(os.path.expanduser("~/.bin/audio down")),
        desc="Lower volume",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn(os.path.expanduser("~/.bin/brightness up")),
        desc="Increase brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn(os.path.expanduser("~/.bin/brightness down")),
        desc="Decrease brightness",
    ),
    Key(
        [],
        "Print",
        lazy.spawn(os.path.expanduser("dm-screenshot")),
        desc="Take a screenshot",
    ),
    # Multimedia applications
    KeyChord(
        [mod],
        "a",
        [
            Key([], "d", lazy.spawn("discord"), desc="Launch discord"),
            Key([], "s", lazy.spawn("spotify"), desc="Launch spotify"),
            Key([], "t", lazy.spawn("telegram-desktop"), desc="Launch telegram"),
        ],
    ),
    # Settings/Configuration tools
    KeyChord(
        [mod],
        "c",
        [
            Key([], "a", lazy.spawn("lxappearance"), desc="Appearance settings"),
            Key([], "b", lazy.spawn("blueman-manager"), desc="Bluetooth settings"),
            Key([], "d", lazy.spawn("lxrandr"), desc="Display settings"),
            Key(
                [],
                "m",
                lazy.spawn("alacritty -t 'System Monitor' -e btop"),
                desc="System monitor",
            ),
            Key(
                [], "n", lazy.spawn("nm-connection-editor"), desc="NM connection editor"
            ),
            Key(
                [],
                "p",
                lazy.spawn("xfce4-power-manager -c"),
                desc="Power manager settings",
            ),
            Key([], "s", lazy.spawn("pavucontrol"), desc="Sound settings"),
            Key(
                [],
                "w",
                lazy.spawn("sxiv -t " + os.path.expanduser("~/Pictures/Wallpapers")),
                desc="Wallpaper picker",
            ),
        ],
    ),
    # Dmenu/rofi scripts
    KeyChord(
        [mod],
        "d",
        [
            Key([], "a", lazy.spawn("rofi -show drun"), desc="Applications menu"),
            Key([], "b", lazy.spawn("dm-setbg"), desc="Set background"),
            Key([], "c", lazy.spawn("dm-colpick"), desc="Pick color from scheme"),
            Key([], "e", lazy.spawn("dm-confedit"), desc="Edit config files"),
            Key([], "k", lazy.spawn("dm-kill"), desc="Kill processes"),
            Key([], "m", lazy.spawn("dm-man"), desc="View manpages"),
            Key([], "n", lazy.spawn("dm-wifi"), desc="View wifi networks"),
            Key(
                [], "p", lazy.spawn("dm-audio-out-switcher"), desc="Switch audio output"
            ),
            Key([], "q", lazy.spawn("dm-shutdown"), desc="Shutdown menu"),
            Key(
                [], "r", lazy.spawn("rofi -show run -no-show-icons"), desc="Run program"
            ),
            Key([], "s", lazy.spawn("dm-screenshot"), desc="Take a screenshot"),
            Key([], "t", lazy.spawn("dm-weather"), desc="Show weather"),
            Key([], "w", lazy.spawn("rofi -show window"), desc="Switch window"),
        ],
    ),
]

# Groups associated keybindings
for group in groups:
    keys.extend(
        [
            # Super + letter of group = switch to group
            Key(
                [mod],
                group.name,
                lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(group.name),
            ),
            # Super + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                group.name,
                lazy.window.togroup(group.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(group.name),
            ),
        ]
    )
