-- require('telescope').load_extension('harpoon')
-- require('telescope').load_extension('git_worktree')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
    defaults = {
        pickers = {
            find_files = {
                theme = "dropdown",
                hidden = true,
            }
        },
        mappings = {
            i = {
                ['<C-u>'] = false,
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<C-d>"] = require('telescope.actions').move_selection_previous,
            },
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
vim.keymap.set('n', '<leader>t', require('telescope.builtin').git_files, { desc = '[S]earch on Git repo' })
vim.keymap.set('n', '<leader>tb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>tS', require('telescope.builtin').git_status, { desc = '' })

vim.api.nvim_set_keymap("n", "st", ":TodoTelescope<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>", {noremap=false})
