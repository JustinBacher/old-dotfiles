return {
	-- Themes
	{ "catppuccin/nvim", lazy = false, name = "catppuccin", priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
	{ "rose-pine/neovim", lazy = false, name = "rose-pine", priority = 1000 },
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		name = "dracula",
		priority = 1000,
		opts = {
			colorscheme = "dracula-soft",
		},
	},
	-- Themery - Theme Picker
	{
		"zaldih/themery.nvim",
		enabled = false,
		themes = { "dracula", "tokyonight", "catppuccin", "" }, -- Your list of installed colorschemes
		themeConfigFile = "~/.config/nvim/lua/config/theme.lua",
		keys = {
			{ "<leader>t", "<cmd>:Themery<cr>", desc = "Open Theme Picker" },
		},
	},
}
