local wezterm = require 'wezterm'
local config = {} or wezterm.config_builder()

-- Helpers to determine OS
local os = wezterm.target_triple
local is_linux = os:find("linux") ~= nil
local is_darwin = os:find("darwin") ~= nil
local is_windows = os:find("windows") ~= nil

-- ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
-- ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
-- ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
-- ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
-- ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
--  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 

-- Input
config.enable_kitty_keyboard = true
config.use_ime = true

config.audible_bell = 'Disabled',
config.visual_bell = {
        fade_in_duration_ms = 20,
        fade_out_duration_ms = 200,
        fade_in_function = 'Linear',
        fade_out_function = 'EaseOut',
}

-- ███████╗ ██████╗ ███╗   ██╗████████╗
-- ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝
-- █████╗  ██║   ██║██╔██╗ ██║   ██║   
-- ██╔══╝  ██║   ██║██║╚██╗██║   ██║   
-- ██║     ╚██████╔╝██║ ╚████║   ██║   
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   
                                    
config.font = wezterm.font( {
    { family = "VictorMono Nerd Font", weight = "regular" }
} )

if is_darwin then
    config.font_size = 15
else
    config.font_size = 13
end

-- ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗
-- ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║
-- ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║
-- ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║
-- ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝
--  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ 

-- This is because we are using a tiling window manager
config.window_decorations = "RESIZE"

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

-- ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
-- ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
-- ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
-- ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
-- ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
--  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

-- Ensure  the wezterm TERM definitions are installed for wezterm TERM to work
-- otherwise set to xterm-256color. Follow the line below to install the definitions
-- https://wezfurlong.org/wezterm/config/lua/config/term.html?h=term#term-xterm-256color
config.term = "wezterm"

if is_darwin then
    config.window_background_opacity = 0.3
    config.macos_window_background_blur = 20
else
    config.window_background_opacity = 0.6
end

config.color_scheme = "Tokyo Night Moon"

return config