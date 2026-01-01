return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({ 
      'go', 
      'lua', 
      'javascript', 
      'typescript', 
      'tsx',
      'html',
      'css' 
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 
        'go', 
        'lua', 
        'javascript', 
        'typescript', 
        'typescriptreact', 
        'html', 
        'css' 
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}