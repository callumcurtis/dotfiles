vim.g.mapleader = " "

local keymap = vim.keymap

-- save/quit
keymap.set("n", "<leader>w", ":w ++p<CR>", { desc = "Write the buffer to the current file" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit the current window" })
keymap.set("n", "<leader>Q", ":q!<CR>", { desc = "Force quit the current window" })

-- highlight
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- split management
keymap.set("n", "<leader>ss", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })

-- tab management
keymap.set("n", "<leader>tt", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tb", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })

-- jump list
keymap.set("n", "<C-i>", "<C-S-i>") -- avoids conflict between <TAB> and <C-i>

-- paste
keymap.set('i', '<C-p>', '<C-r>+', { desc = "Paste from system clipboard" })
keymap.set('i', '<C-n>', '<Nop>', { desc = "Disable default CTRL-N" })
keymap.set('x', 'p', 'P', { desc = "Paste without yanking" })
keymap.set('x', 'P', 'p', { desc = "Swap selection with register" })

-- page up/down
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-f>", "<C-f>zz")
keymap.set("n", "<C-b>", "<C-b>zz")

-- yank relative file path
keymap.set("n", "<leader>yp", ":let @+ = expand('%')<CR>", { desc = "Yank relative file path", silent = true })

