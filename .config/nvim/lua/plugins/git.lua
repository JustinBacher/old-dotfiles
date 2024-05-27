local function git_commit_current_buffer()
	vim.ui.input({prompt = "Message"}, function (message)
		if message == "" then print("No commit performed") end
		-- local path = vim.split(vim.fn.expand('%'), "/")
		-- local filename = table.remove(path, #path)
		vim.cmd("Git add " .. vim.fn.expand('%'))
		vim.cmd("Git commit  --message=" .. '"' .. message .. '"')

		-- vim.cmd("Git commit " .. message)
	end)
end
return {
	{
		"tpope/vim-fugitive",
		cmd = "Git",
		keys = {
			{ "<leader>gc", git_commit_current_buffer, desc = "Git add current file" },
		},
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
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
