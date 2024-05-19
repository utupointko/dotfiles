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

-- keybindings
config.keys = {
    -- reload configuration
    {key="r", mods="SUPER|SHIFT", action=wezterm.action.ReloadConfiguration},

    -- close pane
    {key="w", mods="SUPER|SHIFT", action=wezterm.action.CloseCurrentPane{confirm=true}},

    -- split horizontally
    {key="d", mods="SUPER|SHIFT", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},

    -- split vertically
    {key="v", mods="SUPER|SHIFT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},

    -- resize panes
    {key="LeftArrow", mods="SUPER|SHIFT", action=wezterm.action.AdjustPaneSize{"Left", 5}},
    {key="RightArrow", mods="SUPER|SHIFT", action=wezterm.action.AdjustPaneSize{"Right", 5}},
    {key="UpArrow", mods="SUPER|SHIFT", action=wezterm.action.AdjustPaneSize{"Up", 5}},
    {key="DownArrow", mods="SUPER|SHIFT", action=wezterm.action.AdjustPaneSize{"Down", 5}},

    -- change focus
    {key="LeftArrow", mods="SUPER", action=wezterm.action.ActivatePaneDirection "Left"},
    {key="RightArrow", mods="SUPER", action=wezterm.action.ActivatePaneDirection "Right"},
    {key="UpArrow", mods="SUPER", action=wezterm.action.ActivatePaneDirection "Up"},
    {key="DownArrow", mods="SUPER", action=wezterm.action.ActivatePaneDirection "Down"},
}

-- and finally, return the configuration to wezterm
return config
