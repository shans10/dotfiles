from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration
from colors import catppuccin

widget_defaults = dict(
    font="Iosevka Nerd Font",
    fontsize=13,
    padding=3,
    background=catppuccin["base"],
    foreground=catppuccin["text"],
)

extension_defaults = widget_defaults.copy()


def clock():
    return widget.Clock(
        format="%a, %d %b - %I:%M %p",
        foreground=catppuccin["teal"],
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
        format=" {load_percent}%",
        foreground=catppuccin["yellow"],
        mouse_callbacks={"Button1": lazy.spawn("alacritty" " -e btop")},
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
        format=" {MemPercent}%",
        foreground=catppuccin["red"],
        mouse_callbacks={"Button1": lazy.spawn("alacritty" " -e btop")},
        decorations=[
            BorderDecoration(
                colour=catppuccin["red"],
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


def win_name():
    return widget.WindowName(padding=3)
