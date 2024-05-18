return {
	{
		"tpope/vim-fugitive",
		keys = {},
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		keys = {
			{ "<leader>gp", "<cmd>GitSigns preview_hunk<cr>", desc = "Preview Hunk" },
		},
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
