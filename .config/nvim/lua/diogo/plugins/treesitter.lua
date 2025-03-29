return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag"
    },
  config = function()

    require 'nvim-treesitter.install'.prefer_git = false    
        -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    require("nvim-treesitter.install").command_extra_args = {
      curl = { "--proxy", "http://http-proxy.dslocal.com:8080" },
    }
    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
        disable = {"rust", "python", "lua", "markdown"},
      },
      -- enable indentation
      indent = { enable = true },
      auto_install = false,
      -- ensure these language parsers are installed
      ensure_installed = {
        },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Tab>",
          node_incremental = "<Tab>",
          node_decremental = "<S-Tab>",
          scope_incremental = false,
        },
      },
    })
  end,
}
