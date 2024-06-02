#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
# polybar mainbar-i3 -c ~/.config/polybar/config &
polybar mainbar-xmonad -c ~/.config/polybar/config &
# polybar mainbar-bspwm -c ~/.config/polybar/config &
