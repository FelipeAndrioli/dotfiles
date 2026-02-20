vim.g.mapleader = " "

-- Open :Explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>hs", vim.cmd.split)

-- Move cursor x lines up/down
vim.keymap.set("n", "<C-j>", "10j", { desc = "move cursor x lines down" })
vim.keymap.set("n", "<C-k>", "10k", { desc = "move cursor x lines up" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "p", "p`[h", { noremap = true, desc = "Move the cursor to the beginning of buffer after pasting some text" })

-- LSP
--vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { silent = true, noremap = true})
