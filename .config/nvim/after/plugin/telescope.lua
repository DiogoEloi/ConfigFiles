-- require('telescope').load_extension('harpoon')
-- require('telescope').load_extension('git_worktree')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local function flash(prompt_bufnr)
  require("flash").jump({
    pattern = "^",
    label = { after = { 0, 0 } },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  })
end
require('telescope').setup {
  defaults = {
    pickers = {
      find_files = {
        theme = "dropdown",
        hidden = true,
      },
    },
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<A-j>"] = require('telescope.actions').preview_scrolling_down,
        ["<A-k>"] = require('telescope.actions').preview_scrolling_up,
        ["<c-s>"] = flash ,
      },
      n = { s = flash },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      }
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

require("telescope").load_extension("ui-select")

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>s', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = true,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>tw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>tg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>tb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- GIT
vim.keymap.set('n', '<leader>tf', require('telescope.builtin').git_files, { desc = '[S]earch on Git repo' })
vim.keymap.set('n', '<leader>gu', require('telescope.builtin').git_status, { desc = '' })

vim.keymap.set('n', '<leader>gl', function()
  require("telescope.builtin").git_commits({
    git_command = { "git", "log", "--pretty=%h -- %an: %s [%ch]"}
  })
end, { desc = '[/] Git log ]' })

vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_stash)
vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches)


vim.api.nvim_set_keymap("n", "st", ":TodoTelescope<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>", {noremap=false})
