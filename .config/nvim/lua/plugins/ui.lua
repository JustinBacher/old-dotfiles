return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				RainbowRed = "#E06C75",
				RainbowYellow = "#E5C07B",
				RainbowBlue = "#61AFEF",
				RainbowOrange = "#D19A66",
				RainbowGreen = "#98C379",
				RainbowViolet = "#C678DD",
				RainbowCyan = "#56B6C2",
			}
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				for hl, color in pairs(highlight) do
					vim.api.nvim_set_hl(0, hl, { fg = color })
				end
			end)
			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight } })

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	{
		"folke/trouble.nvim",
		event = "LazyFile",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>dx", "<Cmd>Trouble<CR>", desc = "Toggle Trouble" },
			{ "<leader>dw", function() require("trouble").toggle("workspace_diagnostics") end },
			{ "<leader>dd", function() require("trouble").toggle("document_diagnostics") end },
			{ "<leader>dq", function() require("trouble").toggle("quickfix") end },
			{ "<leader>dl", function() require("trouble").toggle("loclist") end },
			{ "gR", function() require("trouble").toggle("lsp_references") end },
			{
				"<leader>dn",
				function() require("trouble").next({ skip_groups = true, jump = true }) end,
				desc = "Goto next workspace diagnostic",
			},
			{
				"<leader>dp",
				function() require("trouble").previous({ skip_groups = true, jump = true }) end,
				desc = "Goto next workspace diagnostic",
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				hover = { enabled = false },
				signature = { enabled = false },
				override = {
					-- ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					-- ["vim.lsp.util.stylize_markdown"] = true,
					-- ["config.lsp.signature.enabled"] = true,
					-- ["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			views = {
				cmdline_popup = {
					position = { row = 5, col = "50%" },
					size = { width = 60, height = "auto" },
				},
				popupmenu = {
					relative = "editor",
					position = { row = 8, col = "50%" },
					size = { width = 60, height = 10 },
					border = { style = "rounded", padding = { 0, 1 } },
					win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
				},
			},
			routes = { { view = "notify", filter = { event = "msg_showmode" } } },
		},
	},
	{ "stevearc/dressing.nvim", config = true },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"letieu/harpoon-lualine",
			"folke/noice.nvim",
		},
		event = "LazyFile",
		opts = {
			options = {
				theme = "tokyonight",
				component_separators = { left = "▒", right = "▒" },
				section_separators = {},
			},
			sections = {
				lualine_a = {
					function()
						return {
							require("noice").api.status.mode.get_hl, --- @diagnostic disable-line: undefined-field
							cond = require("noice").api.status.mode.has, --- @diagnostic disable-line: undefined-field
						}
					end,
				},
				lualine_b = { "diff", "diagnostics" },
				lualine_c = { "harpoon2" },
				lualine_x = {},
				lualine_y = { "filetype", "progress" },
				lualine_z = { { "location", left_padding = 2 } },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		},
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function() require("alpha").setup(require("alpha.themes.dashboard").config) end,
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>nd",
				function() require("notify").dismiss({ silent = true, pending = true }) end,
				desc = "Dismiss All Notifications",
			},
			{ "<leader>nh", "<cmd>Telescope notify<cr>", desc = "Notification History" },
		},
		opts = {
			stages = "slide",
			render = "compact",
			background_colour = "FloatShadow",
			top_down = false,
			timeout = 3000,
			max_height = function() return math.floor(vim.o.lines * 0.75) end,
			max_width = function() return math.floor(vim.o.columns * 0.75) end,
			on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end,
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				--- @diagnostic disable-next-line: unused-local
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						s = s .. n .. e == "error" and " " or (e == "warning" and " " or "")
					end
					return s
				end,
			},
		},
	},

	{
		"folke/trouble.nvim",
		event = "LazyFile",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = { use_diagnostic_signs = true },
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["config.lsp.signature.enabled"] = true,
					-- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			views = {
				cmdline_popup = {
					position = { row = 5, col = "50%" },
					size = { width = 60, height = "auto" },
				},
				popupmenu = {
					relative = "editor",
					position = { row = 8, col = "50%" },
					size = { width = 60, height = 10 },
					border = { style = "rounded", padding = { 0, 1 } },
					win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
				},
			},
			routes = { { view = "notify", filter = { event = "msg_showmode" } } },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{ "letieu/harpoon-lualine", dependencies = { "ThePrimeagen/harpoon" } },
		},
		opts = {
			options = {
				theme = "tokyonight",
				component_separators = { left = "▒", right = "▒" },
				section_separators = {},
			},
			sections = {
				lualine_a = { { "mode", right_padding = 2 } },
				lualine_b = { "diff", "diagnostics" },
				lualine_c = { "harpoon2" },
				lualine_x = {},
				lualine_y = { "filetype", "progress" },
				lualine_z = { { "location", left_padding = 2 } },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		},
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function() require("alpha").setup(require("alpha.themes.dashboard").config) end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		keys = {
			{
				"<leader>nd",
				function() require("notify").dismiss({ silent = true, pending = true }) end,
				desc = "Dismiss All Notifications",
			},
			{ "<leader>nh", "<cmd>Telescope notify<cr>", desc = "Notification History" },
		},
		opts = {
			stages = "slide",
			render = "compact",
			background_colour = "FloatShadow",
			top_down = false,
			timeout = 3000,
			max_height = function() return math.floor(vim.o.lines * 0.75) end,
			max_width = function() return math.floor(vim.o.columns * 0.75) end,
			on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end,
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = false,
		enabled = false, -- TODO: Disable until I find out if I still need with coq setup
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				--- @diagnostic disable-next-line: unused-local
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " " or (e == "warning" and " " or "")
						s = s .. n .. sym
					end
					return s
				end,
			},
		},
	},
}
