return {
	{ "echasnovski/mini.ai", event = "LazyFile", config = true },
	{
		"echasnovski/mini.surround",
		event = "LazyFile",
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
		},
	},
}
