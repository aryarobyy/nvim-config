return {
  'stevearc/conform.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        
        dart = { "dart_format" },
        
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        
        lua = { "stylua" },
      },
      
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
      
      -- formatters = {
      --   prettier = {
      --     prepend_args = { 
      --       "--plugin=prettier-plugin-tailwindcss" 
      --     },
      --   },
      -- },
      
      notify_on_error = true,
      notify_no_formatters = true,
    })

vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', function()
  vim.cmd('stopinsert')
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
  
  require("conform").format({ 
    lsp_format = "fallback",
    timeout_ms = 1000,
  })
  vim.cmd('write')
  print('✓ Saved and formatted!')
end, { noremap = true, silent = true })

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
  end,
}