from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration
from colors import catppuccin
from variables import myTerm
import os
import subprocess

widget_defaults = dict(
    font="Iosevka Nerd Font",
    fontsize=13,
    padding=3,
    background=catppuccin["base"],
    foreground=catppuccin["text"],
)
extension_defaults = widget_defaults.copy()


def battery():
    return widget.GenPollText(
        name="battery",
        foreground=catppuccin["pink"],
        update_interval=120,
        mouse_callbacks={"Button1": lazy.spawn("xfce4-power-manager -c")},
        func=lambda: subprocess.check_output(
            os.path.expanduser("~/.config/qtile/scripts/battery"),
        ).decode("utf-8"),
        decorations=[
            BorderDecoration(
                colour=catppuccin["pink"],
                border_width=[0, 0, 3, 0],
                padding_x=None,
                padding_y=None,
            )
        ],
    )


def cal():
    return widget.Clock(
        format="  %a, %d %b - %I:%M %p",
        foreground=catppuccin["teal"],
        update_interval=60,
        decorations=[
            BorderDecoration(
                colour=catppuccin["teal"],
                border_width=[0, 0, 3, 0],
                padding_x=None,
                padding_y=None,
            )
        ],
    )


def cpu():
    return widget.CPU(
        format=" {load_percent}% ({freq_current}GHz)",
        foreground=catppuccin["yellow"],
        update_interval=5,
        mouse_callbacks={"Button1": lazy.spawn(myTerm + " -e btop")},
        decorations=[
            BorderDecoration(
                colour=catppuccin["yellow"],
                border_width=[0, 0, 3, 0],
                padding_x=None,
                padding_y=None,
            )
        ],
    )


def group_box():
    return widget.GroupBox(
        fontsize=13,
        margin_y=5,
        margin_x=0,
        padding_y=3,
        padding_x=5,
        borderwidth=3,
        active=catppuccin["blue"],
        inactive=catppuccin["surface1"],
        rounded=False,
        block_highlight_text_color=catppuccin["green"],
        highlight_color=catppuccin["base"],
        highlight_method="line",
        this_current_screen_border=catppuccin["green"],
        urgent_alert_method = "line",
        urgent_border=catppuccin["red"],
        urgent_text=catppuccin["red"],
    )


def layout():
    return widget.CurrentLayout(fmt="[{}]", foreground=catppuccin["red"], padding=5)


def line_sep():
    return widget.TextBox(
        text="|",
        background=catppuccin["base"],
        foreground=catppuccin["surface1"],
        padding=2,
    )


def logo():
    return widget.Image(
        filename="~/.config/qtile/icons/arch.png",
        margin=1,
        scale=True,
        mouse_callbacks={"Button1": lazy.spawn("rofi -show drun")},
    )


def memory():
    return widget.Memory(
        format="󰍛{MemUsed: .0f}{mm} ({MemPercent}%)",
        foreground=catppuccin["red"],
        update_interval=5,
        mouse_callbacks={"Button1": lazy.spawn(myTerm + " -e btop")},
        decorations=[
            BorderDecoration(
                colour=catppuccin["red"],
                border_width=[0, 0, 3, 0],
                padding_x=None,
                padding_y=None,
            )
        ],
    )


def network():
    return widget.GenPollText(
        name="network",
        foreground=catppuccin["blue"],
        update_interval=10,
        mouse_callbacks={"Button1": lazy.spawn("dm-wifi")},
        func=lambda: subprocess.check_output(
            os.path.expanduser("~/.config/qtile/scripts/network"),
        ).decode("utf-8"),
        decorations=[
            BorderDecoration(
                colour=catppuccin["blue"],
                border_width=[0, 0, 3, 0],
                padding_x=None,
                padding_y=None,
            )
        ],
    )


def sep_large():
    return widget.Sep(linewidth=0, padding=25)


def sep_small():
    return widget.Sep(linewidth=0, padding=7)


def systray():
    return widget.Systray(padding=5, icon_size=17)


def volume():
    return widget.GenPollText(
        name="volume",
        foreground=catppuccin["green"],
        update_interval=1,
        mouse_callbacks={"Button1": lazy.spawn("pavucontrol")},
        func=lambda: subprocess.check_output(
            os.path.expanduser("~/.config/qtile/scripts/volume"),
        ).decode("utf-8"),
        decorations=[
            BorderDecoration(
                colour=catppuccin["green"],
                border_width=[0, 0, 3, 0],
                padding_x=None,
                padding_y=None,
            )
        ],
    )


def win_name():
    return widget.WindowName(padding=3)
