import QtQuick
import Quickshell
import qs.Common
import qs.Services

Item {
    id: root

    property var pluginService: null
    property string trigger: "!"
    signal itemsChanged()

    property var windows: []
    property bool refreshRunning: false
    property double lastRefreshMs: 0

    function refreshWindows(force) {
        const now = Date.now()

        if (refreshRunning)
            return

        if (!force && now - lastRefreshMs < 250)
            return

        refreshRunning = true

        Proc.runCommand(
            "hyprWindows.clients",
            ["hyprctl", "-j", "clients"],
            (stdout, exitCode) => {
                refreshRunning = false
                lastRefreshMs = Date.now()

                if (exitCode !== 0) {
                    console.warn("[HyprWindows] hyprctl -j clients failed:", exitCode)
                    return
                }

                try {
                    const parsed = JSON.parse(stdout)

                    if (!Array.isArray(parsed)) {
                        console.warn("[HyprWindows] Unexpected clients JSON")
                        return
                    }

                    windows = parsed.filter(w =>
                        w &&
                        w.address &&
                        w.mapped !== false &&
                        (w.monitor === undefined || w.monitor !== -1)
                    )

                    root.itemsChanged()
                } catch (e) {
                    console.warn("[HyprWindows] Failed to parse clients JSON:", e)
                }
            },
            0
        )
    }

    function workspaceName(window) {
        if (!window || !window.workspace)
            return "Workspace ?"

        if (window.workspace.name !== undefined &&
            window.workspace.name !== null &&
            String(window.workspace.name).length > 0)
            return String(window.workspace.name)

        if (window.workspace.id !== undefined)
            return "Workspace " + window.workspace.id

        return "Workspace ?"
    }

    function appId(window) {
        if (!window)
            return "unknown"

        return window.class ||
               window.initialClass ||
               window.initialTitle ||
               "unknown"
    }

    function appIcon(window) {
        const id = appId(window)

        try {
            const entry = DesktopEntries.heuristicLookup(id)
            if (entry && entry.icon)
                return entry.icon
        } catch (e) {
        }

        return id
    }

    function fuzzyMatch(query, text) {
        if (!query)
            return true

        const q = query.toLowerCase().trim()
        const t = text.toLowerCase()

        if (q.length === 0)
            return true

        if (t.indexOf(q) >= 0)
            return true

        let qi = 0
        for (let ti = 0; ti < t.length && qi < q.length; ++ti) {
            if (t[ti] === q[qi])
                qi++
        }

        return qi === q.length
    }

    function mruIndex(window) {
        if (!window)
            return 999999

        const n = Number(window.focusHistoryID)

        if (Number.isFinite(n) && n >= 0)
            return n

        return 999999
    }

    // Put the previously focused window first so DMS auto-selects it.
    // All remaining windows retain normal MRU ordering.
    //
    // Hyprland:
    //   focusHistoryID 0 = current window
    //   focusHistoryID 1 = previous window
    //   focusHistoryID 2 = next older window
    //
    // Result:
    //   1, 0, 2, 3, 4, ...
    function switcherSortIndex(mru) {
        if (mru === 1)
            return -1

        return mru
    }

    function getItems(query) {
        refreshWindows(false)

        const q = query ? query.trim() : ""
        const items = []

        for (const window of windows) {
            const id = appId(window)
            const title = window.title || ""
            const ws = workspaceName(window)
            const displayName = title.length > 0 ? title : id
            const searchText = id + " " + title + " " + ws

            if (!fuzzyMatch(q, searchText))
                continue

            const mru = mruIndex(window)

            let state = ""
            if (mru === 1)
                state = " • Previous"
            else if (mru === 0)
                state = " • Focused"

            items.push({
                name: displayName,
                icon: appIcon(window),
                comment: id + " • " + ws + state,
                action: "focus:" + window.address,
                categories: ["Hyprland Windows"],
                _mru: mru,
                _sortIndex: switcherSortIndex(mru)
            })
        }

        // Alt-Tab-style ordering:
        // previous window first, then every other window in MRU order.
        items.sort((a, b) => {
            if (a._sortIndex !== b._sortIndex)
                return a._sortIndex - b._sortIndex

            return a.name.localeCompare(b.name)
        })

        return items
    }

    function executeItem(item) {
        if (!item || !item.action)
            return

        const parts = item.action.split(":")
        const actionType = parts[0]
        const actionData = parts.slice(1).join(":")

        if (actionType !== "focus" || !actionData)
            return

        focusWindow(actionData)
    }

    function focusWindow(address) {
        const selector = "address:" + address

        const luaDispatcher =
            'hl.dsp.focus({ window = "' + selector + '" })'

        Proc.runCommand(
            "hyprWindows.focus.current",
            ["hyprctl", "dispatch", luaDispatcher],
            (stdout, exitCode) => {
                if (exitCode === 0) {
                    root.refreshWindows(true)
                    return
                }

                console.warn(
                    "[HyprWindows] Current focus syntax failed, trying legacy syntax:",
                    stdout
                )

                Proc.runCommand(
                    "hyprWindows.focus.legacy",
                    ["hyprctl", "dispatch", "focuswindow", selector],
                    (legacyStdout, legacyExitCode) => {
                        if (legacyExitCode === 0) {
                            root.refreshWindows(true)
                            return
                        }

                        console.warn(
                            "[HyprWindows] Failed to focus window:",
                            address,
                            legacyStdout
                        )

                        try {
                            ToastService.showError(
                                "Hyprland Windows",
                                "Failed to focus the selected window"
                            )
                        } catch (e) {
                        }
                    },
                    0
                )
            },
            0
        )
    }

    Component.onCompleted: refreshWindows(true)

    Timer {
        interval: 750
        running: true
        repeat: true
        onTriggered: root.refreshWindows(false)
    }
}
