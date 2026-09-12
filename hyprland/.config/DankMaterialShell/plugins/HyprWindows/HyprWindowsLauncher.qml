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
    property var mruAddresses: []
    property string lastActiveAddress: ""

    property bool refreshRunning: false
    property double lastRefreshMs: 0

    readonly property int scoreBase: 50000

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

                    const currentWindows = parsed.filter(w =>
                        w &&
                        w.address &&
                        w.mapped !== false
                    )

                    windows = currentWindows
                    syncMru(currentWindows)
                    root.itemsChanged()
                } catch (e) {
                    console.warn("[HyprWindows] Failed to parse clients JSON:", e)
                }
            },
            0
        )
    }

    function numericFocusHistory(window) {
        if (!window)
            return 999999

        const value = Number(window.focusHistoryID)
        if (Number.isFinite(value) && value >= 0)
            return value

        return 999999
    }

    function activeAddressFromClients(clientList) {
        for (const window of clientList) {
            if (numericFocusHistory(window) === 0)
                return window.address
        }

        return ""
    }

    function seedMru(clientList) {
        const seeded = clientList.slice()

        seeded.sort((a, b) => {
            const ah = numericFocusHistory(a)
            const bh = numericFocusHistory(b)

            if (ah !== bh)
                return ah - bh

            return String(a.address).localeCompare(String(b.address))
        })

        mruAddresses = seeded.map(w => w.address)
    }

    function noteFocusedAddress(address) {
        if (!address)
            return

        const next = [address]

        for (const oldAddress of mruAddresses) {
            if (oldAddress !== address)
                next.push(oldAddress)
        }

        mruAddresses = next
        lastActiveAddress = address
    }

    function syncMru(clientList) {
        if (!clientList || clientList.length === 0) {
            mruAddresses = []
            lastActiveAddress = ""
            return
        }

        const live = {}
        for (const window of clientList)
            live[window.address] = true

        if (mruAddresses.length === 0)
            seedMru(clientList)

        let cleaned = []
        for (const address of mruAddresses) {
            if (live[address])
                cleaned.push(address)
        }
        mruAddresses = cleaned

        const missing = clientList
            .filter(w => mruAddresses.indexOf(w.address) === -1)
            .sort((a, b) =>
                numericFocusHistory(a) - numericFocusHistory(b)
            )

        for (const window of missing)
            mruAddresses.push(window.address)

        const activeAddress = activeAddressFromClients(clientList)

        if (activeAddress && activeAddress !== lastActiveAddress)
            noteFocusedAddress(activeAddress)
        else if (activeAddress && !lastActiveAddress)
            lastActiveAddress = activeAddress
    }

    function workspaceName(window) {
        if (!window || !window.workspace)
            return "Workspace ?"

        const name = window.workspace.name

        if (name !== undefined &&
            name !== null &&
            String(name).length > 0)
            return String(name)

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

    function mruPosition(address) {
        const idx = mruAddresses.indexOf(address)
        return idx >= 0 ? idx : 999999
    }

    function desiredSortIndex(address) {
        const mru = mruPosition(address)

        if (mru === 1)
            return 0

        if (mru === 0)
            return 1

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

            const mru = mruPosition(window.address)
            const sortIndex = desiredSortIndex(window.address)

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
                _sortIndex: sortIndex
            })
        }

        items.sort((a, b) => {
            if (a._sortIndex !== b._sortIndex)
                return a._sortIndex - b._sortIndex

            return a.name.localeCompare(b.name)
        })

        for (let i = 0; i < items.length; ++i)
            items[i]._preScored = scoreBase - i

        return items
    }

    function executeItem(item) {
        if (!item || !item.action)
            return

        const separator = item.action.indexOf(":")
        if (separator < 0)
            return

        const actionType = item.action.slice(0, separator)
        const actionData = item.action.slice(separator + 1)

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
                    noteFocusedAddress(address)
                    root.refreshWindows(true)
                    return
                }

                console.warn(
                    "[HyprWindows] Current focus syntax failed; trying legacy:",
                    stdout
                )

                Proc.runCommand(
                    "hyprWindows.focus.legacy",
                    ["hyprctl", "dispatch", "focuswindow", selector],
                    (legacyStdout, legacyExitCode) => {
                        if (legacyExitCode === 0) {
                            noteFocusedAddress(address)
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
