return {
	"folke/trouble.nvim",
	-- opts will be merged with the parent spec
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>xx",
			function()
				require("trouble").toggle()
			end,
			desc = "Toggle Trouble",
		},
		{
			"<leader>xw",
			function()
				require("trouble").toggle("workspace_diagnostics")
			end,
			desc = "Workspace Diagnostics",
		},
		{
			"<leader>xd",
			function()
				require("trouble").toggle("document_diagnostics")
			end,
			desc = "File Diagnostics",
		},
		{
			"<leader>xq",
			function()
				require("trouble").toggle("quickfix")
			end,
			desc = "Open Quick Fix",
		},
		{
			"<leader>xl",
			function()
				require("trouble").toggle("loclist")
			end,
			desc = "Open Location List",
		},
		{
			"gR",
			function()
				require("trouble").toggle("lsp_references")
			end,
			desc = "Lsp References",
		},
	},
}
