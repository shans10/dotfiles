#!/usr/bin/env bash

xfce4-power-manager --daemon                        # Start power manager
picom -b                                            # Start compositor
xargs xwallpaper --stretch < ~/.cache/wall &        # Set wallpaper
conky -c .config/conky/qtile/catppuccin.conkyrc &   # Start conky
