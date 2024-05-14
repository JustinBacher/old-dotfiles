return {
    {
        "monaqa/dial.nvim",
        config = function()
            -- Don't know why I need to specify keymaps like this and not as lazy keys but meh whatever
            local dial_map = require("dial.map")
            local map = vim.keymap.set
            local opts = { silent = true }
            map("n", "<C-a>", dial_map.inc_normal(), opts)
            map("n", "<C-x>", dial_map.dec_normal(), opts)
            map("x", "<C-a>", dial_map.inc_visual(), opts)
            map("x", "<C-x>", dial_map.dec_visual(), opts)
            map("x", "g<C-a>", dial_map.inc_gvisual(), opts)
            map("x", "g<C-x>", dial_map.dec_gvisual(), opts)
    
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
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
        }
      },
      {
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-telescope/telescope-media-files.nvim" }
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
		lazy = true,
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
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
    { "tenxsoydev/karen-yank.nvim", config = true },
}