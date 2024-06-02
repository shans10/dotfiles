from libqtile.bar import Bar

from widgets import (
    battery,
    cal,
    cpu,
    group_box,
    layout,
    line_sep,
    logo,
    memory,
    network,
    sep_large,
    sep_small,
    systray,
    volume,
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
    volume,
    sep_large,
    battery,
    sep_large,
    network,
    sep_large,
    cal,
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
