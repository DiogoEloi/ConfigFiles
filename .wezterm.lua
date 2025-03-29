local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
    -- this is set by the plugin, and unset on ExitPre in Neovim
    return pane:get_user_vars().IS_NVIM == 'true'
end

-- wezterm.on('gui-startup', function(cmd)
--   if cmd.args == 0 then
--     return
--  end
--     local _, first_pane, window = mux.spawn_window {}
--
--     window:active_tab():set_title('Frontend')
--
--     local _, second_pane, _ = window:spawn_tab {}
--     window:active_tab():set_title('Frontend - Git')
--
--     local _, third_pane, _ = window:spawn_tab {}
--     window:active_tab():set_title('GraphQL')
--     local _, fourth_pane, _ = window:spawn_tab {}
--     window:active_tab():set_title('GraphQL - Git')
--
--     local _, fifth_pane, _ = window:spawn_tab {}
--     window:active_tab():set_title('Notes')
--
--     local _, sixth_pane, _ = window:spawn_tab {}
--     window:active_tab():set_title('Terminal')
--
--     local graphql_dir = 'C:\\Projects\\case-installer-graphql'
--     local frontend_dir = 'C:\\Projects\\case-installer-frontend'
--
--     first_pane:send_text "cd C:\\Projects\\case-installer-frontend\\src\\\r"
--     first_pane:send_text "nvim\r"
--
--
--     second_pane:send_text "cd C:\\Projects\\case-installer-frontend\r"
--     second_pane = second_pane:split {
--         direction = 'Bottom',
--         size = 0.1,
--         cwd = frontend_dir,
--     }
--     second_pane:send_text "yarn dev\r"
--
--     third_pane:send_text "cd C:\\Projects\\case-installer-graphql\r"
--
--     fourth_pane:send_text "cd C:\\Projects\\case-installer-graphql\r"
--     fourth_pane = fourth_pane:split {
--         direction = 'Bottom',
--         size = 0.1,
--         cwd = graphql_dir,
--     }
--
--     fourth_pane:send_text "yarn dev\r"
--
--     fifth_pane:send_text "cd 'C:\\Users\\pin97614\\Documents\\Obsidian Vault'\r"
--     fifth_pane:send_text "nvim\r"
--
-- end)

local direction_keys = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == 'resize' and 'META' or 'CTRL',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
                }, pane)
            else
                if resize_or_move == 'resize' then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end

local config = {
    -- color_scheme = 'termnial.sexy',
    -- default_prog = { 'GNOME Terminal' },
    color_scheme = 'Solarized Dark',
    font_size = 10.0,
    -- font = wezterm.font('Cascadia Code'),

    window_background_opacity = 0.80,
    macos_window_background_blur = 10,
    window_decorations = 'NONE',

    -- TABS
    -- Make it look like tabs, with better GUI control

    use_fancy_tab_bar = true,
    enable_tab_bar = true,
    tab_bar_at_bottom = true,

    show_new_tab_button_in_tab_bar = false,
    -- show_close_tab_button_in_tabs = false,
    -- Don't let any individual tab name take too much room
    tab_max_width = 32,

    window_frame = {
        -- The font used in the tab bar.
        -- Roboto Bold is the default; this font is bundled
        -- with wezterm.
        -- Whatever font is selected here, it will have the
        -- main font setting appended to it to pick up any
        -- fallback fonts you may have used there.
        font = wezterm.font { family = 'Roboto', weight = 'Bold' },

        -- The size of the font in the tab bar.
        -- Default to 10.0 on Windows but 12.0 on other systems
        font_size = 12.0,

        -- The overall background color of the tab bar when
        -- the window is focused
        active_titlebar_bg =   "rgba(0,0,0,0)",

        -- The overall background color of the tab bar when
        -- the window is not focused
        inactive_titlebar_bg =  "rgba(0,0,0,0)",
    },

    colors = {
        tab_bar = {
            active_tab = {
                -- The color of the background area for the tab
                bg_color = '#2b2042',
                -- The color of the text for the tab
                fg_color = '#c0c0c0',

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                intensity = 'Normal',

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                underline = 'None',

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                italic = true,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                strikethrough = false,
            },

        }
    },

    -- Switch to the last active tab when I close a tab
    switch_to_last_active_tab_when_closing_tab = true,

    leader = {
        key = 'a',
        mods = 'CTRL',
        timeout_milliseconds = 2000
    },

    keys = {
        {
            key = 'v',
            mods = 'ALT',
            action = act.PasteFrom 'Clipboard'        },
        {
            key = '\\',
            mods = 'LEADER',
            action = act.SplitHorizontal({domain = 'CurrentPaneDomain'}),
        },
        {
            key = '-',
            mods = 'LEADER',
            action = act.SplitVertical({domain = 'CurrentPaneDomain'}),
        },
        {
            key = 't',
            mods = 'LEADER',
            action = act.SpawnTab("CurrentPaneDomain"),
        },
        {
            key = 'x',
            mods = 'LEADER',
            action = act.CloseCurrentPane({ confirm = true }),
        },
        {
            key = 'q',
            mods = 'LEADER',
            action = act.QuitApplication,
        },
        {
            key = ',',
            mods = 'LEADER',
            action = act.PromptInputLine {
                description = 'Enter new name for tab',
                action = wezterm.action_callback(
                    function(window, pane, line)
                        if line then
                            window:active_tab():set_title(line)
                        end
                    end
                ),
            },
        },
        {
            key = 'f',
            mods = 'LEADER',
            action = act.ToggleFullScreen,
        },
        {
            key = '\'',
            mods = 'CTRL',
            action = act.ClearScrollback 'ScrollbackAndViewport',
        },
        -- move between split panes
        split_nav('move', 'h'),
        split_nav('move', 'j'),
        split_nav('move', 'k'),
        split_nav('move', 'l'),
        -- resize panes
        split_nav('resize', 'h'),
        split_nav('resize', 'j'),
        split_nav('resize', 'k'),
        split_nav('resize', 'l'),
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
        hue = 1.1,
        saturation = 1.0,
        brightness = 0.9,
    },
    front_end = 'WebGpu',
    term = "xterm-256color" 
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1),
    })
end
-- The filled in variant of the < symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick

-- The filled in variant of the > symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return tab_info.tab_index + 1 ..  ' - ' .. title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.tab_index + 1 ..  ' - ' .. tab_info.active_pane.title
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local edge_background = 'rgba(0,0,0,0)'
        local background = '#1b1032'
        local foreground = '#808080'

        if tab.is_active then
            background = '#2b2042'
            foreground = '#c0c0c0'
        elseif hover then
            background = '#3b3052'
            foreground = '#909090'
        end

        local edge_foreground = background

        local title = tab_title(tab)

        -- ensure that the titles fit in the available space,
        -- and that we have room for the edges.
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_LEFT_ARROW },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
        }
    end
)

return config
