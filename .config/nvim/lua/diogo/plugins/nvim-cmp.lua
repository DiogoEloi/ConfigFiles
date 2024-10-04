return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "hrsh7th/cmp-nvim-lsp", -- source for file system paths
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        luasnip.filetype_extend("typescriptreact", {"javascript", "javascriptreact"})

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },

            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                ["<C-y>"] = cmp.mapping.confirm({ 
                    select = true,
                    behavior = cmp.ConfirmBehavior.Replace
                }),

                ['<C-l>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, {'i', 's'}),

                ['<C-h>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'}),

            }),
            -- sources for autocompletion
            sources = cmp.config.sources(
                {
                    {
                        name = "nvim_lsp",
                        entry_filter = function(entry, ctx)
                            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },
                    { name = 'nvim_lsp_signature_help'},
                    { name = "path" }, -- file system paths
                    { name = "luasnip" }, -- snippets
                },
                {
                    { name = "buffer" }, -- text within current buffer
                }),

        })
    end,
}
