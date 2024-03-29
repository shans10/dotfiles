from libqtile.config import Drag
from libqtile.lazy import lazy
from variables import mod

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button2", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
]
