vim.g.mapleader = " "

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Select All (Ctrl+A)
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('i', '<C-a>', '<Esc>ggVG', { desc = 'Select all' })
vim.keymap.set('v', '<C-a>', '<Esc>ggVG', { desc = 'Select all' })

-- Copy (Ctrl+C)
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to clipboard' })

-- Paste (Ctrl+V)
vim.keymap.set('n', '<C-v>', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set('i', '<C-v>', '<Esc>"+pa', { desc = 'Paste from clipboard' })
vim.keymap.set('v', '<C-v>', '"+p', { desc = 'Paste from clipboard' })

-- Cut (Ctrl+X)
vim.keymap.set('v', '<C-x>', '"+d', { desc = 'Cut to clipboard' })

-- Ctrl+S
vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true, desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { silent = true, desc = 'Save and exit insert mode' })
vim.keymap.set('v', '<C-s>', '<Esc>:w<CR>', { silent = true, desc = 'Save and exit visual mode' })