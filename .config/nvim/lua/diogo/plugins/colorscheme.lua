return {
  "luisiacc/gruvbox-baby",
  priority = 1000,
  config = function()
        vim.g.gruvbox_baby_function_style = "bold"
        vim.g.gruvbox_baby_use_original_palette = true
        vim.cmd("colorscheme gruvbox-baby")
  end,
}
