local INTERNAL = "eDP-2"
local EXTERNAL = "DP-1"

-- Static monitor definitions.
-- Do NOT dynamically enable/disable these later.
hl.monitor({
	output = INTERNAL,
	mode = "1920x1080@144",
	position = "0x0",
	scale = 1.25,
})

hl.monitor({
	output = EXTERNAL,
	mode = "1920x1080@120",
	position = "auto-right",
	scale = 1.0,
})

local function monitor_exists(name)
	for _, monitor in ipairs(hl.get_monitors()) do
		if monitor.name == name then
			return true
		end
	end

	return false
end

local function set_workspace_1(name)
	local monitor = hl.get_monitor(name)

	if monitor then
		monitor:set_workspace("1")
	end
end

local function docked()
	-- Make sure external is awake.
	hl.dispatch(hl.dsp.dpms({
		action = "on",
		monitor = EXTERNAL,
	}))

	-- Put workspace 1 on external first.
	set_workspace_1(EXTERNAL)

	-- Then turn the laptop panel off.
	hl.dispatch(hl.dsp.dpms({
		action = "off",
		monitor = INTERNAL,
	}))
end

local function undocked()
	-- Wake laptop panel.
	hl.dispatch(hl.dsp.dpms({
		action = "on",
		monitor = INTERNAL,
	}))

	-- Give it a moment to resume rendering.
	hl.timer(function()
		set_workspace_1(INTERNAL)
	end, {
		timeout = 100,
		type = "oneshot",
	})
end

-- External plugged in.
hl.on("monitor.added", function(monitor)
	if monitor.name == EXTERNAL then
		hl.timer(function()
			docked()
		end, {
			timeout = 150,
			type = "oneshot",
		})
	end
end)

-- External unplugged.
hl.on("monitor.removed", function(monitor)
	if monitor.name == EXTERNAL then
		undocked()
	end
end)

-- Initial login state.
hl.on("hyprland.start", function()
	hl.timer(function()
		if monitor_exists(EXTERNAL) then
			docked()
		else
			undocked()
		end
	end, {
		timeout = 400,
		type = "oneshot",
	})
end)
