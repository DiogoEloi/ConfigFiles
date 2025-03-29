vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("n", "<C-s>", ":wa<CR>", { desc = "Save the file", silent = true })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit the file", silent = true })
keymap.set("n", "<leader>jf", ":%!jq<CR>", { desc = "Json Format", silent = true })
vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>rn", ":set nornu<CR>")
