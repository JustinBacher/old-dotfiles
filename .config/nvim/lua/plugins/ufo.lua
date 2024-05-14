return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	init = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	keys = {
		{ "zR", "<cmd>require('ufo').openAllFolds<cr>", desc = "Open all folds" },
		{ "zM", "<cmd>require('ufo').closeAllFolds<cr>", desc = "Close all folds" },
		{
			"zK",
			function()
				if not require("ufo").peekFoldedLinesUnderCursor() then
					vim.lsp.buf.hover()
				end
			end,
			desc = "Peek Fold",
		},
	},

	opts = {
		provider_selector = function(bufnr, filetype, buftype) ---@diagnostic disable-line: unused-local
			return { "lsp", "indent" }
		end,
	},
}
