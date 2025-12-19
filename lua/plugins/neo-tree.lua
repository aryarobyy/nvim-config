return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, 
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            "node_modules"
          },
        },
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "none",
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
    })
    
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neo-tree', silent = true })
    vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', { desc = 'Focus Neo-tree', silent = true })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
    vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
  end,
}