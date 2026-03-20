---@type LazySpec
return {
	"AstroNvim/astroui",
	---@type AstroUIOpts
	opts = {
		colorscheme = "zenith",
		highlights = {
			init = {
				NeoTreeNormal   = { bg = "none" },
				NeoTreeNormalNC = { bg = "none" },
				StatusLine      = { bg = "none" },
				StatusLineNC    = { bg = "none" },
			},
		},
		icons = {
			LSPLoading1 = "⠋",
			LSPLoading2 = "⠙",
			LSPLoading3 = "⠹",
			LSPLoading4 = "⠸",
			LSPLoading5 = "⠼",
			LSPLoading6 = "⠴",
			LSPLoading7 = "⠦",
			LSPLoading8 = "⠧",
			LSPLoading9 = "⠇",
			LSPLoading10 = "⠏",
		},
		status = {
			separators = {
				none = { "", "" },
				left = { "", "" },
				right = { "", "" },
				center = { "  ", "  " },
				tab = { "", "" },
				breadcrumbs = "  ",
				path = "  ",
			},
			attributes = {
				buffer_active = { bold = true, italic = true },
				buffer_picker = { bold = true },
				macro_recording = { bold = true },
				git_branch = { bold = true },
				git_diff = { bold = true },
				mode = { bold = true },
			},
			icon_highlights = {
				breadcrumbs = false,
				file_icon = {
					tabline = function(self)
						return self.is_active or self.is_visible
					end,
					statusline = true,
					winbar = false,
				},
			},
			colors = function(colors)
				colors.normal        = "#b070e8"  -- zenith purple
				colors.bg            = "NONE"
				colors.section_bg    = "NONE"
				return colors
			end,
		},
	},
}
