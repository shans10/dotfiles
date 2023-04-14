##########################################################################
### IMPORTS
##########################################################################
from libqtile import bar, widget
from libqtile.config import Screen
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration
from hooks import autostart, set_size
from groups import groups
from keys import keys
from layouts import layouts, floating_layout
from mouse import mouse
from screens import screens
from widgets import extension_defaults, widget_defaults

# Set variables to remove "MODULE is not accessed hints"
autostart = autostart
floating_layout = floating_layout
groups = groups
keys = keys
layouts = layouts
mouse = mouse
set_size = set_size

colors = [
    ["#1e1e2e", "#1e1e2e"],
    ["#45475a", "#45475a"],
    ["#cdd6f4", "#cdd6f4"],
    ["#f38ba8", "#f38ba8"],
    ["#a6e3a1", "#a6e3a1"],
    ["#f9e2af", "#f9e2af"],
    ["#89b4fa", "#89b4fa"],
    ["#f5c2e7", "#f5c2e7"],
    ["#94e2d5", "#94e2d5"],
    ["#bac2de", "#bac2de"],
]

##### DEFAULT WIDGET SETTINGS #####
# widget_defaults = dict(
#     font="Iosevka Nerd Font", fontsize=13, padding=2, background=catppuccin["base"]
# )
# extension_defaults = widget_defaults.copy()


# def init_widgets_list():
#     widgets_list = [
#         widget.Sep(linewidth=0, padding=6, foreground=colors[2], background=colors[0]),
#         widget.Image(
#             filename="~/.config/qtile/icons/arch.png",
#             background=colors[0],
#             scale=True,
#             mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(myTerm)},
#         ),
#         widget.Sep(linewidth=0, padding=6, foreground=colors[2], background=colors[0]),
#         widget.GroupBox(
#             fontsize=13,
#             margin_y=5,
#             margin_x=0,
#             padding_y=3,
#             padding_x=5,
#             borderwidth=3,
#             active=colors[6],
#             inactive=colors[1],
#             rounded=False,
#             block_highlight_text_color=colors[4],
#             highlight_color=colors[0],
#             highlight_method="line",
#             this_current_screen_border=colors[4],
#             foreground=colors[2],
#             background=colors[0],
#         ),
#         widget.TextBox(
#             text="|",
#             background=colors[0],
#             foreground=colors[1],
#             padding=2,
#         ),
#         widget.CurrentLayout(
#             fmt="[{}]", foreground=colors[3], background=colors[0], padding=5
#         ),
#         widget.TextBox(
#             text="|",
#             background=colors[0],
#             foreground=colors[1],
#             padding=2,
#         ),
#         widget.WindowName(foreground=colors[2], background=colors[0], padding=3),
#         widget.Sep(linewidth=0, padding=6, foreground=colors[0], background=colors[0]),
#         widget.Memory(
#             foreground=colors[5],
#             background=colors[0],
#             mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(myTerm + " -e btop")},
#             fmt="Mem: {}",
#             padding=5,
#             decorations=[
#                 BorderDecoration(
#                     colour=colors[5],
#                     border_width=[0, 0, 2, 0],
#                     padding_x=5,
#                     padding_y=None,
#                 )
#             ],
#         ),
#         widget.Sep(linewidth=0, padding=6, foreground=colors[0], background=colors[0]),
#         widget.PulseVolume(
#             foreground=colors[7],
#             background=colors[0],
#             fmt="Vol: {}",
#             padding=5,
#             decorations=[
#                 BorderDecoration(
#                     colour=colors[7],
#                     border_width=[0, 0, 2, 0],
#                     padding_x=5,
#                     padding_y=None,
#                 )
#             ],
#             update_interval=0.1,
#         ),
#         widget.Sep(linewidth=0, padding=6, foreground=colors[0], background=colors[0]),
#         widget.Net(
#             interface="wlp2s0",
#             format="Net: {down} ↓↑ {up}",
#             foreground=colors[6],
#             background=colors[0],
#             padding=5,
#             decorations=[
#                 BorderDecoration(
#                     colour=colors[6],
#                     border_width=[0, 0, 2, 0],
#                     padding_x=5,
#                     padding_y=None,
#                 )
#             ],
#         ),
#         widget.Sep(linewidth=0, padding=6, foreground=colors[0], background=colors[0]),
#         widget.Clock(
#             foreground=colors[8],
#             background=colors[0],
#             format=" %A, %B %d - %I:%M %p",
#             decorations=[
#                 BorderDecoration(
#                     colour=colors[8],
#                     border_width=[0, 0, 2, 0],
#                     padding_x=5,
#                     padding_y=None,
#                 )
#             ],
#         ),
#         widget.Sep(linewidth=0, padding=3, foreground=colors[0], background=colors[0]),
#         widget.Systray(background=colors[0], padding=5),
#         widget.Sep(linewidth=0, padding=3, foreground=colors[0], background=colors[0]),
#     ]
#     return widgets_list


# def init_screens():
#     return [Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=0.91, size=25))]
#
#
# if __name__ in ["config", "__main__"]:
#     screens = init_screens()
    # widgets_list = init_widgets_list()

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = False
wmname = "Qtile"
