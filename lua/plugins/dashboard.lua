return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup({
      theme = 'doom',
      config = {
        header = {
          '',
          '',
          ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
          ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
          ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
          ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
          ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
          ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
          '',
          '           [ Code with passion, debug with patience ]',
          '',
          '',
        },
        center = {
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'New File                ',
            desc_hl = 'String',
            key = 'n',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'enew'
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Find File               ',
            desc_hl = 'String',
            key = 'f',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Telescope find_files'
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Recent Files            ',
            desc_hl = 'String',
            key = 'r',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Telescope oldfiles'
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Find Text               ',
            desc_hl = 'String',
            key = 'g',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Telescope live_grep'
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Config                  ',
            desc_hl = 'String',
            key = 'c',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'edit $MYVIMRC | cd %:p:h'
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Lazy                    ',
            desc_hl = 'String',
            key = 'l',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Lazy'
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Quit                    ',
            desc_hl = 'String',
            key = 'q',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'quit'
          },
        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { 
            '', 
            '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' 
          }
        end,
      },
      hide = {
        statusline = false,
        tabline = false,
        winbar = false,
      },
    })

    -- nvim aja, gk pakai .
    if vim.fn.argc() == 0 then
      -- Buka Neo-tree
      vim.cmd("Neotree show")
      vim.cmd("wincmd p")
    end

  end,
  dependencies = { 
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope.nvim', 
  }
}