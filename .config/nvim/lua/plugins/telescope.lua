return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {}
		opts = {},
		keys = {
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
				end,
				desc = "Find Files (cwd)",
			},
			build = function()
				require('telescope').load_extension('media_files')
			end,
		},
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		lazy = true,
		opts = {
			extensions = {
				media_files = {
				  -- filetypes whitelist
				  -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
				  filetypes = {"png", "webp", "jpg", "jpeg"},
				  -- find command (defaults to `fd`)
				  find_cmd = "rg"
				}
			  },
		},
	},
}
