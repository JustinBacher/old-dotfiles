return {
	"ziontee113/icon-picker.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>if", "<cmd>IconPickerNormal<cr>", desc = "Find Icon" },
		{ "<leader>iy", "<cmd>IconPickerYank<cr>", desc = "Yank Icon" },
	},
	opts = { disable_legacy_commands = true },
}