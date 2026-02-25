return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        show_buffer_close_icons = true,
        show_close_icon = true,
        color_icons = true,
        view = "default",
        separator_style = "slant",
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        },
      }
    })
  end,
}
