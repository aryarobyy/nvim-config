return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
	local configs = require("nvim-treesitter")
	configs.setup({
	    highlight = {
		enable = true,
	    },
	    indent = {
		enable = true,
	    },
	    -- autotag = { enable = true },
	    ensure_installed = {
		"lua",
		"vim",
		"jsx",
		"vimdoc",
		"tsx",
		"typescript",
		"go",
		"javascript",
		"dart",
		"html",
		"css",
	    },
	    auto_install = false
	})
    end
}