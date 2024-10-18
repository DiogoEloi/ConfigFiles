return {
  "luisiacc/gruvbox-baby",
  priority = 1000,
  config = function()
        vim.g.gruvbox_baby_function_style = "bold"
        vim.g.gruvbox_baby_use_original_palette = false
        vim.g.gruvbox_baby_keyword_style = "italic"
        vim.cmd("colorscheme gruvbox-baby")
        -- -- Highlights the line number
        vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='orange' })
        vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='yellow' })
        vim.api.nvim_set_hl(0, 'LineNr', { fg='red', bold=true })

  end,
}
