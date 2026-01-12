-- Flat cursor
vim.opt.guicursor = ""

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set timeout for escape mapping
vim.opt.timeoutlen = 1500

-- Identations
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search coloring
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Scroll limits
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Add rulers
vim.opt.colorcolumn = "80,100"
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#282828", ctermbg = 100 })
