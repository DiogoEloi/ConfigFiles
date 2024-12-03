local wezterm = require 'wezterm'
local act = wezterm.action

return {
    -- color_scheme = 'termnial.sexy',
    color_scheme = 'Gnome Dark',
    enable_tab_bar = false,
    font_size = 11.0,
    font = wezterm.font('0xProto Nerd Font'),

    window_background_opacity = 0.80,
    macos_window_background_blur = 10,
    window_decorations = 'RESIZE',
    keys = {
        {
            key = 'f',
            mods = 'CTRL',
            action = act.ToggleFullScreen,
        },
        {
            key = '\'',
            mods = 'CTRL',
            action = act.ClearScrollback 'ScrollbackAndViewport',
        },
        {
            key = 'l',
            mods = 'CTRL',
            action = act.DisableDefaultAssignment,
        },
        {
            key = 'j',
            mods = 'CTRL',
            action = act.DisableDefaultAssignment,
        },
        {
            key = 'k',
            mods = 'CTRL',
            action = act.DisableDefaultAssignment,
        },
        {
            key = 'h',
            mods = 'CTRL',
            action = act.DisableDefaultAssignment,
        },
    },
    -- window_padding = {
    --       left = 0,
    --       right = 0,
    --       top = 0,
    --       bottom = 0,
    -- },

    -- There are mouse binding to mimc Windows Terminal and let you copy
    -- To copy just highlight something and right click. Simple
    mouse_bindings = {
        {
            event = { Down = { streak = 3, button = 'Left' } },
            action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
            mods = 'NONE',
        },
        {
            event = { Down = { streak = 1, button = "Right" } },
            mods = "NONE",
            action = wezterm.action_callback(function(window, pane)
                local has_selection = window:get_selection_text_for_pane(pane) ~= ""
                if has_selection then
                    window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
                    window:perform_action(act.ClearSelection, pane)
                else
                    window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
                end
            end),
        },
    },
    -- This is used to make my foreground (text, etc) brighter than my background
    foreground_text_hsb = {
        hue = 1.0,
        saturation = 1.2,
        brightness = 1.5,
    }
}
