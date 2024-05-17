return {
	-- Themes
	-- TODO: Figure out if I can turn lazy to true for all but current theme
	{
		"Mofiqul/dracula.nvim",
		name = "dracula",
		priority = 1000,
		opts = { transparent_bg = true, italic_comment = true },
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		opts = {
			transparent = true,
			on_highlights = function(hl, c) --- @diagnostic disable-line: unused-local
				hl.MiniCursorword = { underline = true }
				hl.MiniCursorwordCurrent = { underline = true }
			end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = { transparent_background = true },
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		opts = { extend_background_behind_borders = false, styles = { transparency = true } },
	},

	-- Themery - Theme Picker
	{
		"zaldih/themery.nvim",
		cmd = "Themery",
		config = function()
			local status_ok, themery = pcall(require, "themery")
			if not status_ok then
				return
			end
			themery.setup({
				themes = {
					{ name = "Dracula Dark",         colorscheme = "dracula" },
					{ name = "Dracula Soft",         colorscheme = "dracula-soft" },
					{ name = "Tokyonight Storm",     colorscheme = "tokyonight-night" },
					{ name = "Tokyonight Night",     colorscheme = "tokyonight-night" },
					{ name = "Tokyonight Moon",      colorscheme = "tokyonight-moon" },
					{ name = "Catppuccin Mocha",     colorscheme = "catppuccin-mocha" },
					{ name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
					{ name = "Rose Pine Moon",       colorscheme = "rose-pine-moon" },
				},
				themeConfigFile = "~/dotfiles/.config/nvim/lua/config/theme.lua",
				livePreview = true,
			})
		end,

		keys = {
			{ "<leader>t", "<cmd>:Themery<cr>", desc = "Open Theme Picker" },
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "VeryLazy",
		opts = {
			render = "virtual",
			virtual_symbol = "",
			enable_tailwind = true,
		},
	},
}
