-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Esc mapping in insert, visual, command modes
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', { noremap= true, silent= true})
vim.api.nvim_set_keymap('v', 'kj', '<ESC>', { noremap= true, silent= true})
vim.api.nvim_set_keymap('c', 'kj', '<C-C>', { noremap= true, silent= true})

-- Setting timeout for escaping
vim.opt.timeoutlen = 1500

-- Set the vertical movements
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
