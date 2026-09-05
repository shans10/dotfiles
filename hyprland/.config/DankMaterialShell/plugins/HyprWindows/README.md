# Hyprland Windows for DankMaterialShell — v1.2.0

## v1.2 change

The first launcher item is now always the previously focused window
(`focusHistoryID == 1`), so DMS auto-selects the window you most likely want
for Alt-Tab-style toggling.

Ordering is:

    previous -> current -> remaining MRU

or, in Hyprland focus-history IDs:

    1, 0, 2, 3, 4, ...

All other behavior is unchanged.

## Install

Replace:

    ~/.config/DankMaterialShell/plugins/HyprWindows

with this version, then run:

    dms ipc plugin-scan scan
    dms ipc plugin-scan reload hyprWindows

If necessary:

    dms restart
