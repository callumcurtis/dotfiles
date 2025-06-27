vim.g.mapleader = " "

local keymap = vim.keymap

-- motions
keymap.set("n", "<leader>h", "^", { desc = "First non-blank character of the line" })
keymap.set("n", "<leader>l", "$", { desc = "End of the line" })

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

