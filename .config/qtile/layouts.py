from colors import catppuccin
from libqtile import layout
from libqtile.config import Match

float_layout_theme = {
    "border_width": 2,
    "border_focus": catppuccin["blue"],
    "border_normal": catppuccin["base"],
}

max_layout_theme = {
    "border_width": 0,
    "margin": 0,
}

monadtall_layout_theme = {
    "border_width": 2,
    "border_focus": catppuccin["blue"],
    "border_normal": catppuccin["base"],
    "margin": 3,
    "single_border_width": 0,
}

layouts = [
    layout.MonadTall(**monadtall_layout_theme),
    layout.Max(**max_layout_theme),
]

floating_layout = layout.Floating(
    **float_layout_theme,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(title="Bluetooth Devices"),
        Match(title="Confirmation"),
        Match(title="Network Connections"),
        Match(title="Qalculate!"),
        Match(wm_class="lxappearance"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="Sxiv"),
    ],
)
