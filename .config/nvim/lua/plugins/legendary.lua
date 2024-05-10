return {
	"mrjones2014/legendary.nvim",
	enabled = true,
	-- since legendary.nvim handles all your keymaps/commands,
	-- its recommended to load legendary.nvim before other plugins
	priority = 10000,
	lazy = false,
	-- sqlite is only needed if you want to use frecency sorting
	-- dependencies = { 'kkharji/sqlite.lua' }
	keys = {
		{ "<C-p>", "<cmd>Legendary<cr>", desc = "Open Legendary to show all available options" },
		{ "<C-A-p>", "<cmd>Legendary keymaps<cr>", desc = "Find Keymaps" },
		{ "<C-M-p>", "<cmd>Legendary commands<cr>", desc = "NeoTree" },
	},
	opts = {
		extensions = { lazy_nvim = true },
	},
}
