-- Maybe add https://github.com/stevearc/dressing.nvim if it's useful

return {
	{
		"folke/edgy.nvim",
		enabled = false,
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
			bottom = {
				-- toggleterm / lazyterm at the bottom with a height of 40% of the screen
				{
					ft = "toggleterm",
					size = { height = 0.4 },
					-- exclude floating windows
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				{
					ft = "lazyterm",
					title = "LazyTerm",
					size = { height = 0.4 },
					filter = function(buf)
						return not vim.b[buf].lazyterm_cmd
					end,
				},
				"Trouble",
				{ ft = "qf", title = "QuickFix" },
				{
					ft = "help",
					size = { height = 20 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{ ft = "spectre_panel", size = { height = 0.4 } },
			},
			left = {
				-- Neo-tree filesystem always takes half the screen height
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					size = { height = 0.5 },
				},
				{
					title = "Neo-Tree Git",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "git_status"
					end,
					pinned = true,
					open = "Neotree position=right git_status",
				},
				{
					title = "Neo-Tree Buffers",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					pinned = true,
					open = "Neotree position=top buffers",
				},
				{
					ft = "Outline",
					pinned = true,
					open = "SymbolsOutlineOpen",
				},
				-- any other neo-tree windows
				"neo-tree",
			},

			exit_when_last = true,
		},
	},

	--    _ __ ___     ___     __| | (_)   ___    __ _  | |_    ___    _ __       _ __   __   __ (_)  _ __ ___
	--   | '_ ` _ \   / _ \   / _` | | |  / __|  / _` | | __|  / _ \  | '__|     | '_ \  \ \ / / | | | '_ ` _ \
	--   | | | | | | | (_) | | (_| | | | | (__  | (_| | | |_  | (_) | | |     _  | | | |  \ V /  | | | | | | | |
	--   |_| |_| |_|  \___/   \__,_| |_|  \___|  \__,_|  \__|  \___/  |_|    (_) |_| |_|   \_/   |_| |_| |_| |_|
	--
	--[[ Not going to activate this until I know it won't mess with themes
    {
        'mawkler/modicator.nvim',
        dependencies = 'mawkler/onedark.nvim', -- Add your colorscheme plugin here
        init = function()
          -- These are required for Modicator to work
          vim.o.cursorline = true
          vim.o.number = true
          vim.o.termguicolors = true
        end,
        opts = {
          -- Warn if any required option above is missing. May emit false positives
          -- if some other plugin modifies them, which in that case you can just
          -- ignore. Feel free to remove this line after you've gotten Modicator to
          -- work properly.
          show_warnings = true,
        }
      }
      ]]
	--
}
