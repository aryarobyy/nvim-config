local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = nil })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = nil })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = nil })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = nil })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = nil })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = nil })
    
    -- NeoTree transparency
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = nil })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = nil })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = nil })
end

return {
    {
	"folke/tokyonight.nvim",
	config = function()
	    vim.cmd.colorscheme "tokyonight"
	    vim.opt.termguicolors = true
	    enable_transparency()
	end
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
	opts = {
	    theme = 'tokyonight',
	}
    },
}