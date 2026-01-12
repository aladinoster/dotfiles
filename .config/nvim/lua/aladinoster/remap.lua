--- set key mapping for opening the file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Custom escape mapping in insert, visual, and command modes
vim.keymap.set("i", "kj", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("v", "kj", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("c", "kj", "<C-C>", { noremap = true, silent = true })

-- Keymaps special for DBUI
vim.keymap.set("i", "KJ", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("v", "KJ", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("c", "KJ", "<C-C>", { noremap = true, silent = true })

-- Remap launch DBUI
vim.keymap.set("n", "<leader>D", ":DBUI<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>D", ":DBUI<CR>", { noremap = true, silent = true })

-- Center the screen on vertical movements
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

-- Center search terms
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Modifies J
vim.keymap.set("n", "J", "mzJ`z")

-- Modifies format
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })

-- Pastes on clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Allow replacements of selected words
vim.keymap.set(
	"n",
	"<leader>S",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor (case-insensitive)" }
)

-- Allow to chmod files
vim.keymap.set("n", "<leader>x", "<cmd>! chmod +x %<CR>", { silent = true })
