### NOTE ###
# This config is incomplete

import os
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

mod = "mod4"                       # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"               # My terminal of choice
myBrowser = "google-chrome-stable" # My browser of choice

keys = [
        ### The essentials
        Key([mod], "Return",
            lazy.spawn(myTerm),
            desc='Launch terminal'
            ),
        Key([mod], "Escape",
            lazy.spawn("dm-logout"),
            desc='Shutdown menu'
            ),
        Key([mod, "shift"], "Return",
            lazy.spawn("kitty"),
            desc='Launch kitty terminal'
            ),
        Key([mod], "r",
            lazy.spawn("rofi -show run -no-show-icons"),
            desc='Run prompt'
            ),
        Key([mod], "b",
            lazy.spawn(myBrowser),
            desc='Launch web browser'
            ),
        Key([mod], "Tab",
            lazy.next_layout(),
            desc='Toggle through layouts'
            ),
        Key([mod], "q",
            lazy.window.kill(),
            desc='Kill active window'
            ),
        Key([mod, "control"], "r",
            lazy.restart(),
            desc='Restart Qtile'
            ),
        Key([mod, "control"], "q",
            lazy.shutdown(),
            desc='Shutdown Qtile'
            ),
        Key([mod], "e",
            lazy.spawn("emacsclient -cn -a emacs"),
            desc='Launch emacs'
            ),
        Key([mod], "n",
            lazy.spawn("alacritty -e nvim"),
            desc='Launch neovim'
            ),
        ### Window controls
        Key([mod], "j",
            lazy.layout.down(),
            desc='Move focus down in current stack pane'
            ),
        Key([mod], "k",
            lazy.layout.up(),
            desc='Move focus up in current stack pane'
            ),
        Key(["mod1"], "Tab",
            lazy.layout.down(),
            desc='Cycle focus'
            ),
        Key([mod, "shift"], "j",
            lazy.layout.shuffle_down(),
            lazy.layout.section_down(),
            desc='Move windows down in current stack'
            ),
        Key([mod, "shift"], "k",
            lazy.layout.shuffle_up(),
            lazy.layout.section_up(),
            desc='Move windows up in current stack'
            ),
        Key([mod], "h",
            lazy.layout.shrink(),
            lazy.layout.decrease_nmaster(),
            desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
            ),
        Key([mod], "l",
            lazy.layout.grow(),
            lazy.layout.increase_nmaster(),
            desc='Expand window (MonadTall), increase number in master pane (Tile)'
            ),
        Key([mod, "control"], "n",
            lazy.layout.normalize(),
            desc='normalize window size ratios'
            ),
        Key([mod, "control"], "m",
            lazy.layout.maximize(),
            desc='toggle window between minimum and maximum sizes'
            ),
        Key([mod, "shift"], "f",
            lazy.window.toggle_floating(),
            desc='toggle floating'
            ),
        Key([mod], "f",
            lazy.window.toggle_fullscreen(),
            desc='toggle fullscreen'
            ),
        ### Stack controls
         Key([mod, "shift"], "Tab",
             lazy.layout.rotate(),
             lazy.layout.flip(),
             desc='Switch which side main pane occupies (XmonadTall)'
             ),
         Key([mod], "space",
             lazy.layout.next(),
             desc='Switch window focus to other pane(s) of stack'
             ),
         Key([mod, "shift"], "space",
             lazy.layout.toggle_split(),
             desc='Toggle between split and unsplit sides of stack'
             ),
         # Dmenu/rofi scripts launched using the key chord SUPER+d followed by 'key'
         KeyChord([mod], "d", [
             Key([], "a",
                 lazy.spawn("dm-sounds"),
                 desc='Choose ambient sound'
                 ),
             Key([], "b",
                 lazy.spawn("dm-setbg"),
                 desc='Set background'
                 ),
             Key([], "c",
                 lazy.spawn("dm-colpick"),
                 desc='Pick colors'
                 ),
             Key([], "e",
                 lazy.spawn("dm-confedit"),
                 desc='Choose a config file to edit'
                 ),
             Key([], "i",
                 lazy.spawn("dm-maim"),
                 desc='Take a screenshot'
                 ),
             Key([], "k",
                 lazy.spawn("dm-kill"),
                 desc='Kill processes '
                 ),
             Key([], "m",
                 lazy.spawn("dm-man"),
                 desc='View manpages'
                 ),
             Key([], "n",
                 lazy.spawn("dm-note"),
                 desc='Store and copy notes'
                 ),
             Key([], "o",
                 lazy.spawn("dm-bookman"),
                 desc='Browser bookmarks'
                 ),
             Key([], "q",
                 lazy.spawn("dm-logout"),
                 desc='Logout menu'
                 ),
             Key([], "r",
                 lazy.spawn("dm-radio"),
                 desc='Listen to online radio'
                 ),
             Key([], "s",
                 lazy.spawn("dm-websearch"),
                 desc='Search various engines'
                 ),
             Key([], "t",
                 lazy.spawn("dm-translate"),
                 desc='Translate text'
                 )
         ])
]

