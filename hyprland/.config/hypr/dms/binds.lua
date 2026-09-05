-- DMS default keybinds (Hyprland 0.55+ Lua)

-- Dispatch keybindings conditionally based on the active workspace layout
local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

		if not workspace then
			return
		end

		local layout = workspace.tiled_layout

		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end

-- Seamless horizontal focus across normal windows and tabbed groups.
-- Inside a group, move through tabs without wrapping; at the first/last tab,
-- continue spatially to the neighboring window/column outside the group.
local function smart_horizontal_focus(direction)
	return function()
		local window = hl.get_active_window()
		local group = window and window.group

		if group then
			local index = group.current_index
			local size = group.size

			if direction == "l" and index > 1 then
				hl.dispatch(hl.dsp.group.active({ index = index - 1 }))
				return
			elseif direction == "r" and index < size then
				hl.dispatch(hl.dsp.group.active({ index = index + 1 }))
				return
			end
		end

		-- Not grouped, or already at the edge of the active group: move focus
		-- spatially. Scrolling needs its layout-aware focus dispatcher so this
		-- also works when the current window is maximized.
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

		if not workspace then
			return
		end

		if workspace.tiled_layout == "scrolling" then
			hl.dispatch(hl.dsp.layout("focus " .. direction))
		else
			hl.dispatch(hl.dsp.focus({ direction = direction }))
		end
	end
end

-- === Application Launchers ===
hl.bind("SUPER + Return", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + space", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind("ALT + space", hl.dsp.exec_cmd("dms ipc call spotlight-bar toggle"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle"))
hl.bind("SUPER + comma", hl.dsp.exec_cmd("dms ipc call settings focusOrToggle"))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd("dms ipc call notepad toggle"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("dms ipc call dash toggle wallpaper"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))

-- === Cheat sheet
hl.bind("SUPER + SHIFT + Slash", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"))

-- === Security ===
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exit())
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle"))

-- === Audio Controls ===
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true })
hl.bind(
	"CTRL + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("dms ipc call mpris increment 3"),
	{ locked = true, repeating = true }
)
hl.bind(
	"CTRL + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("dms ipc call mpris decrement 3"),
	{ locked = true, repeating = true }
)

-- === Brightness Controls ===
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd([[dms ipc call brightness increment 5 ""]]),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd([[dms ipc call brightness decrement 5 ""]]),
	{ locked = true, repeating = true }
)

-- === Window Management ===
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
-- hl.bind("SUPER + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + W", hl.dsp.group.toggle())
hl.bind("SUPER + CTRL + W", hl.dsp.exec_cmd("dms ipc call window-rules toggle"))
-- Navigate between windows within a group
hl.bind("ALT + TAB", hl.dsp.group.next(), { desc = "Next window in group" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.group.prev(), { desc = "Previous window in group" })

-- === Focus Navigation ===
-- H/L and Left/Right move seamlessly through group tabs and then continue
-- to neighboring windows once the active group edge is reached.
hl.bind("SUPER + left", smart_horizontal_focus("l"))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + right", smart_horizontal_focus("r"))
hl.bind("SUPER + H", smart_horizontal_focus("l"))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + L", smart_horizontal_focus("r"))
-- Alt-Tab window navigation
hl.bind("ALT + TAB", hl.dsp.window.cycle_next(), { desc = "Focus next window" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }), { desc = "Focus previous window" })

-- === Window Movement ===
-- In Scrolling, horizontal movement swaps the active column directly with its
-- left/right neighbor instead of using generic spatial window movement.
hl.bind(
	"SUPER + SHIFT + left",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol l"),
		dwindle = hl.dsp.window.move({ direction = "l" }),
		master = hl.dsp.window.move({ direction = "l" }),
		monocle = hl.dsp.window.move({ direction = "l" }),
	})
)
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(
	"SUPER + SHIFT + right",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol r"),
		dwindle = hl.dsp.window.move({ direction = "r" }),
		master = hl.dsp.window.move({ direction = "r" }),
		monocle = hl.dsp.window.move({ direction = "r" }),
	})
)
hl.bind(
	"SUPER + SHIFT + H",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol l"),
		dwindle = hl.dsp.window.move({ direction = "l" }),
		master = hl.dsp.window.move({ direction = "l" }),
		monocle = hl.dsp.window.move({ direction = "l" }),
	})
)
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(
	"SUPER + SHIFT + L",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol r"),
		dwindle = hl.dsp.window.move({ direction = "r" }),
		master = hl.dsp.window.move({ direction = "r" }),
		monocle = hl.dsp.window.move({ direction = "r" }),
	})
)

