return {
    "tpope/vim-fugitive",
    config = function()
        local keymap = vim.keymap -- for conciseness
        -- Git keybinds / fugitive keybinds
        keymap.set("n", "<leader>gf", ":G<CR>", {silent = true}) -- open Git view
        -- keymap.set("n", "<leader>gsc", ":Gwrite | :G commit<CR>") -- git stage and commit
        -- keymap.set("n", "<leader>gg", ":Gwrite | :G commit<CR>") -- git stage and commit
        -- keymap.set("n", "<leader>gs", ":Gwrite <CR>") -- git stage
        -- keymap.set("n", "<leader>ga", ":G add --all -- ':!src/content/*' ':!.gitignore' | :G commit<CR>") -- git stage all (except commonly ignored)
        -- keymap.set("n", "<leader>gc", ":G commit<CR>") -- git commit
        -- keymap.set("n", "<leader>gp", ":G push<CR>") -- git push
    end,
}
