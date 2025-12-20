local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'lua', 'javascript', 'typescript' },
  callback = function() 
    vim.treesitter.start() 
  end,
})

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = { notify = false },
})

vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local is_empty = bufname == ""
    local is_directory = vim.fn.isdirectory(bufname) == 1

    if is_empty or is_directory then
      if is_directory and vim.api.nvim_buf_is_valid(0) then
        vim.api.nvim_buf_delete(0, { force = true })
      end

      vim.schedule(function()
        vim.cmd("Dashboard")
      end)
    end
  end
})