return {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    lazy = false,
    opts = {
        bind = true,
        hint_enable = true,
        floating_window = false,
        handler_opts = {
            border = "rounded"
        },
        hint_prefix = "🐼 ",
    },
    config = function(_, opts) require'lsp_signature'.setup(opts) end
}

