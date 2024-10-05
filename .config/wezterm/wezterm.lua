local wezterm = require 'wezterm'
local config = {} or wezterm.config_builder()

config.font = wezterm.font {
        { family = "VictorMono Nerd Font", weight = "regular" }
}

config.window_decorations = "RESIZE"
config.color_scheme = "Tokyo Night Moon"

return config