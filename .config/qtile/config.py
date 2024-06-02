from hooks import autostart, set_size
from groups import groups
from keys import keys
from layouts import layouts, floating_layout
from mouse import mouse
from screens import screens
from widgets import extension_defaults, widget_defaults

# Set variables to remove "MODULE is not accessed hints"
autostart = autostart
extension_defaults = extension_defaults
floating_layout = floating_layout
groups = groups
keys = keys
layouts = layouts
mouse = mouse
screens = screens
set_size = set_size
widget_defaults = widget_defaults

# General settings
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "focus"
reconfigure_screens = True
auto_minimize = False
wmname = "Qtile"
