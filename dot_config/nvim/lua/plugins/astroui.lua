---@type LazySpec
return {
	"AstroNvim/astroui",
	---@type AstroUIOpts
	opts = {
		highlights = {
			init = {
				-- 基础
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
				Pmenu = { bg = "none" },
				PmenuSbar = { bg = "none" },
				-- NeoTree
				NeoTreeNormal = { bg = "none" },
				NeoTreeNormalNC = { bg = "none" },
				-- StatusLine
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },
				TabLineFill = { bg = "none" },
				-- Snacks Picker (文件搜索)
				SnacksPicker = { bg = "none" },
				SnacksPickerBorder = { bg = "none" },
				SnacksPickerList = { bg = "none" },
				SnacksPickerListBorder = { bg = "none" },
				SnacksPickerPreview = { bg = "none" },
				SnacksPickerPreviewBorder = { bg = "none" },
				SnacksPickerInput = { bg = "none" },
				SnacksPickerInputBorder = { bg = "none" },
				SnacksPickerBoxBorder = { bg = "none" },
				-- blink.cmp (补全菜单)
				BlinkCmpMenu = { bg = "none" },
				BlinkCmpMenuBorder = { bg = "none" },
				BlinkCmpDoc = { bg = "none" },
				BlinkCmpDocBorder = { bg = "none" },
				BlinkCmpSignatureHelp = { bg = "none" },
				BlinkCmpSignatureHelpBorder = { bg = "none" },
				-- Noice (命令行弹窗)
				NoiceCmdlinePopup = { bg = "none" },
				NoiceCmdlinePopupBorder = { bg = "none" },
				NoicePopup = { bg = "none" },
				NoicePopupBorder = { bg = "none" },
				-- WhichKey
				WhichKeyFloat = { bg = "none" },
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
				colors.normal = "#b070e8" -- zenith purple
				colors.bg = "NONE"
				colors.section_bg = "NONE"
				return colors
			end,
		},
	},
}
