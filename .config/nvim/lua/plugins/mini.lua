return {
	{
		"echasnovski/mini.ai",
		version = false,
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = false,
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		opts = { symbol = "" },
	},
	{
		"echasnovski/mini.map",
		version = false,
		keys = {
			{
				"<leader>mm",
				function()
					require("mini.map").toggle()
				end,
				desc = "Toggle MiniMap",
			},
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
			local animate = require("mini.animate")

			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			animate.setup({
				cursor = {
					timing = animate.gen_timing.exponential({ duration = 200, unit = "total" }),
					path = animate.gen_path.angle(),
				},
				resize = { enable = false },
				scroll = {
					timing = animate.gen_timing.cubic({ duration = 10, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "<leader>sa", -- Add surrounding in Normal and Visual modes
					delete = "<leader>sd", -- Delete surrounding
					find = "<leader>sf", -- Find surrounding (to the right)
					find_left = "<leader>sF", -- Find surrounding (to the left)
					highlight = "<leader>sh", -- Highlight surrounding
					replace = "<leader>sr", -- Replace surrounding
					update_n_lines = "<leader>sn", -- Update `n_lines`
				},
				custom_surroundings = {
					["<"] = { output = { left = "<", right = ">" } },
				},
			})
		end,
	},
}
