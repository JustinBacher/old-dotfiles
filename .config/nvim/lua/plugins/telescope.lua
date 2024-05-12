return {
	"nvim-telescope/telescope.nvim",
	opts = {},
	keys = {
		{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
		{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
		{
			"<leader>ff",
			function()
				local builtin = require("telescope.builtin")
				local utils = require("telescope.utils")
				builtin.find_files({ cwd = utils.buffer_dir() })
			end,
			desc = "Find Files (cwd)",
		},
	},
}
