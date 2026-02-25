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

-- Run Python file (Leader+r) 
vim.keymap.set('n', '<leader>r', function()
    local file = vim.fn.expand('%')
    if file:match('%.py$') then
        local venv_python = vim.fn.getcwd() .. '/.venv/Scripts/python.exe'
        local venv_python_alt = vim.fn.getcwd() .. '/venv/Scripts/python.exe'
        
        local python_cmd = 'python'
        if vim.fn.filereadable(venv_python) == 1 then
            python_cmd = venv_python
            vim.notify('Using virtual environment: .venv', vim.log.levels.INFO)
        elseif vim.fn.filereadable(venv_python_alt) == 1 then
            python_cmd = venv_python_alt
            vim.notify('Using virtual environment: venv', vim.log.levels.INFO)
        end

        vim.cmd('vsplit | terminal ' .. python_cmd .. ' ' .. file)
    else
        vim.notify('Not a python file', vim.log.levels.WARN)
    end
end, { desc = 'Run Python file' })


vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { desc = 'Previous buffer', silent = true })
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = 'Close buffer', silent = true })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})
