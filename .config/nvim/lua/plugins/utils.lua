return {
	{ "windwp/nvim-autopairs", config = true },
	{ "tenxsoydev/karen-yank.nvim", event = "LazyFile", config = true },
	{
		"Shatur/neovim-session-manager",
		lazy = false,
		opts = {autoload_mode = false},
		build = function()
			-- Auto save session
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				callback = function()
					local session_manager = require("session_manager")
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						-- Don't save while there's any 'nofile' buffer open.
						if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then return end
					end
					session_manager.save_current_session()
				end,
			})
		end,
	},
	{
		"monaqa/dial.nvim",
		keys = { "<C-a>", "<C-x>", mode = { "n", "x" } },
		config = function()
			-- Don't know why I need to specify keymaps like this and not as lazy keys but meh whatever
			local dial_map = require("dial.map")
			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }
			map("n", "<C-a>", dial_map.inc_normal(), opts)
			map("n", "<C-x>", dial_map.dec_normal(), opts)
			map("x", "<C-a>", dial_map.inc_visual(), opts)
			map("x", "<C-x>", dial_map.dec_visual(), opts)
			map("x", "g<C-a>", dial_map.inc_gvisual(), opts)
			map("x", "g<C-x>", dial_map.dec_gvisual(), opts)

			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				---@type table<( Augend | AugendConstant )>
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.date.alias["%Y-%m-%d"],
					augend.date.alias["%m/%d"],
					augend.date.alias["%H:%M"],
					augend.semver.alias.semver,
					augend.constant.alias.bool,
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			window = {
				border = "shadow",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-telescope/telescope-media-files.nvim" },
		cmd = "Telescope",
		keys = {
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
			{
				"<leader>ff",
				function() require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() }) end,
				desc = "Find Files (cwd)",
			},
		},
		build = function()
			local load = require("telescope").load_extension
			load("media_files")
			load("noice")
		end,
		config = true,
	},
}
