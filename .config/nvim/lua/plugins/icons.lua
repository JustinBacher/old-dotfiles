return {
	"ziontee113/icon-picker.nvim",
	event = "VeryLazy",
	opts = { disable_legacy_commands = true },
	keys = {
		{ "<leader>if", "<cmd>IconPickerNormal<cr>", desc = "Find Icon", noremap = true, silent = true },
		{ "<leader>iy", "<cmd>IconPickerYank<cr>", desc = "Yank Icon", noremap = true, silent = true },
		{
			"<localleader>if",
			"<cmd>IconPickerInsert<cr>",
			desc = "Insert Icon",
			mode = "i",
			noremap = true,
			silent = true,
		},
	},
}
