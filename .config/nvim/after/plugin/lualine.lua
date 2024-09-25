require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { },
    lualine_c = { "filename" },
    lualine_x = { "filetype", "branch", "diagnostics" },
    lualine_y = { },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        "tabs",
        tab_max_length = 40,  -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
        max_length = vim.o.columns, -- Maximum width of tabs component.
                                        -- Note:
                                        -- It can also be a function that returns
                                        -- the value of `max_length` dynamically.
        mode = 2,
        path = 0,
      },
    },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
