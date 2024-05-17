return {
	{ "echasnovski/mini.cursorword", event = "VeryLazy", version = false, config = true },
	{ "echasnovski/mini.ai", event = "VeryLazy", version = false, config = true },
	{ "echasnovski/mini.pairs", event = "VeryLazy", version = false, config = true },
	{ "echasnovski/mini.indentscope", event = "VeryLazy", version = false, opts = { symbol = "▒" } },
	{
		"echasnovski/mini.map",
		version = false,
		event = "VeryLazy",
		keys = {
			{ "<leader>mm", "lua MiniMap.toggle()<cr>", desc = "Toggle MiniMap" },
		},
		config = function()
			local map = require("mini.map")
			map.setup({
				integrations = {
					map.gen_integration.builtin_search(),
					map.gen_integration.gitsigns(),
					map.gen_integration.diagnostic(),
				},
			})
		end,
	},
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		version = false,
		config = function()
			local mouse_scrolled = false
			for _, scroll in pairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			animate.setup({
				cursor = {
					timing = animate.gen_timing.quartic({ duration = 222, unit = "total" }),
					path = animate.gen_path.line(),
				},
				resize = { enable = false },
				scroll = { enable = false },
				-- scroll = {
				-- 	timing = animate.gen_timing.exponential({ duration = 100, unit = "total" }),
				-- 	subscroll = animate.gen_subscroll.equal({
				-- 		predicate = function(total_scroll)
				-- 			if mouse_scrolled then
				-- 				mouse_scrolled = false
				-- 				return false
				-- 			end
				-- 			return total_scroll > 1
				-- 		end,
				-- 	}),
				-- },
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		version = false,
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
			custom_surroundings = {
				["<"] = { output = { left = "<", right = ">" } },
			},
		}
	},
}
