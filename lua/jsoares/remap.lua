-- Setting mapleader to space
vim.g.mapleader = " "

-- Open netrw (file tree)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Toggle netrw " })

-- Keep selection after moving up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Keep cursor position when joining line below
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })

-- Keep cursor in middle of screen when navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous" })

-- Paste register into current selection (replaces it)
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste register into selection" })

-- Copy to system register with leader
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy to system register" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy until end of line to system register" })

-- Delete selection without putting it into the register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete selection without putting it into the register" })

-- Get rid of useless Q mapping
vim.keymap.set("n", "Q", "<nop>", { desc = "Get rid of useless Q mapping" })

-- Tmux sessionizer (TODO)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tms<CR>", { desc = "Tmux sessionizer" })

-- Format current buffer
vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { desc = "Format current buffer" })

-- Error navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next error" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous error" })

-- Local error navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next local error" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous local error" })

-- Replace current word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace current word under cursor" })

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

-- Select all
vim.keymap.set("n", "<leader>a", "ggvG", { desc = "Select all" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<cmd>echo 'Use k to move!!'<CR>", { desc = "Disable arrow keys in normal mode" })
vim.keymap.set("n", "<Down>", "<cmd>echo 'Use j to move!!'<CR>", { desc = "Disable arrow keys in normal mode" })
vim.keymap.set("n", "<Left>", "<cmd>echo 'Use h to move!!'<CR>", { desc = "Disable arrow keys in normal mode" })
vim.keymap.set("n", "<Right>", "<cmd>echo 'Use l to move!!'<CR>", { desc = "Disable arrow keys in normal mode" })
