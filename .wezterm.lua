-- pull in the wezterm API
local wezterm = require("wezterm")

-- this will hold the configuration.
local config = wezterm.config_builder()

-- this is where you actually apply your config choices

config.initial_cols = 160
config.initial_rows = 48

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 12

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 12

-- and finally, return the configuration to wezterm
return config
