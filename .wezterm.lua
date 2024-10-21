local wezterm = require 'wezterm'
local act = wezterm.action

return {
    -- color_scheme = 'termnial.sexy',
    color_scheme = 'Gnome Dark',
    enable_tab_bar = false,
    font_size = 11.0,
    font = wezterm.font('0xProto Nerd Font'),
    -- macos_window_background_blur = 40,
    -- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
    -- window_background_image_hsb = {
    -- 	brightness = 0.01,
    -- 	hue = 1.0,
    -- 	saturation = 0.5,
    -- },
    window_background_opacity = 0.80,
    macos_window_background_blur = 10,

    window_decorations = 'RESIZE',
    keys = {
        {
            key = 'f',
            mods = 'CTRL',
            action = wezterm.action.ToggleFullScreen,
        },
        {
            key = '\'',
            mods = 'CTRL',
            action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
        },
    },

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
