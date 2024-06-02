from libqtile import hook
from libqtile.config import Match
import subprocess
import os

# Autostart applications
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])


# Set floating window sizes for specified apps
@hook.subscribe.client_new
def set_size(window, resolution=(1920, 1080), scale=0.85):
    rules = [Match(wm_class="Sxiv")]
    if any(window.match(rule) for rule in rules):
        window.cmd_set_size_floating(
            int(resolution[0] * scale), int(resolution[1] * scale)
        )
        window.cmd_center()