-- === Column Navigation ===
hl.bind("SUPER + Home", hl.dsp.focus({ window = "first" }))
hl.bind("SUPER + End", hl.dsp.focus({ window = "last" }))

-- === Monitor Navigation ===
hl.bind("SUPER + CTRL + left", hl.dsp.focus({ monitor = "l" }))
hl.bind("SUPER + CTRL + right", hl.dsp.focus({ monitor = "r" }))
hl.bind("SUPER + CTRL + H", hl.dsp.focus({ monitor = "l" }))
hl.bind("SUPER + CTRL + J", hl.dsp.focus({ monitor = "d" }))
hl.bind("SUPER + CTRL + K", hl.dsp.focus({ monitor = "u" }))
hl.bind("SUPER + CTRL + L", hl.dsp.focus({ monitor = "r" }))

-- === Move to Monitor ===
hl.bind("SUPER + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "l" }))
hl.bind("SUPER + SHIFT + CTRL + down", hl.dsp.window.move({ monitor = "d" }))
hl.bind("SUPER + SHIFT + CTRL + up", hl.dsp.window.move({ monitor = "u" }))
hl.bind("SUPER + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "r" }))
hl.bind("SUPER + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }))
hl.bind("SUPER + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "d" }))
hl.bind("SUPER + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "u" }))
hl.bind("SUPER + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }))

-- === Workspace Navigation ===
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + U", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + I", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + I", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }))

-- === Workspace Management ===
hl.bind("CTRL + SHIFT + R", hl.dsp.exec_cmd("dms ipc call workspace-rename open"))

-- === Move Workspaces ===
hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + SHIFT + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + I", hl.dsp.window.move({ workspace = "e-1" }))

-- === Mouse Wheel Navigation ===
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- === Touchpad Gestures ===
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- === Numbered Workspaces ===
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }))

-- === Move to Numbered Workspaces ===
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))

-- === Layout-specific Column / Split Management ===
-- Dwindle-only: preselect is not supported by scrolling/master/monocle.
hl.bind(
	"SUPER + bracketleft",
	layout_bind({
		dwindle = hl.dsp.layout("preselect l"),
	})
)
hl.bind(
	"SUPER + bracketright",
	layout_bind({
		dwindle = hl.dsp.layout("preselect r"),
	})
)

-- === Sizing & Layout ===
-- SUPER+R adapts to the active workspace layout.
hl.bind(
	"SUPER + R",
	layout_bind({
		scrolling = hl.dsp.layout("colresize +conf"),
		dwindle = hl.dsp.layout("togglesplit"),
	})
)

-- Scrolling-only column sizing. These become harmless no-ops on other layouts.
hl.bind(
	"SUPER + CTRL + R",
	layout_bind({
		scrolling = hl.dsp.layout("colresize all 0.5"),
	})
)
hl.bind(
	"SUPER + SHIFT + R",
	layout_bind({
		scrolling = hl.dsp.layout("colresize -conf"),
	})
)

hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "set" }))

-- === Move/resize windows with mainMod + LMB/RMB and dragging ===
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

hl.bind(
	"SUPER + code:20",
	hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
	{ description = "Expand window left" }
)
hl.bind(
	"SUPER + code:21",
	hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
	{ description = "Shrink window left" }
)

-- === Manual Sizing ===
hl.bind("SUPER + minus", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + equal", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })

-- === Screenshots ===
hl.bind("Print", hl.dsp.exec_cmd("dms screenshot"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("dms screenshot full"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("dms screenshot window"))

-- === Display Profiles ===
hl.bind("SUPER + P", hl.dsp.exec_cmd("dms ipc outputs cycleProfile"))

-- === System Controls ===
hl.bind("SUPER + SHIFT + P", hl.dsp.dpms({ action = "toggle" }))

-- === Custom User Functions ===
-- Toggle window floating state (position at center with 75% screen size)
hl.bind("SUPER + T", function()
	local w = hl.get_active_window()
	if not w then
		return
	end

	if w.floating then
		hl.dispatch(hl.dsp.window.float({ action = "unset" }))
		return
	end

	local m = hl.get_active_monitor()
	if not m then
		return
	end

	local scale = 0.75

	hl.dispatch(hl.dsp.window.float({ action = "set" }))
	hl.dispatch(hl.dsp.window.resize({
		x = math.floor(m.width * scale),
		y = math.floor(m.height * scale),
		relative = false,
	}))
	hl.dispatch(hl.dsp.window.center())
end, {
	description = "Toggle centered floating",
})
