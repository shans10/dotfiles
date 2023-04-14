from libqtile.bar import Bar

from widgets import (
    clock,
    cpu,
    group_box,
    layout,
    line_sep,
    logo,
    memory,
    sep_large,
    sep_small,
    systray,
    win_name,
)

main_bar_widgets = [
    sep_small,
    logo,
    sep_small,
    group_box,
    line_sep,
    layout,
    line_sep,
    win_name,
    sep_large,
    cpu,
    sep_large,
    memory,
    sep_large,
    clock,
    sep_small,
    systray,
    sep_small,
]


def create_bar():
    bar_widgets = main_bar_widgets
    return Bar(
        widgets=[BarWidget() for BarWidget in bar_widgets],
        opacity=0.91,
        size=25,
    )
