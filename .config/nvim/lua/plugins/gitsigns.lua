return {
	{
		"tpope/vim-fugitive",
		keys = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>gp", "<cmd>GitSigns preview_hunk<cr>", desc = "Preview Hunk" },
		},
	},
}
