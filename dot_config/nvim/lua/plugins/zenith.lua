-- Zenith colorscheme plugin
---@type LazySpec
return {
	{
		dir = vim.fn.expand("~/.local/share/nvim/site/pack/zenith/start/zenith.nvim"),
		name = "zenith",
		lazy = false,
		priority = 1000,
		config = function()
			require("zenith").setup({
				dim_inactive = true,
				transparent = false,
			})
		end,
	},
}
