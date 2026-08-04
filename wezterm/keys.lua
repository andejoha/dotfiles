local wezterm = require("wezterm")
local act = wezterm.action
local layouts = require("layouts")
local M = {}

function M.apply(config)
	config.leader = { key = " ", mods = "SHIFT", timeout_milliseconds = 1000 }
	config.keys = {
		{
			-- Split horizontal
			key = "v",
			mods = "LEADER",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			-- Split vertical
			key = "h",
			mods = "LEADER",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			-- New tab
			key = "t",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			-- Next tab
			key = "Tab",
			mods = "LEADER",
			action = act.ActivateTabRelative(1),
		},
		{
			-- Previous tab
			key = "Tab",
			mods = "LEADER|SHIFT",
			action = act.ActivateTabRelative(-1),
		},
		{
			-- Close tab
			key = "Escape",
			mods = "LEADER",
			action = act.CloseCurrentTab({ confirm = true }),
		},
		{
			-- Dev layout: nvim (top-left) | claude (top-right) / terminal (bottom)
			key = "d",
			mods = "LEADER",
			action = wezterm.action_callback(layouts.dev_layout),
		},
		{
			-- Jump back a word (Option+Left). Sent as Meta+b (ESC b) instead of
			-- the default CSI sequence, since zsh/bash don't bind that sequence
			-- to backward-word out of the box, causing stray "D" chars to be typed.
			key = "LeftArrow",
			mods = "OPT",
			action = act.SendString("\x1bb"),
		},
		{
			-- Jump forward a word (Option+Right). Sent as Meta+f (ESC f), the
			-- counterpart to the LeftArrow binding above.
			key = "RightArrow",
			mods = "OPT",
			action = act.SendString("\x1bf"),
		},
	}

	for i = 1, 4 do
		-- F1 through F4 to activate that tab
		table.insert(config.keys, {
			key = "F" .. tostring(i),
			action = act.ActivateTab(i - 1),
		})
	end
end

return M
