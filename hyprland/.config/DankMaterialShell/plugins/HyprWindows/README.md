# Hyprland Windows for DankMaterialShell — v1.3.0

## Main fixes

- Uses DMS Launcher v2 `_preScored` values so the launcher no longer reorders
  the plugin's results.
- The first result is the previously focused window.
- The rest remain in MRU order.
- Maintains its own global MRU list of Hyprland window addresses.
- Uses generic exact-address focus, so switching does not depend on the active
  Hyprland layout.

Internal MRU:

    current, previous, older...

Displayed launcher order:

    previous, current, older...

This works the same for:

- dwindle
- master
- scrolling
- grouped/tabbed windows
- floating windows
- windows on other workspaces/monitors

## Install

Replace:

    ~/.config/DankMaterialShell/plugins/HyprWindows

with the `HyprWindows` directory from this archive.

Then run:

    dms ipc plugin-scan scan
    dms ipc plugin-scan reload hyprWindows

For this update, a one-time clean shell restart is recommended:

    dms restart

## Requirement

DMS >= 1.4.0, because deterministic launcher-plugin ordering relies on
`_preScored`.
