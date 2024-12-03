vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("n", "<C-s>", ":wa<CR>", { desc = "Save the file" })
vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>")
