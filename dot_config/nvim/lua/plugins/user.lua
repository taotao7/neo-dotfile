-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {
	"andweeb/presence.nvim",
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{
		"folke/snacks.nvim",
		opts = {
			indent = {
				enabled = false,
			},
			dashboard = {
				preset = {
					header = table.concat({
						" ████████╗ █████╗  ██████╗       ███████╗",
						" ╚══██╔══╝██╔══██╗██╔═══██╗      ██╔════╝",
						"    ██║   ███████║██║   ██║█████╗███████╗",
						"    ██║   ██╔══██║██║   ██║╚════╝╚════██║",
						"    ██║   ██║  ██║╚██████╔╝      ███████║",
						"    ╚═╝   ╚═╝  ╚═╝ ╚═════╝       ╚══════╝",
					}, "\n"),
				},
			},
		},
	},

	-- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
	{
		"L3MON4D3/LuaSnip",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom luasnip configuration such as filetype extend or custom snippets
			local luasnip = require("luasnip")
			luasnip.filetype_extend("javascript", { "javascriptreact" })
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.nvim-autopairs")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom autopairs configuration such as custom rules
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			npairs.add_rules(
				{
					Rule("$", "$", { "tex", "latex" })
						-- don't add a pair if the next character is %
						:with_pair(cond.not_after_regex("%%"))
						-- don't add a pair if  the previous character is xxx
						:with_pair(
							cond.not_before_regex("xxx", 3)
						)
						-- don't move right when repeat character
						:with_move(cond.none())
						-- don't delete if the next character is xx
						:with_del(cond.not_after_regex("xx"))
						-- disable adding a newline when you press <cr>
						:with_cr(cond.none()),
				},
				-- disable for .vim files, but it work for another filetypes
				Rule("a", "a", "-vim")
			)
		end,
	},
	{
		"talha-akram/noctis.nvim",
		enabled = true,
	},
	{
		"p00f/alabaster.nvim",
		enabled = false,
	},
	{
		"rebelot/heirline.nvim",
		opts = function(_, opts)
			opts.winbar = nil
			local status = require("astroui.status")
			opts.statusline[1] = status.component.mode({ padding = { left = 1, right = 1 } })
			table.insert(opts.statusline, 2, { provider = " ", hl = { bg = "NONE" } })
			opts.statusline[#opts.statusline] =
				status.component.mode({ surround = { separator = "right" }, padding = { left = 1, right = 1 } })
		end,
	},
	{
		"taotao7/i18n.nvim",
		-- dir = "/Users/tao/tool/i18n.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		branch = "main",
		enabled = true,
		config = function()
			require("i18n").setup({
				func_pattern = {
					"t",
					"$t",
					{ call = "i18n.t" },
				},
				func_type = { "vue", "typescript" },
				usage = { popup_type = "snacks" },
				show_mode = "translation_conceal",
			})
		end,
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			-- Smear cursor when switching buffers or windows.
			smear_between_buffers = true,

			-- Smear cursor when moving within line or to neighbor lines.
			-- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
			smear_between_neighbor_lines = true,

			-- Draw the smear in buffer space instead of screen space when scrolling
			scroll_buffer_space = true,

			-- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
			-- Smears and particles will look a lot less blocky.
			legacy_computing_symbols_support = false,

			-- Smear cursor in insert mode.
			-- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
			smear_insert_mode = true,
			vertical_bar_cursor_insert_mode = true,
			max_length_insert_mode = 8,
			stiffness_insert_mode = 0.55,
			trailing_stiffness_insert_mode = 0.42,
			damping_insert_mode = 0.92,
			distance_stop_animating_vertical_bar = 0.2,
			delay_event_to_smear = 0,
			delay_after_key = 3,
		},
	},
	{
		"tribela/vim-transparent",
		enabled = true,
	},
	{
		"folke/sidekick.nvim",
		opts = {
			-- add any options here
			cli = {
				mux = {
					backend = "tmux",
					enabled = true,
				},
			},
		},
		keys = {
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if require("sidekick").nes_jump_or_apply() then
						return -- jumped or applied
					end

					-- if you are using Neovim's native inline completions
					if vim.lsp.inline_completion.get() then
						return
					end

					-- any other things (like snippets) you want to do on <tab> go here.

					-- fall back to normal tab
					return "<tab>"
				end,
				mode = { "i", "n" },
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-.>",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>aa",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle CLI",
			},
			{
				"<leader>as",
				function()
					require("sidekick.cli").select()
				end,
				-- Or to select only installed tools:
				-- require("sidekick.cli").select({ filter = { installed = true } })
				desc = "Select CLI",
			},
			{
				"<leader>ad",
				function()
					require("sidekick.cli").close()
				end,
				desc = "Detach a CLI Session",
			},
			{
				"<leader>at",
				function()
					require("sidekick.cli").send({ msg = "{this}" })
				end,
				mode = { "x", "n" },
				desc = "Send This",
			},
			{
				"<leader>af",
				function()
					require("sidekick.cli").send({ msg = "{file}" })
				end,
				desc = "Send File",
			},
			{
				"<leader>av",
				function()
					require("sidekick.cli").send({ msg = "{selection}" })
				end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>ap",
				function()
					require("sidekick.cli").prompt()
				end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
			-- Example of a keybinding to open Claude directly
			{
				"<leader>ac",
				function()
					require("sidekick.cli").toggle({ name = "claude", focus = true })
				end,
				desc = "Sidekick Toggle Claude",
			},
			{
				"<leader>ao",
				function()
					require("sidekick.cli").toggle({ name = "opencode", focus = true })
				end,
				desc = "Sidekick Toggle opencode",
			},
		},
	},
}
