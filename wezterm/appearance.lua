local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	local font_name = "MesloLGS NF"
	config.font = wezterm.font(font_name)
	config.font_size = 18

	-- Window
	config.hide_tab_bar_if_only_one_tab = true
	config.window_frame = {
		font = wezterm.font({ family = font_name, weight = "Bold" }),
		font_size = 18,
		active_titlebar_bg = "#222436",
	}

	-- Theme
	config.color_scheme = "Tokyo Night Moon"
	config.window_background_opacity = 0.90
	config.macos_window_background_blur = 15
end

return M