groups = [Group("1", layout='monadtall'),
          Group("2", layout='monadtall'),
          Group("3", layout='monadtall'),
          Group("4", layout='monadtall'),
          Group("5", layout='monadtall'),
          Group("6", layout='monadtall'),
          Group("7", layout='monadtall'),
          Group("8", layout='monadtall'),
          Group("9", layout='monadtall'),
          Group("10", layout='floating')]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

monadtall_layout_theme = {
        "border_width": 2,
        "margin": 3,
        "border_focus": "89b4fa",
        "border_normal": "1e1e2e",
        "single_border_width": 0,
        }

max_layout_theme = {
        "border_width": 0,
        "margin": 0,
        }

layouts = [
        layout.MonadTall(**monadtall_layout_theme),
        layout.Max(**max_layout_theme),
        layout.Floating(**monadtall_layout_theme)
        ]

colors = [["#1e1e2e", "#1e1e2e"],
          ["#45475a", "#45475a"],
          ["#cdd6f4", "#cdd6f4"],
          ["#f38ba8", "#f38ba8"],
          ["#a6e3a1", "#a6e3a1"],
          ["#f9e2af", "#f9e2af"],
          ["#89b4fa", "#89b4fa"],
          ["#f5c2e7", "#f5c2e7"],
          ["#94e2d5", "#94e2d5"],
          ["#bac2de", "#bac2de"]]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
        font="Iosevka Nerd Font",
        fontsize = 13,
        padding = 2,
        background=colors[2]
        )
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
            widget.Sep(
                linewidth = 0,
                padding = 6,
                foreground = colors[2],
                background = colors[0]
                ),
            widget.Image(
                filename = "~/.config/qtile/icons/python.png",
                scale = "False",
                mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)}
                ),
            widget.Sep(
                linewidth = 0,
                padding = 6,
                foreground = colors[2],
                background = colors[0]
                ),
            widget.GroupBox(
                font = "Iosevka",
                fontsize = 12,
                margin_y = 5,
                margin_x = 0,
                padding_y = 3,
                padding_x = 5,
                borderwidth = 3,
                active = colors[6],
                inactive = colors[7],
                rounded = False,
                highlight_color = colors[1],
                highlight_method = "line",
                this_current_screen_border = colors[6],
                this_screen_border = colors [4],
                other_current_screen_border = colors[6],
                other_screen_border = colors[4],
                foreground = colors[2],
                background = colors[0]
                ),
            widget.TextBox(
                text = '|',
                font = "Ubuntu Mono",
                background = colors[0],
                foreground = '474747',
                padding = 2,
                fontsize = 14
                ),
            widget.CurrentLayout(
                fmt = '[{}]',
                foreground = colors[3],
                background = colors[0],
                padding = 5
                ),
            widget.TextBox(
                    text = '|',
                    font = "Ubuntu Mono",
                    background = colors[0],
                    foreground = '474747',
                    padding = 1,
                    fontsize = 14
                    ),
            widget.WindowName(
                    foreground = colors[2],
                    background = colors[0],
                    padding = 3
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    foreground = colors[0],
                    background = colors[0]
                    ),
            widget.Memory(
                    foreground = colors[5],
                    background = colors[0],
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e btop')},
                    fmt = 'Mem: {}',
                    padding = 5,
                    decorations=[
                        BorderDecoration(
                            colour = colors[5],
                            border_width = [0, 0, 2, 0],
                            padding_x = 5,
                            padding_y = None,
                            )
                        ],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    foreground = colors[0],
                    background = colors[0]
                    ),
            widget.PulseVolume(
                    foreground = colors[7],
                    background = colors[0],
                    fmt = 'Vol: {}',
                    padding = 5,
                    decorations=[
                        BorderDecoration(
                            colour = colors[7],
                            border_width = [0, 0, 2, 0],
                            padding_x = 5,
                            padding_y = None,
                            )
                        ],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    foreground = colors[0],
                    background = colors[0]
                    ),

            widget.Net(
                    interface = "wlp2s0",
                    format = 'Net: {down} ↓↑ {up}',
                    foreground = colors[6],
                    background = colors[0],
                    padding = 5,
                    decorations=[
                        BorderDecoration(
                            colour = colors[6],
                            border_width = [0, 0, 2, 0],
                            padding_x = 5,
                            padding_y = None,
                            )
                        ],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    foreground = colors[0],
                    background = colors[0]
                    ),
            widget.Clock(
                    foreground = colors[8],
                    background = colors[0],
                    format = " %A, %B %d - %I:%M %p",
                    decorations=[
                        BorderDecoration(
                            colour = colors[8],
                            border_width = [0, 0, 2, 0],
                            padding_x = 5,
                            padding_y = None,
                            )
                        ],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 3,
                    foreground = colors[0],
                    background = colors[0]
                    ),
            widget.Systray(
                    background = colors[0],
                    padding = 5
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 3,
                    foreground = colors[0],
                    background = colors[0]
                    ),
            ]
    return widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=0.9, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
        ]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    Match(wm_class='kdenlive'),       # kdenlive
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
    ])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

wmname = "Qtile"
