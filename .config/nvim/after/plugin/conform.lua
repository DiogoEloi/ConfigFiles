require("conform").setup({
 formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    graphql = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 1500,
    -- lsp_format = "fallback",
    async = true
  },
})
